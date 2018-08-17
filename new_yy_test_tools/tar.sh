#!/bin/bash
IP=`ifconfig | grep "inet addr" | head -1 | awk -F ":" '{print $2}' |awk '{print $1}'`
mkdir -p /data/${IP}


cd /data/script/new_yy_test_tools/

find -name "*csv" | grep -v tools | while read line ;do 
cp $line /data/${IP}
done

cd /data/
tar -zcf ${IP}.tar.gz ${IP}
cp -r ${IP} /data/script/new_yy_test_tools/

