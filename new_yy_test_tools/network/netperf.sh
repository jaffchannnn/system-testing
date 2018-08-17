#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage:$0 Netserver_IP"
	exit 1
fi
test_time=300
interval=5
sample=$((test_time/interval))
netserver=$1
net=`echo $netserver|awk -F "." '{print $1"."$2}'`
iface=`ifconfig|grep -B1 $net|tail -n2|head -n1|awk -F " " '{print $1}'`
if [ -z $iface ]; then
	echo "Wrong net."
	exit 1
fi
eth_speed=`ethtool $iface|grep "Speed:"|awk -F " " '{print $2}'|awk -F "M" '{print $1}'`
if [ $eth_speed = "10000" ]; then
	threads_arr=(128 256 512 1024)
else
	threads_arr=(32 64 128 256)
fi
echo "Net Speed: ${eth_speed}Mbps, Threads: $threads"
log_dir="netperf_"`date +%Y%m%d%H%M`
mkdir $log_dir 2>/dev/null
telnet $netserver 12865 2>&1 > $log_dir/tt.log &
sleep 5
telnet_ps=`ps -ef|grep telnet|grep -v grep|awk -F " " '{print $2}'|awk -F "-" '{print $1}'`
if grep "Connected" $log_dir/tt.log; then
	kill -9 $telnet_ps 2>/dev/null
else
	echo "Remote netserver did not strtup, exit!"
	rm -rf $log_dir
	exit 1
fi
rm -f $log_dir/tt.log
output="THROUGHPUT,THROUGHPUT_UNITS,MIN_LATENCY,MAX_LATENCY,MEAN_LATENCY,P50_LATENCY,P90_LATENCY,P99_LATENCY,LOCAL_NODELAY,LOCAL_SEND_CALLS,LOCAL_BYTES_PER_SEND,LOCAL_BYTES_SENT,LOCAL_TRANSPORT_RETRANS,REMOTE_RECV_CALLS,REMOTE_BYTES_PER_RECV,REMOTE_BYTES_RECVD"
sz_arr=(78 128 256 512 1024 1280 1518 8192 16384)
for threads in ${threads_arr[@]}
do
	echo "$threads" |tee -a $log_dir/netperf.csv
	echo "PacketSize,THROUGHPUT,Packet(W)/s,MEAN_LATENCY(ms),P99_LATENCY(ms),MAX_LATENCY(ms),Retrans/s,ReransRate" |tee -a $log_dir/netperf.csv
	for size in ${sz_arr[@]}
	do
		str="$threads ../bin/netperf_2.6.0 -t UDP_RR -H $netserver -l $test_time -t omni -P 0 -- -r ${size},${size} -D -O \"$output\""
		echo "$str" >>$log_dir/netperf.log
		echo "$str" >>$log_dir/net.log
		echo "$str" >>$log_dir/CPU.log
		echo `date` >>$log_dir/netperf.log
		echo `date` >>$log_dir/net.log
		echo `date` >>$log_dir/CPU.log
		
		j=1
		while [ $j -le $threads ]
		do
			../bin/netperf_2.6.0 -t UDP_RR -H $netserver -l $test_time -t omni -P 0 -- -r ${size},${size} -D -O "$output" >>$log_dir/netperf.log &
			j=$((j+1))
		done
		mpstat -P ALL $interval $sample >>$log_dir/CPU.log &
		sar -n DEV $interval $sample >>$log_dir/net.log
		sleep 5
		sendout=`tail -n $threads $log_dir/netperf.log|awk -F " " '{sum1+=$10} END {print sum1}'`
		retrans=`tail -n $threads $log_dir/netperf.log|awk -F " " '{sum1+=$13} END {print sum1}'`
		Rerans_Rate=`echo "scale=4;$retrans*100/$sendout"|bc`
		PPS=`echo "scale=3;$sendout/$test_time/10000"|bc`
		Rerans_PPS=`echo "scale=2;$retrans/$test_time"|bc`
		THROUGHPUT=`tail -n $threads $log_dir/netperf.log|awk -F " " '{sum1+=$1} END {print sum1*8/1000}'`
		THROUGHPUT=`echo "scale=3;$THROUGHPUT*$size/1000"|bc`
		MEAN_LATENCY=`tail -n $threads $log_dir/netperf.log|awk -F " " '{sum1+=$5} END {print sum1/NR/1000}'`
		P99_LATENCY=`tail -n $threads $log_dir/netperf.log|awk -F " " 'BEGIN {max=0} {if ($8>max) max=$8 fi} END {print max/1000}'`
		MAX_LATENCY=`tail -n $threads $log_dir/netperf.log|awk -F " " 'BEGIN {max=0} {if ($4>max) max=$4 fi} END {print max/1000}'`
		echo "${size}B,$THROUGHPUT,${PPS},$MEAN_LATENCY,$P99_LATENCY,$MAX_LATENCY,$Rerans_PPS,${Rerans_Rate}%" |tee -a $log_dir/netperf.csv
		echo "PacketSize: $size THROUGHPUT: $THROUGHPUT Packet(W)/s: $PPS MEAN_LATENCY: $MEAN_LATENCY P99_LATENCY: $P99_LATENCY MAX_LATENCY: $MAX_LATENCY Retrans/s: $Rerans_PPS ReransRate: ${Rerans_Rate}%" >>$log_dir/net.log
		sleep 5
	done
	echo "" >>$log_dir/netperf.csv
done