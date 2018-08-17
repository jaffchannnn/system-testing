get_cpu_order()
{
	cat /proc/cpuinfo|grep -E 'processor|physical id|core id'|awk -F ":" '{print $2}' >c.log
	max_phy_id=`cat /proc/cpuinfo|grep "physical id"|awk -F " " 'BEGIN {max = 0} {if ($4>max) max=$4 fi} END {print max}'`
	cpu_cores=`cat /proc/cpuinfo|grep "cpu cores"|awk -F " " 'BEGIN {max = 0} {if ($4>max) max=$4 fi} END {print max}'`
	siblings=`cat /proc/cpuinfo|grep "siblings"|awk -F " " '{print $3}'|uniq`
	rm -f cpu.log
	rm -f /tmp/cpu_order.log
	n=`cat c.log|wc -l`
	i=0
	while [ $i -lt $n ]
	do
		i=$((i+3))
		str=`head -n $i c.log|tail -n 3|tr '\n' ' '`
		echo $str >>cpu.log
	done
	rm -f c.log
	i=0
	core_id=`cat cpu.log|grep " 0 "|awk -F " " '{print $3}'|tr "\n" " "`
	while [ $i -le $max_phy_id ]
	do
		x=0
		for j in $core_id
		do
			p=`cat cpu.log|grep -E " $i $j"|awk -F " " '{print $1}'|head -n 1`
			echo "$i $j $p" >>/tmp/cpu_order.log
			x=$((x+1))
			if [ $x -eq $cpu_cores ]; then
				break
			fi
		done
		x=0
		if [ $siblings -gt $((cpu_cores+1)) ]; then
			for j in $core_id
			do
				p=`cat cpu.log|grep -E " $i $j"|awk -F " " '{print $1}'|tail -n 1`
				echo "$i $j $p" >>/tmp/cpu_order.log
				x=$((x+1))
				if [ $x -eq $cpu_cores ]; then
					break
				fi
			done
		fi
		i=$((i+1))
	done
	rm -f cpu.log
}

set_mpt3sas_irq()
{
	ls -d /proc/irq/*/mpt3sas* | sed 's/[^0-9][^0-9]*/ /g'|sort -n >/tmp/irqaffinity
	queue_per_card=`cat /tmp/irqaffinity |awk -F " " '{print $NF}'|sort -n|tail -n1`
	queue_per_card=$((queue_per_card+1))
	i=1
	while read irq mpt_ver card queue
	do
		j=$i
		if [ $i -le $queue_per_card ]; then
			if [ $j -gt $siblings ]; then
				j=$((j-siblings))
			fi
		else
			j=$((i-queue_per_card))
			if [ $j -gt $siblings ]; then
				j=$((j-siblings))
			fi
		fi
		m=`cat /tmp/cpu_order.log|grep "^${card} "|head -n $j|tail -n 1|awk -F " " '{print $NF}'`
		MASK=$((1<<$((m))))
		IRQ=$irq
		DEV="mpt3sas""$card"
		i=$((i+1))
		printf "%s mask=%X for /proc/irq/%d/smp_affinity\n" $DEV $MASK $IRQ
		printf "%X" $MASK > /proc/irq/$IRQ/smp_affinity
	done < /tmp/irqaffinity
}

if [ "$1" = "--version" -o "$1" = "-V" ]; then
	echo "version: $version"
	exit 0
elif [ -n "$1" ]; then
	echo "Description:"
	echo "    This script attempts to bind each queue of a multi-queue mpt3sas0"
	echo "    to the same numbered core, ie tx0|rx0 --> cpu0, tx1|rx1 --> cpu1"
	echo "usage:"
	echo "    $0 "
	exit 0
fi

# Set up the desired devices.
multiqueue=`ls -d /proc/irq/*/mpt3sas* | grep mpt3sas0.*-.*1`
if [ -n "${multiqueue}" ]; then
	# check for irqbalance running
	IRQBALANCE_ON=`ps ax | grep -v grep | grep -q irqbalance; echo $?`
	if [ "$IRQBALANCE_ON" == "0" ] ; then
		echo " WARNING: irqbalance is running and will"
		echo "          likely override this script's affinitization."
		echo "          So I stopped the irqbalance service by"
		echo "          'killall irqbalance'"
		killall irqbalance
	fi
	get_cpu_order
	set_mpt3sas_irq
fi
