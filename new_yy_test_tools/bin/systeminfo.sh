#!/bin/bash

fpath=$1
logfilename=${fpath}"_sysinfo.log"

CPUMODEL=`grep "model name" /proc/cpuinfo | sort -u | tr -s ' ' | awk 'BEGIN{FS=": "} {print $2}'`
echo $CPUMODEL
CPUFREQ=`awk '{printf "%.2f", $1/1000000}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq`
echo "    Frequency:" $CPUFREQ GHz
CACHESIZE=`grep 'cache size' /proc/cpuinfo | sort -u | awk '{print $4/1024}'`
echo "    Cache size:" $CACHESIZE MB
NUMSOCK=`grep 'physical id' /proc/cpuinfo | sort -u | wc -l`
echo $NUMSOCK sockets
socketidlist=`grep "physical id" /proc/cpuinfo | sort -u | awk '{(es=="")?es=$4:es=es" "$4} END{print es}'`
echo "    IDs of Sockets:" $socketidlist
NUMPROC=`grep -c 'processor' /proc/cpuinfo`
echo "   " $NUMPROC logical cores in total
NUMPHYSCORE=`grep 'cpu cores' /proc/cpuinfo | sort -u | awk '{print $4}'`
echo "   " $NUMPHYSCORE physical cores per socket
firstsocket=`echo $socketidlist | cut -d ' ' -f1`
NUMLOGICORE=`awk '/physical id\t: '$firstsocket'/' /proc/cpuinfo | wc -l`
echo "   " $NUMLOGICORE logical cores per socket
NUMNODE=`numactl --hardware | awk '/available:/ {print $2}'`
if [ $NUMNODE -eq 1 ]
then
    echo NUMA is off
    NUMA=0
else
    echo NUMA is ON, there are $NUMNODE NUMA nodes.
    NUMA=1
fi
if [ $NUMPHYSCORE -eq $NUMLOGICORE ]
then
    echo Hyper-Threading is off
    HT=0
else
    echo Hyper-Threading is ON
    HT=1
fi
if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies ]
then
    TURBO=`awk '{($1-$2==1000)?turbo=1:turbo=0;print turbo}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`
    if [ $TURBO -eq 1 ]
    then
	echo Turbo is ON
    else
	echo Turbo is off
    fi
else
    echo EIST is disabled
    TURBO=0
fi

socketnum=0
for socketid in $socketidlist; do
    core[$socketnum]=`grep -E "processor|physical id|core id|cpuid" /proc/cpuinfo | grep -A 2 "processor" | awk 'BEGIN{FS="\n";RS="--\n"} /physical id\t: '$socketid'/ {print $2,a[$2$3]++,$3,$1}' | sort | awk '{(es=="")?es=$12:es=es","$12} END {print es}'`
    echo Cores on Socket $socketnum: ${core[socketnum]} | tr ',' ' '
    socketnum=`expr $socketnum + 1`
done
socketnum=$NUMSOCK
while [ $socketnum -gt 0 ]; do
    socketid=0
    cpuset[$socketnum]=${core[0]}
    while (( $socketid < $socketnum - 1 )); do
	socketid=`expr $socketid + 1`
	cpuset[$socketnum]=${cpuset[socketnum]}","${core[$socketid]}
    done
    echo Cores on $socketnum of Sockets: ${cpuset[socketnum]} | tr ',' ' '
    socketnum=`expr $socketnum / 2`
done

dmidecode -t 0,2,17 > dmiinfo
BOARD=`grep -i -A3 "base board" dmiinfo | awk 'BEGIN{FS=": "} /Manufacturer|Product Name/ {(es=="")?es=$2:es=es", "$2} END{print es}'`
echo MotherBoard: $BOARD
BIOS=`grep -i -A3 "bios info" dmiinfo | awk 'BEGIN{FS=": "} /Version|Release Date/ {(es=="")?es=$2:es=es", "$2} END{print es}'`
echo "BIOS:" $BIOS
DIMMNUM=`grep -i -A16 "memory device$" dmiinfo | grep -c 'Size: [0-9]'`
DIMMSIZE=`grep -i -A16 "memory device$" dmiinfo | grep -m 1 'Size: [0-9]' | awk '{print $2/1024}'`
DIMMTYPE=`grep -i -A16 "memory device$" dmiinfo | grep -m 1 'Type:' | awk 'BEGIN{FS=": "} {print $2}'`
DIMMSPEED=`grep -m 1 'Speed' dmiinfo | awk '{print $2}'`
DIMMPART=`grep -m 1 'Part Number: [[:alnum:]]' dmiinfo | awk '{print $3}'`
echo Memory: ${DIMMNUM}x ${DIMMSIZE}GB ${DIMMTYPE}-${DIMMSPEED}MHz, ${DIMMPART}

OS=`[ -e /etc/issue ] && cat /etc/issue | sed '/^$/d' | head -n 1`
echo OS: $OS
KERNEL=`uname -rm`
echo "   " Kernel: $KERNEL
MACHINECONF="$CPUMODE, ${CPUFREQ}GHz, ${CACHESIZE}MB, ${DIMMNUM}x${DIMMSIZE}GB ${DIMMTYPE}-${DIMMSPEED}, $TURBO, $HT, $NUMA"
echo $MACHINECONF
read -p "Press [Enter] key to continue..."

if [ $NUMSOCK -eq 0 ]; then
	NUMSOCK=`grep 'model name' /proc/cpuinfo| wc -l`
fi
rm -f dmiinfo
echo "----------System----------" >$logfilename
dmidecode -t system >>$logfilename
echo "----------ipmitool fru----------" >>$logfilename
ipmitool fru >>$logfilename
echo "----------ipmitool sdr----------" >>$logfilename
ipmitool sdr >>$logfilename
echo "----------ipmitool mc info----------" >>$logfilename
ipmitool mc info >>$logfilename
echo "----------Kernel----------" >>$logfilename
uname -a >>$logfilename
cat /etc/motd >>$logfilename
echo "" >>$logfilename
echo "----------CPU----------" >>$logfilename
echo "CPU: $CPUMODEL CPU Socket: $NUMSOCK" >>$logfilename
echo "" >>$logfilename
echo "----------Memory----------" >>$logfilename
echo "Memory Size: ${DIMMSIZE}GB, Memory Number: ${DIMMNUM}, Memory Type: ${DIMMTYPE}, Memory Speed: ${DIMMSPEED}, PART Number: ${DIMMPART}" >>$logfilename
echo "" >>$logfilename
echo "----------HBA/RAID Card----------" >>$logfilename
lspci|grep -i sas >>$logfilename
hba=`cat /proc/interrupts |grep sas|awk -F " " '{print $NF}'|awk -F "-" '{print $1}'|uniq`
for sas in $hba
do
		msix=`cat /proc/interrupts |grep sas|awk -F " " '{print $NF}'|awk -F "-" '{print $1}'|grep $sas|wc -l`
		echo "$sas MSI-X:${msix}" >>$logfilename
done
echo "" >>$logfilename
echo "----------NIC----------" >>$logfilename
lspci|grep -i eth >>$logfilename
eth=`sar -n DEV 1 1|awk -F " " '{print $2}'|grep -i eth|sort -u`
for nic in $eth
do
		bus=`ethtool -i $nic|grep bus-info|awk -F ":" '{print $3":"$4}'`
		msi=` lspci -vvv -s $bus|grep "MSI-X"|awk -F " " '{print $5}'|awk -F "=" '{print $2}'`
		if lspci -vvv -s $bus |grep -i "IOV" >/dev/null; then
			vfs=`lspci -vvv -s $bus|grep VFs|awk -F " " '{print $6}'`
			sriov="YES, VFs:$vfs"
		else
			sriov="NO"
		fi
		echo "$nic, $bus, MSI-X:$msi, Support SRIOV:$sriov" >>$logfilename
		ethtool -i $nic >>$logfilename
done

echo "" >>$logfilename
echo "----------Logical Disk----------" >>$logfilename
fdisk -l 2>/dev/null >>$logfilename
echo "" >>$logfilename
echo "----------Phisycal/Virtual Disks----------" >>$logfilename
lsscsi >>$logfilename

dmesg >${fpath}"_dmesg.log"
dmesg |grep -i -E "error|fail">${fpath}"_dmesg_err.log"
lspci -vvvv >${fpath}"_lspci.log"
dmidecode >${fpath}"_dmidecode.log"
hwinfo 2>/dev/null >${fpath}"_hwinfo.log"
ipmitool fru >/dev/null >${fpath}"_fru.log"
ipmitool sdr >/dev/null >${fpath}"_sdr.log"
rm -f *.tmp