#!/bin/bash
echo "testing NET………………"
test_time=180  
interval=5
sample=$((test_time/interval)) #采集时间
netserver=$1
threads_arr=( 128 )
#echo "Net Speed: ${eth_speed}Mbps, Threads: $threads"  #输出
curldir=`pwd`
log_dir=${curldir}/"netperf_"`date +%Y%m%d%H%M` 
mkdir -p  $log_dir 2>/dev/null 
output="THROUGHPUT,THROUGHPUT_UNITS,MIN_LATENCY,MAX_LATENCY,MEAN_LATENCY,P50_LATENCY,P90_LATENCY,P99_LATENCY,LOCAL_NODELAY,LOCAL_SEND_CALLS,LOCAL_BYTES_PER_SEND,LOCAL_BYTES_SENT,LOCAL_TRANSPORT_RETRANS,REMOTE_RECV_CALLS,REMOTE_BYTES_PER_RECV,REMOTE_BYTES_RECVD"
sz_arr=( 20000 24576 32768  ) #指定测试请求的size大小（字节）
TAG=( TCP_RR UDP_RR )
#TAG=(  TCP_RR UDP_RR )
for tag in ${TAG[@]}  #对TCP，UDP模式进行循环
do
for threads in ${threads_arr[@]} #对不同进程并发数进行循环
do
	echo "${tag}_${threads}" |tee -a $log_dir/${tag}_netperf.csv
	echo "PacketSize,THROUGHPUT,Packet(W)/s,MEAN_LATENCY(ms),P99_LATENCY(ms),MAX_LATENCY(ms),Retrans/s,ReransRate" |tee -a $log_dir/${tag}_netperf.csv
	for size in ${sz_arr[@]} # 对数据包字节大小进行循环
	do
		str="$threads /data/script/netperf-netperf-2.5.0/src/netperf -t ${tag} -H $netserver -l $test_time -t omni -P 0 -- -r ${size},${size} -D -O \"$output\""  #UDP_RR UDP请求和响应性能  -l 时间 -t名称 -P 0 不显示脚本名称 -r指定测试请求和/或相应大小 -D在两个系统上将tcp_nodelay的选项设置为true
		echo "$str" >>$log_dir/${tag}_netperf.log
		echo "$str" >>$log_dir/${tag}_net.log
		echo "$str" >>$log_dir/${tag}_CPU.log
		echo `date` >>$log_dir/${tag}_netperf.log
		echo `date` >>$log_dir/${tag}_net.log
		echo `date` >>$log_dir/${tag}_CPU.log
		
		j=1
		while [ $j -le $threads ]
		do
			../bin/netperf_2.6.0 -t ${tag} -H $netserver -l $test_time -t omni -P 0 -- -r ${size},${size} -D -O "$output" >>$log_dir/${tag}_netperf.log &  #发送测试请求，并循环次数直到 数目和threads一致 好像是模拟多线程并发
			j=$((j+1))
		done
		mpstat -P ALL $interval $sample >>$log_dir/${tag}_CPU.log &  #每5秒采集一次，采集60次 采集CPU数据
		sar -n DEV $interval $sample >>$log_dir/${tag}_net.log       #每5秒采集一次，采集60次 采集网卡上流量
		sleep 5
		sendout=`tail -n $threads $log_dir/${tag}_netperf.log|awk -F " " '{sum1+=$10} END {print sum1}'`   #local bytes  send 和
		retrans=`tail -n $threads $log_dir/${tag}_netperf.log|awk -F " " '{sum1+=$13} END {print sum1}'`   # 总和LOCAL_TRANSPORT_RETRAN
		Rerans_Rate=`echo "scale=4;$retrans*100/$sendout"|bc` #除法后取小数点后4位
		PPS=`echo "scale=3;$sendout/$test_time/10000"|bc`     #发送速率
		Rerans_PPS=`echo "scale=2;$retrans/$test_time"|bc`    #接受速率 
		THROUGHPUT=`tail -n $threads $log_dir/${tag}_netperf.log|awk -F " " '{sum1+=$1} END {print sum1*8/1000}'`  #吐量
		THROUGHPUT=`echo "scale=3;$THROUGHPUT*$size/1000"|bc`  #
		MEAN_LATENCY=`tail -n $threads $log_dir/${tag}_netperf.log|awk -F " " '{sum1+=$5} END {print sum1/NR/1000}'`  #均等待时间
		
		P99_LATENCY=`tail -n $threads $log_dir/${tag}_netperf.log|awk -F " " 'BEGIN {max=0} {if ($8>max) max=$8 fi} END {print max/1000}'`  
		MAX_LATENCY=`tail -n $threads $log_dir/${tag}_netperf.log|awk -F " " 'BEGIN {max=0} {if ($4>max) max=$4 fi} END {print max/1000}'`
		echo "${size}B,$THROUGHPUT,${PPS},$MEAN_LATENCY,$P99_LATENCY,$MAX_LATENCY,$Rerans_PPS,${Rerans_Rate}%" |tee -a $log_dir/${tag}_netperf.csv
		echo "PacketSize: $size THROUGHPUT: $THROUGHPUT Packet(W)/s: $PPS MEAN_LATENCY: $MEAN_LATENCY P99_LATENCY: $P99_LATENCY MAX_LATENCY: $MAX_LATENCY Retrans/s: $Rerans_PPS ReransRate: ${Rerans_Rate}%" >>$log_dir/${tag}_net.log
		sleep 5
	done
	echo "" >>$log_dir/${tag}_netperf.csv
done
done
echo "ENDING testing net"

