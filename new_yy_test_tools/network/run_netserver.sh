#!/bin/bash

pkill mpstat
pkill iostat
pkill free
pkill sar
sync
echo 3 >/proc/sys/vm/drop_caches
if [ -e ../bin/collect_perf_data.sh ]; then
	../bin/collect_perf_data.sh . 604800
fi
rm -f ../bin/netserver
glibc=`ldd --version|grep ldd|awk -F " " '{print $4}'|cut -d "." -f2|awk -F "-" '{print $1}'`
if [ $glibc -gt 5 ]; then
	ln -s ../bin/netserver_2.6.0 ../bin/netserver
else
	ln -s ../bin/netserver_2.4.5 ../bin/netserver
fi
../bin/netserver