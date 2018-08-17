#!/bin/bash

if [ $2 = "" ]; then
	echo "Pleasse specify netserver ip, exit!"
	exit 1
else
	netserver_ip=$1
fi
if [ $2 = "" ]; then
	rtime=60
else
	rtime=$2
fi
rm -f ../bin/netperf
glibc=`ldd --version|grep ldd|awk -F " " '{print $4}'|cut -d "." -f2|awk -F "-" '{print $1}'`
if [ $glibc -gt 5 ]; then
	ln -s ../bin/netperf_2.6.0 ../bin/netperf 2>/dev/null
else
	ln -s ../bin/netperf_2.4.5 ../bin/netperf 2>/dev/null
fi
../bin/netperf -H "$netserver_ip" -l $rtime
../bin/netperf -H "$netserver_ip" -l $rtime
../bin/netperf -H "$netserver_ip" -l $rtime
../bin/netperf -H "$netserver_ip" -l $rtime
../bin/netperf -H "$netserver_ip" -l $rtime
../bin/netperf -H "$netserver_ip" -l $rtime -- -m 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -m 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -m 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -m 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -m 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -M 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -M 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -M 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -M 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -M 2048
../bin/netperf -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -H "$netserver_ip" -l $rtime -- -s 87380
../bin/netperf -H "$netserver_ip" -l $rtime -- -s 87380
../bin/netperf -H "$netserver_ip" -l $rtime -- -s 87380
../bin/netperf -H "$netserver_ip" -l $rtime -- -s 87380
../bin/netperf -H "$netserver_ip" -l $rtime -- -s 87380
../bin/netperf -H "$netserver_ip" -l $rtime -- -S 16384
../bin/netperf -H "$netserver_ip" -l $rtime -- -S 16384
../bin/netperf -H "$netserver_ip" -l $rtime -- -S 16384
../bin/netperf -H "$netserver_ip" -l $rtime -- -S 16384
../bin/netperf -H "$netserver_ip" -l $rtime -- -S 16384
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024 -M 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024 -M 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024 -M 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024 -M 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 1024 -M 1024
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -s 87380
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -s 87380
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -s 87380
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -s 87380
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -s 87380
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -S 16384
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -S 16384
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -S 16384
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -S 16384
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -m 16384 -S 16384
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -t UDP_STREAM -H "$netserver_ip" -l $rtime -- -D
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 32,1024 -S 16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t TCP_CRR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 32,1024 -s 87380
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D
../bin/netperf -t UDP_RR -H "$netserver_ip" -l $rtime -- -r 64,16384 -D