#!/bin/bash 
#@version=0.7
#Written by wuhaiting
#Date 2014-03-10
#Readme 绑定网卡中断号到固定的cpu

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

COMMAND=$1

if echo $0 | grep -q "start";then
	COMMAND="start";
fi

grep -qiE 'Centos|Red' /etc/issue && LINUX_VERSION="centos"
grep -qiE 'Ubuntu|Debian' /etc/issue && LINUX_VERSION="ubuntu"
[ "$LINUX_VERSION" = "" ] && exit 1;

function enable_rfs_acceleration () {

	[ ! -f  /proc/sys/net/core/rps_sock_flow_entries ] && return 0;
	echo 32768 >  /proc/sys/net/core/rps_sock_flow_entries

	for NIC_RPS in `ls -d /sys/class/net/eth*/queues/rx*/rps_cpus`;
	do
		echo ffffffff > $NIC_RPS
	done

	ls -d /sys/class/net/eth*/queues/rx*/rps_flow_cnt | \
	sed -n 's/.*\(eth[0-9]\).*/\1/p' | \
	uniq -c | while read RPS_ENTRYS NIC;
	do
		RPS_ENTRY=$((32768/$RPS_ENTRYS))
		for RPS_FLOW_CNT in `ls -d /sys/class/net/${NIC}/queues/rx*/rps_flow_cnt`;
		do
			echo $RPS_ENTRY > $RPS_FLOW_CNT
		done
	done

}

function disable_rfs_acceleration () {
	[ ! -f  /proc/sys/net/core/rps_sock_flow_entries ] && return 0;
	echo 0 > /proc/sys/net/core/rps_sock_flow_entries

	for NIC_RPS in `ls -d /sys/class/net/eth*/queues/rx*/rps_cpus`;
	do
		echo 0 > $NIC_RPS
	done

	for RPS_FLOW_CNT in `ls -d /sys/class/net/*/queues/rx*/rps_flow_cnt`;
	do
		echo 0 > $RPS_FLOW_CNT
	done

}

function set_irq_affinity () {

	#Kill irqbalance process
	PIDS=$(pidof irqbalance);
	if [ "X${PIDS}" != "X" ];then
		echo -en "Kill irqbalance . . "
		for PID in $PIDS; do
			kill -9 $PID
 		done
 		echo "done"
 	fi

 	disable_rfs_acceleration

	CPU_NUM=$(grep -c '^processor' /proc/cpuinfo)
	i=0
	ls -d /proc/irq/*/eth[0-9]-* 2>/dev/null | \
	sed 's/[^0-9][^0-9]*/ /g' | \
	while read IRQ DEV QUEUE;
	do
		[ $i -ge $CPU_NUM ] && i=0;
		BIT_MASK=$((1<<$i))
		echo "IRQ:$IRQ eth${DEV}-queue${QUEUE} --> cpu${i}"
		printf "%X" $BIT_MASK > /proc/irq/$IRQ/smp_affinity
		((i+=1))
	done

}

function recover_irqbalance () {

	echo "Start irqbalance .."
	/etc/init.d/irqbalance start

}

case $COMMAND in
	start|restart)
		ls -d /proc/irq/*/eth[0-9]-* 2>/dev/null | \
		sed -n 's/.*\(eth[0-9]\).*/\1/p' | \
		sort -n|uniq -c | while read DEV_QUEUE NIC;
		do
			if [ $DEV_QUEUE -le 2 ];then
				enable_rfs_acceleration
			else
				set_irq_affinity
			fi
			break;
		done
		;;
	stop)
		recover_irqbalance
		disable_rfs_acceleration
		;;
	*)
		echo "Usage: $0 COMMAND"
		exit 1
esac

exit 0
