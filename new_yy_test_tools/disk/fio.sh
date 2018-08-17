#!/bin/bash

rtime=540
stime=20
ramp_time=40
ttime=$((rtime+stime+ramp_time))
while [ 1 ]
do
	source ./check_bgi.sh
	if [ "$RAID" = "OK" ]; then
		break
	else
		echo "VD is in initialization"
	fi
	sleep 600
done
usage()
{
echo "`basename $0 ` -[f|s|b|d|n|o|r] args"
echo "-f <file name with full path> 	IO test file, like: /data/test.dat"
echo "-s <file size>	Size of IO test file like: 500, unit is GB"
echo "-d <disk>	one or multiple block device for IO test, like: /dev/sdb"
echo "-n <PD number>	Physical disk number for test"
echo "-t <Disk Type>	Physical disk type 0/1:SATA/SAS; 2:SSD"
echo "-q <io_depth0>	io_depth per disk"
echo "-f, -s options are for IO test under filesystem"
echo "-d option is for raw disk test, you can specify more than one disk at once,"
echo "like: \"/dev/sdc /dev/sdd\", or a disk follow with a number, \"/dev/sdh 5\", this will do test for sdh-sdm"
echo "-m, specify disk_vendor model capacity RAID and ServerModel_InternelType, like \"Intel s3500 300 RAID5 A3_3\""
}
while getopts :f:s:d:n:t:q:y:m:h:?: OPTION
do
    case $OPTION in
	f)   test_file=$OPTARG;;
	s)   file_size=$OPTARG;;
	d)   disk_for_test=$OPTARG;;
	n)   physical_disk_num=$OPTARG;;
	t)   disk_type=$OPTARG;;
	q)   io_depth0=$OPTARG;;
	y)   skip_confirm=$OPTARG;;
	m)   disk_model=$OPTARG;;
	h)   usage;exit 0;;
	?)   usage;exit 0;;
   esac
done

if [ -z $physical_disk_num ]; then
	echo "Please specify the physical disk num with -n option, exit!"
	exit 1
fi

if [ -z "$disk_model" ]; then
	vendor="Unkown"
	model="Unkown"
	capacity="Unkown"
	RAID="Unkown"
else
	vendor=`echo $disk_model|awk -F "." '{print $1}'`
	model=`echo $disk_model|awk -F "." '{print $2}'`
	capacity=`echo $disk_model|awk -F "." '{print $3}'`
	RAID=`echo $disk_model|awk -F "." '{print $4}'`
	server=`echo $disk_model|awk -F "." '{print $5}'`
fi

if [ "$test_file" != "" ]; then
	touch $test_file 2>/dev/null
	if [ $? -ne 0 ];then
		echo "Cannot touch $test_filt, please input a correct file name with full path, exit!"
		exit 1
	fi
	if [ -z $file_size ]; then
		echo "Please specify the file size with -s option, exit!"
		exit 1
	else
		expr $file_size "+" 0 &> /dev/null
		if [ $? -eq 0 ];then
			fs_test_str="--filename=${test_file} --size=${file_size}G"
		else
			echo "$file_size not a number, exit!"
			exit 1
		fi
	fi
	fs_test=1
	ldisk=`df $test_file |grep "/dev/"|awk -F " " '{print $1}'|awk -F "/" '{print $NF}'|tr [0-9] " "|grep -o "[^ ]\+\( \+[^ ]\+\)*"`
fi

if [ "$disk_for_test" != "" ]; then
	all_disk_for_test=`echo $*|awk -F "-d" '{print $2}'|cut -d "-" -f 1`
	for disk in $all_disk_for_test
	do
		if [ -b $disk ]; then
			raw_test_str="$raw_test_str --filename=$disk"
			last_disk=$disk
		else
			expr $disk "+" 0 &> /dev/null
			if [ $? -eq 0 ];then
				disk_num=$disk
				rest_disks=`lsscsi |awk -F " " '{print $NF}'|grep "^/dev/"|sort|grep -A $disk_num $last_disk|grep -v $last_disk`
				for disk in $rest_disks
				do
					raw_test_str="$raw_test_str --filename=$disk"
				done
			else
				echo "Invalid block device $disk, exit!"
				exit 1
			fi
		fi
	done
	fs_test=0
	ldisk=`echo $raw_test_str|awk -F "/" '{print $NF}'`
fi
io_scheduler=`cat /sys/block/${ldisk}/queue/scheduler|awk -F "[" '{print $2}'|awk -F "]" '{print $1}'`

ulimit -d unlimited
ulimit -s unlimited
ulimit -m unlimited
ulimit -v unlimited
ulimit -t unlimited
ulimit -i unlimited
ulimit -n 500000

rm -f *.tmp >/dev/null

tlog()
{
	time=`date -d today +"%Y-%m-%d %T"`
	echo "[$time] $1" >>$result_dir/fio_run.log
}

fs_sync()
{
	sync
	echo 3 >/proc/sys/vm/drop_caches 
}

fio_rawdisk_test()
{
	if [ $disk_type -gt 1 ]; then
		echo "Start SSD init at " `date` | tee -a $result_dir/fio_run.log
		for ssd in `echo $str|sed 's/--filename=//g'`
		do
			echo "SSD init $ssd"
			../bin/fio --name=init_W --numjobs=1 --rw=rw --direct=1 --ioengine=$ioengine --filename=${ssd} --rwmixread=0 --bs=1024k --iodepth=8 --minimal >/dev/null &
		done
		while [ 1 ]
		do
			sleep 10
			fios=`ps -ef|grep rwmixread|grep -v grep|wc -l`
			if [ $fios -eq 0 ]; then
				break
			fi
		done
		echo "End SSD init at " `date` | tee -a $result_dir/fio_run.log
		sleep 10
	fi
	fs_sync
	echo `date`
	echo "Will take around $test_time minutes for this test."
	echo "PD_Num,SEQ_RAND,DIRECT_IO,BLOCK(KB),READ%,R_BW(KB),R_IOPS,R_LAT(ms),W_BW(KB),W_IOPS,W_LAT(ms),Threads,io_depth,R_CLat_MIN,R_CLat_MAX,R_CLat_99.9,W_CLat_MIN,W_CLat_MAX,W_CLat_99.9,IO_Scheduler,IOEngine,Vendor,Model,Capacity,RAID"
	tlog "Start raw disk test"
	for rw in ${rw_arr[@]}
	do
		if [ $rw = "rw" ]; then
			srw="SEQ"
			io_depth=$((io_depth0*physical_disk_num))
			numjobs=1
		else
			srw="RAND"
			io_depth=$io_depth0
			numjobs=${physical_disk_num}
		fi
		for read in ${rwmixread_arr[@]}
		do
			for block in ${bs_arr[@]}
			do
				name=RW_${direct}DIO_${read}R_${block}K_${io_depth}Q
				echo "../bin/fio --name=$name --numjobs=$numjobs --norandommap --ramp_time=$ramp_time --rw=$rw --direct=$direct --ioengine=$ioengine --runtime=${rtime}s $str --rwmixread=$read --bs=${block}k --iodepth=${io_depth} --group_reporting --minimal" >>$result_dir/fio_run.log
				../bin/fio --name=$name --numjobs=$numjobs --norandommap --ramp_time=$ramp_time --rw=$rw --direct=$direct --ioengine=$ioengine --runtime=${rtime}s $str --rwmixread=$read --bs=${block}k --iodepth=${io_depth} --group_reporting --minimal >>$result_dir/fio_run.log
				R_999_per=`tail -n1 $result_dir/fio_run.log | awk -F ";" '{print $32}'|awk -F "=" '{print $2}'`
				R_999_per=`echo "scale=3;$R_999_per/1000"|bc`
				W_999_per=`tail -n1 $result_dir/fio_run.log | awk -F ";" '{print $73}'|awk -F "=" '{print $2}'`
				W_999_per=`echo "scale=3;$W_999_per/1000"|bc`
				tail -n1 $result_dir/fio_run.log | awk -F ";" '{printf "%d,%s,%d,%d,%d,%d,%d,%.3f,%d,%d,%.3f,%d,%d,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%s,%s,%s,%s,%d,%s\n","'$physical_disk_num'","'$srw'","1","'$block'","'$read'",$7,$8,$40/1000,$48,$49,$81/1000,"'$numjobs'","'$io_depth'",$38/1000,$39/1000,"'$R_999_per'",$79/1000,$80/1000,"'$W_999_per'","'$io_scheduler'","'$ioengine'","'$vendor'","'$model'","'$capacity'","'$RAID'"}' | tee -a $result_dir/result.csv
				sed -i '$s/$/\,'`echo $testid`'/g' $result_dir/result.csv
				fs_sync
				sleep $stime
			done
		done
	done
	tlog "End raw disk test"
}

fio_fs_unbuffer_test()
{
	echo `date -d today +"%Y-%m-%d %T"`" Starting layout testing file."
	../bin/fio --name=layout --rw=rw --direct=1 --ioengine=$ioengine $str --rwmixread=0 --bs=1024k --iodepth=$((io_depth0*physical_disk_num)) --minimal >> /dev/null
	echo `date -d today +"%Y-%m-%d %T"`" Finish layout testing file."
	echo "Will take around $test_time minutes for this test."
	echo "PD_Num,SEQ_RAND,DIRECT_IO,BLOCK(KB),READ%,R_BW(KB),R_IOPS,R_LAT(ms),W_BW(KB),W_IOPS,W_LAT(ms),Threads,io_depth,R_CLat_MIN,R_CLat_MAX,R_CLat_99.9,W_CLat_MIN,W_CLat_MAX,W_CLat_99.9,IO_Scheduler,IOEngine,Vendor,Model,Capacity,RAID"
	fs_sync
	tlog "Start fs test"
	for rw in ${rw_arr[@]}
	do
		if [ $rw = "rw" ]; then
			srw="SEQ"
			io_depth=$((io_depth0*physical_disk_num))
			numjobs=1
		else
			srw="RAND"
			io_depth=$io_depth0
			numjobs=${physical_disk_num}
		fi
		for read in ${rwmixread_arr[@]}
		do
			for block in ${bs_arr[@]}
			do
				name=RW_${direct}DIO_${read}R_${block}K_${io_depth}Q
				echo "../bin/fio --name=$name --rw=$rw --numjobs=$numjobs --ramp_time=$ramp_time --direct=$direct --ioengine=$ioengine --runtime=${rtime}s $str --rwmixread=$read --bs=${block}k --iodepth=${io_depth}  --group_reporting --minimal" >> $result_dir/fio_run.log
				../bin/fio --name=$name --rw=$rw --numjobs=$numjobs --ramp_time=$ramp_time --direct=$direct --ioengine=$ioengine --runtime=${rtime}s $str --rwmixread=$read --bs=${block}k --iodepth=${io_depth}  --group_reporting --minimal >> $result_dir/fio_run.log
				R_999_per=`tail -n1 $result_dir/fio_run.log | awk -F ";" '{print $32}'|awk -F "=" '{print $2}'`
				R_999_per=`echo "scale=3;$R_999_per/1000"|bc`
				W_999_per=`tail -n1 $result_dir/fio_run.log | awk -F ";" '{print $73}'|awk -F "=" '{print $2}'`
				W_999_per=`echo "scale=3;$W_999_per/1000"|bc`
				tail -n1 $result_dir/fio_run.log | awk -F ";" '{printf "%d,%s,%d,%d,%d,%d,%d,%.3f,%d,%d,%.3f,%d,%d,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%s,%s,%s,%s,%d,%s\n","'$physical_disk_num'","'$srw'","1","'$block'","'$read'",$7,$8,$40/1000,$48,$49,$81/1000,"'$numjobs'","'$io_depth'",$38/1000,$39/1000,"'$R_999_per'",$79/1000,$80/1000,"'$W_999_per'","'$io_scheduler'","'$ioengine'","'$vendor'","'$model'","'$capacity'","'$RAID'"}' | tee -a $result_dir/result.csv
				sed -i '$s/$/\,'`echo $testid`'/g' $result_dir/result.csv
				fs_sync
				sleep $stime
			done
		done
	done
	tlog "End fs test"
}

confirm()
{
	if [ ! $fs_test -eq 1 ]; then
		echo "All data on the test disks will be destroyed!"
	fi
	if [ -z $skip_confirm ]; then
		echo -n "Do you want to continue? [y|n]:"
		read ans
		if [ "$ans" != "y" ]; then
			exit 0
		fi
	fi
	mkdir $result_dir 2>/dev/null
	rm -f ../bin/fio
	glibc=`ldd --version|grep ldd|awk -F " " '{print $4}'|cut -d "." -f2|cut -d "-" -f1`
	if [ $glibc -gt 5 ]; then
		ln -s ../bin/fio_2.1.2 ../bin/fio
	else
		ln -s ../bin/fio_2.0.3 ../bin/fio
	fi
	cp fio.xlsx $result_dir
	if [ -e ../bin/collect_perf_data.sh ]; then
		../bin/collect_perf_data.sh $result_dir $((test_time+7200))
	fi
	echo "PD_Num,SEQ_RAND,DIRECT_IO,BLOCK(KB),READ%,R_BW(KB),R_IOPS,R_LAT(ms),W_BW(KB),W_IOPS,W_LAT(ms),Threads,io_depth,R_CLat_MIN,R_CLat_MAX,R_CLat_99.9,W_CLat_MIN,W_CLat_MAX,W_CLat_99.9,IO_Scheduler,IOEngine,Vendor,Model,Capacity,RAID,TestID" > $result_dir/result.csv
}

if [ -z $disk_type ]; then
	disk_type=0
fi

if [ -z $io_depth0 ]; then
	if [ $disk_type -eq 0 ]; then
		io_depth0=2
	elif [ $disk_type -eq 1 ]; then
		io_depth0=2
	elif [ $disk_type -eq 2 ]; then
		io_depth0=16
		../bin/set_irq_affinity_hba.sh &>/dev/null
	elif [ $disk_type -eq 3 ]; then
		io_depth0=32
	elif [ $disk_type -eq 4 ]; then
		io_depth0=64
	fi
else
	expr $io_depth0 "+" 0 &> /dev/null
	if [ ! $? -eq 0 ];then
		echo "io_depth (-q option) $io_depth0 is not a number, exit!"
		exit 1
	fi
fi
echo "Disk type: $disk_type (0:SATA; 1:SAS; 2:SATA SSD; 3:SAS SSD; 4:PCIe SSD), io_depth per disk is $io_depth0"

direct=1
ioengine=libaio
rw_arr=(rw randrw)
rw_arr_num=${#rw_arr[@]}
rwmixread_arr=(0 70)
rwmixread_arr_num=${#rwmixread_arr[@]}
bs_arr=(1024 4)
bs_arr_num=${#bs_arr[@]}
done_test=0
hdd=${physical_disk_num}
timeid=`date +%Y%m%d%H%M`
result_dir=`pwd`"/fio_${timeid}"
testid="${server}_${timeid}"
loop_num=$((rw_arr_num*rwmixread_arr_num*bs_arr_num))
test_time=$((ttime*loop_num))

main()
{
	if [ "$fs_test_str" != "" ]; then
		str=$fs_test_str
		echo $str
		confirm
		echo $str >>$result_dir/fio_run.log
		fs_test=1
		fio_fs_unbuffer_test
		done_test=1
	fi
	if [ $done_test -eq 0 ]; then
		str=$raw_test_str
		echo $str
		confirm
		echo $str >>$result_dir/fio_run.log
		fio_rawdisk_test
		done_test=1
	fi
	rm -f *.tmp >/dev/null
}

main

pkill mpstat
pkill iostat
pkill free
pkill sar
