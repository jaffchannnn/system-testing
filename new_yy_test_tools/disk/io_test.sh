#/bin/bash

vendor=`dmidecode -t system|grep -i Manufacturer:|awk -F " " '{print $2}'`
server_type="$1"
server_type=`echo $server_type|awk -F "_" '{print $1}'`
disk_info="$2"

io_test()
{
	case $server_type in
		A1)
		./fio.sh -d "/dev/sdb 3" -n 4 -t 2 -y y -m "$disk_info"
		;;
		A2)
		./fio.sh -d "/dev/sdb" -n 1 -t 2 -y y -m "$disk_info"
		;;
		A3)
		./fio.sh -d "/dev/sdb" -n 4 -t 2 -y y -m "$disk_info"
		;;
		A4)
		./fio.sh -f /data/test.dat -s 1300 -n 4 -t 1 -y y -m "$disk_info"
		;;
		B2)
		./fio.sh -f /data/test.dat -s 200 -n 2 -t 1 -y y -m "$disk_info"
		;;
		B3)
		./fio.sh -d "/dev/sdb" -n 1 -t 2 -y y -m "$disk_info"
		;;
		C2)
		./fio.sh -f /data/test.dat -s 50 -n 1 -t 1 -y y -m "$disk_info"
		;;
		C5)
		./fio.sh -d "/dev/sdb" -n 1 -t 0 -y y -m "$disk_info"
		;;
		YS2)
		./fio.sh -d "/dev/sdb" -n 10 -t 0 -y y -m "$disk_info"
		;;
		YS4)
		./fio.sh -d "/dev/sdb 11" -n 12 -t 0 -y y -m "$disk_info"
		;;
		YS7)
		./fio.sh -d "/dev/sdb 35" -n 36 -t 0 -y y -m "$disk_info"
		;;
		YS8)
		./fio.sh -d "/dev/sdb 11" -n 12 -t 0 -y y -m "$disk_info"
		;;
		*)
		echo "Wrong server type!"
	esac
}
io_test
