#!/bin/bash

stime=3
light_RAID()
{
	i=1
	while read slot
	do
		j=$((i%2))
		if [ $j -eq 1 ]; then
			did=$slot
		else
			echo "Light up [${did}:${slot}]."
			megacli -PdLocate -start -physdrv[${did}:${slot}] -a0 >/dev/dull
			sleep $stime
			echo "Turn off [${did}:${slot}]."
			megacli -PdLocate -stop -physdrv[${did}:${slot}] -a0 >/dev/dull
		fi
		i=$((i+1))
	done < a.log
	rm -f a.log
}
light_HBA()
{
	while read slot
	do
		echo "Light up [${did}:${slot}]."
		sas2ircu $n locate ${did}:${slot} on >/dev/dull
		sleep $stime
		echo "Turn off [${did}:${slot}]."
		sas2ircu $n locate ${did}:${slot} off >/dev/dull
	done < a.log
	rm -f a.log
}
light_PMC()
{
	while read pd
	do
		echo "Light up $pd."
		 hpssacli controller slot=$s pd $pd modify led=on >/dev/dull
		sleep $stime
		echo "Turn off $pd."
		 hpssacli controller slot=$s pd $pd modify led=off >/dev/dull
	done < a.log
	rm -f a.log
}

n=`megacli -PDList -aALL|grep Adapter|wc -l`
n=$((n-1))
for n in `seq 0 $n`
do
	megacli -adpbbucmd -aall|grep BatteryType|awk -F " " '{print $2}'|grep -i bbu
	if [ $? -gt 0 ]; then
		echo "RAID card is using battery, not SuperCap."
	fi
	adp="-a"${n}
	megacli -PDList $adp &>/dev/null
	if [ $? -eq 0 ]; then
		megacli -PDList $adp|grep -E "Enclosure Device ID|Slot Number"|awk -F " " '{print $NF}' >a.log
		light_RAID
	fi
done 

n=`sas2ircu list|grep -E "UNKNOWN|SAS"|grep -v "Utility"|awk -F " " '{print $1}'|wc -l`
n=$((n-1))
for n in `seq 0 $n`
do
	did=`sas2ircu $n display|grep "Enclosure #"|tail -n1|awk -F " " '{print $NF}'`
	sas2ircu $n display|grep "Slot #"|awk -F " " '{print $NF}' >a.log
	light_HBA
done

which hpssacli
if [ $? -eq 0 ]; then
	n=`hpssacli ctrl all show|grep "Smart Array"|awk -F " " '{print $6}'|wc -l`
	if [ $n -gt 0 ]; then
		s=0
		hpssacli ctrl slot=$s show config|grep "physicaldrive"|awk -F " " '{print $2}'>a.log
		light_PMC
		s=$((s+1))
	fi
fi
