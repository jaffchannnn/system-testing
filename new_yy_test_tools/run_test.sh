#!/bin/bash

#判断是否有输入
if [ $# -eq 0 ]
then
echo "please input one of io|cpu|net|mem like this"
echo "like this sh testing.sh io cpu mem"
exit 1
fi
#判断输入，选择压测项目
flag_cpu=`echo $@ | grep cpu `
flag_io=`echo $@ | grep io `
flag_net=`echo $@ | grep net `
flag_mem=`echo $@ | grep mem `


#判断输入是否有cpu io mem net
if [[ ! -n "flag_mem" ]] && [[ ! -n "flag_net" ]] && [[ ! -n "flag_cpu" ]] && [[ ! -n "flag_io" ]]
then
echo "please input one of io|cpu|net|mem"
echo "like this: sh testing.sh io cpu mem"
exit 1
fi


if [ ! -n "$flag_cpu" ]
then
flag_cpu="stop" 
else
flag_cpu="start"
fi

if [ ! -n "$flag_io" ]
then
flag_io="stop" 
else
flag_io="start"
fi

if [ ! -n "$flag_mem" ]
then
flag_mem="stop" 
else
flag_mem="start"
fi

if [ ! -n "$flag_net" ]
then
flag_net="stop" 
else
flag_net="start"
fi

cur_path=`pwd`
timeid=`date +%Y%m%d%H%M`
stime=30

pkill mpstat
pkill iostat
pkill free
pkill sar
if cat /etc/redhat-release; then
	if ! which lsscsi; then
		yum install -y lsscsi
		yum install -y OpenIPMI
		yum install -y ipmitool
		rpm --force -ivh bin/tools/MegaCli-8.07.14-1.noarch.rpm
		cp /opt/MegaRAID/MegaCli/MegaCli64 /usr/bin/megacli
		cp /opt/MegaRAID/MegaCli/MegaCli64 bin/tools/megacli
	fi
else
	chmod 755 /var/run/screen
	if ! which hwinfo &>/dev/null; then
		bash source.sh
		apt-get update
		apt-get install -y lsscsi
		apt-get install -y libaio1
		apt-get install -y python-pip
		pip install requests
		apt-get install -y bc
		apt-get install -y numactl
		apt-get install -y mcelog
		apt-get install -y hwinfo
		apt-get install -y linux-tools-3.2.0-23
		apt-get install -y unix2dos
	else
		echo "Already inited."
	fi
fi


#以下是函数

###############################################################################################
#FIO
###############################################################################################

function test_mem()
{
if [ "$1" != "start" ]
then
echo -e "\033[36m skip testing mem \033[0m" 
else
echo -e "\033[36m testing mem \033[0m"
	mem_begin=`date +%s`
	cd $cur_path
	cd ./memory
	./memory.sh
	cd $cur_path
	sleep $stime
	mem_end=`date +%s`
	mem_time=`expr ${mem_end} - ${mem_begin}`
	echo "MEM_runtime,${mem_time}" >> ${scp_dir}/RUNTIME.csv
fi
}

function test_io()
{
if [ "$1" != "start" ]
then
echo -e "\033[36m skip testing io \033[0m" 
else
echo -e "\033[36m testing io \033[0m"
	io_begin=`date +%s`
	cd $cur_path
	cd ./disk
	./io_test.sh C2 alibaba
	cd $cur_path
	sleep $stime
	io_end=`date +%s`
	io_runtime=`expr ${io_end} - ${io_begin}`
	echo "IO_runtime,${io_runtime}" >> ${scp_dir}/RUNTIME.csv
fi
}

function test_net()
{
if [ "$1" != "start" ]
then
echo -e "\033[36m skip testing net \033[0m" 
else
echo -e "\033[36m testing net \033[0m"
	net_begin=`date +%s`
	cd $cur_path
	cd ./network
	./netperf_bw.sh $2
	cd $cur_path
	sleep $stime
	cd ./network
	./tcp_78_1518.sh $2
	cd $cur_path	
	sleep $stime
	net_end=`date +%s`
	net_runtime=`expr $net_end - $net_begin`
	echo "NET_runtime,${net_runtime}" >> ${scp_dir}/RUNTIME.csv
fi
}

function test_cpu()
{
if [ "$1" != "start" ]
then
echo -e "\033[36m skip testng cpu \033[0m" 
else
echo -e "\033[36m testing cpu \033[0m"
	cd  $cur_path
	#curl -o speccpu.tar.gz  -x 47.96.180.231:12345  http://nextupdate.yyclouds.com/speccpu.tar.gz
	#while true
	#do
	#	A=` ls -lh ${scp_dir}/ | grep "1.1G" `
	#	if [ n != "$A"]
        #	then
       # 	A=1
        #	else
        #	sleep 5
        #	break
	#	fi
	#	sleep 5
	#done

	#tar -xf speccpu.tar.gz
	cd ./speccpu
	bash setup.sh 2>&1 > setup.log
	nohup bash -x run_speccpu.sh &
	cd $cur_path
fi
}


##################################################################################################
#main
################################################################################################


#网卡压力测试服务主机
IP=223.111.192.179
scp_dir=/data/script/new_yy_test_tools
#scp_dir=`pwd`

test_io $flag_io

test_mem $flag_mem

test_net ${flag_net} $IP

test_cpu $flag_cpu

