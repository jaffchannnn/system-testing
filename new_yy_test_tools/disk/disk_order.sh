#!/bin/bash

rm -f ../bin/fio
ln -s ../bin/fio_2.1.2 ../bin/fio
lsscsi |awk -F " " '{print $NF}'|grep "^/dev/"|sort >disk.tmp
while read disk
do
	echo $disk
	../bin/fio --name=Order --rw=rw --direct=1 --ioengine=libaio --filename=$disk --rwmixread=100 --bs=16k --iodepth=8 --readonly --runtime=3s --time_based --minimal >/dev/null
	sleep 1
done < disk.tmp
rm -f disk.tmp