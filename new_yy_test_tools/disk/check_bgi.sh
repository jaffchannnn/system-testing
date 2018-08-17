#!/bin/bash

RAID="OK"
vendor=`dmidecode -t system|grep -i Manufacturer|awk -F " " '{print $2}'`
lsi=`megacli -adpCount|grep "Controller Count:"|awk -F " " '{print $3}'|awk -F "." '{print $1}'`
if [ $lsi -ne 0 ]; then
	vd=`megacli -LDInit -ShowProg -LALL -aALL|grep "Initialization on VD"|wc -l`
	vd_not_bgi=`megacli -LDInit -ShowProg -LALL -aALL|grep "not in progress"|wc -l`
	if [ $vd_not_bgi -ne $vd ]; then
		RAID="in initialization"
	fi
fi

if [ $vendor = "HP" ]; then
	which hpacucli &>/dev/null
	if [ $? -ne 0 ]; then
		dpkg -i ../bin/tools/hpacucli_9.40-13_amd64.deb
	fi
	pmc=`hpacucli ctrl all show|grep "Smart Array"|wc -l`
	if [ $pmc -ne 0 ]; then
	hp_vd=`hpacucli ctrl all show config detail|grep "Parity Initialization Status"|wc -l`
	hp_vd_not_bgi=`hpacucli ctrl all show config detail|grep "Parity Initialization Status"|grep "Initialization Completed"|wc -l`
		if [ $hp_vd_not_bgi -ne $hp_vd ]; then
			RAID="in initialization"
		fi
	fi
fi
echo "RAID is $RAID"