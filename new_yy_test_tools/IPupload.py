#!/usr/bin/python2.7
# -*- coding: utf-8 -*- 
import os
import csv
import re
import sys
import json
import urllib2
import chardet
import datetime
import requests

reload(sys)
sys.setdefaultencoding('utf-8')

ips = os.popen("LANG=C ifconfig | grep \"inet addr\" | grep -v \"127.0.0.1\" | grep -v \"172.17.0\" | awk -F \":\" '{print $2}' | awk '{print $1}'").readlines()
IP = ips[0].strip()
OUT=[]
IP_OUT=IP+"OUT"
IP_OUT={}
IP_addr='./'+IP+"/"
IP_OUT['ip_add']=IP 
data = {
        "action":"query",
        "param":"{\"ips\":\""+IP+"\"}"
       }
#print(data)
header = {'Content-Type': 'application/json'}
request = requests.post(url='http://********************',headers=header,json=data)
#print(request.text)
res = request.text
out={}
out = json.loads(res)
print(out)
idc_name = out['object']['resultList'][0]['idcName']
print(idc_name)
#print(type(idc_name))
#print(type(A))
IP_OUT['IDC_NAME']=idc_name
#print(IP_OUT)
with open(IP_addr+'result.csv') as f:
	for line in  f:
		if line.split(',')[1] == "RAND" and line.split(',')[3] == "4" and line.split(',')[4] == "70" :
			key=line.split(',')
			IP_OUT['read_iops']=key[6]
			IP_OUT['read_lt']=key[7]
			IP_OUT['write_iops']=key[9]
			IP_OUT['write_lt']=key[10]

		if line.split(',')[1] == "SEQ" and line.split(',')[3] == "1024" and line.split(',')[4] == "0" :
			key=line.split(',')
			IP_OUT['1024_write']=key[8]

with open(IP_addr+'TCP_RR_netperf.csv') as f:
	for line in f:
		key=line.split(',')
		if key[0] == '78B':
			IP_OUT['TCP_78B_Packet']=key[2]
		if key[0] == '1518B':
			IP_OUT['TCP_1518B_Packet']=key[2]
		if key[0] == '20000B' :
			IP_OUT['TCP_THROUGHPUT']=key[1]

with open(IP_addr+'TCP_RR_pack.csv') as f:
	for line in f:
		key=line.split(',')
		if key[0] == '78B':
			IP_OUT['TCP_78B_Packet']=key[2]
		if key[0] == '1518B':
			IP_OUT['TCP_1518B_Packet']=key[2]
		if key[0] == '20000B' :
			IP_OUT['TCP_THROUGHPUT']=key[1]

with open(IP_addr+'UDP_RR_pack.csv') as f:
	for line in f:
		key=line.split(',')
		if key[0] == '78B':
			IP_OUT['UDP_78B_Packet']=key[2]
		if key[0] == '1518B':
			IP_OUT['UDP_1518B_Packet']=key[2]
		if key[0] == '20000B' :
			IP_OUT['UDP_THROUGHPUT']=key[1]

with open(IP_addr+'UDP_RR_netperf.csv') as f:
	for line in f:
		key=line.split(',')
		if key[0] == '78B':
			IP_OUT['UDP_78B_Packet']=key[2]
		if key[0] == '1518B':
			IP_OUT['UDP_1518B_Packet']=key[2]
		if key[0] == '20000B' :
			IP_OUT['UDP_THROUGHPUT']=key[1]

with open(IP_addr+'mem.csv') as f:
	for line in f:
		key=line.split(',')
		if key[0] == 'Memory Latency':
			IP_OUT['mem_latency']=key[1]
		if key[0] == 'Triad':
			IP_OUT['mem_triad']=key[1]

with open(IP_addr+'CINT2006.001.ref.csv') as f:
	for line in f:
		key=line.split(',')
		if key[0] == 'SPECint_rate_base2006':
		        IP_OUT['cpu_code']=key[1]

with open(IP_addr+'RUNTIME.csv') as f:
	for line in f:
		key=line.split(',')
                IP_OUT['RUNTIME']=int(0)
		if key[0] == 'MEM_runtime':
                        IP_OUT['mem_runtime(m)']=int(key[1])//60
                        IP_OUT['RUNTIME']=IP_OUT['RUNTIME']+int(key[1])//60
		if key[0] == 'IO_runtime':
                        IP_OUT['io_runtime(m)']=int(key[1])//60
                        IP_OUT['RUNTIME']=IP_OUT['RUNTIME']+int(key[1])//60
		if key[0] == 'NET_runtime':
                        IP_OUT['net_runtime(m)']=int(key[1])//60
                        IP_OUT['RUNTIME']=IP_OUT['RUNTIME']+int(key[1])//60
		if key[0] == 'CPU_runtime':
                        IP_OUT['cpu_runtime(m)']=int(key[1])//60
                        IP_OUT['RUNTIME']=IP_OUT['RUNTIME']+int(key[1])//60
nowTime=datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
IP_OUT['test_date']=nowTime

                    #IP_OUT=json.dumps(IP_OUT,encoding="utf-8",ensure_ascii=False)
#IP_OUT=json.loads(IP_OUT)
print(IP_OUT)
#result = str(IP_OUT).decode('unicode-escape').encode('utf-8')
OUT_name="ip_adds:IDC_NAMEs:cpu_codes:mem_latencys:mem_triads:1024_writes:write_iopss:write_lts:read_iopss:read_lts:TCP_THROUGHPUTs:UDP_THROUGHPUTs:UDP_78B_Packets:UDP_1518B_Packets:TCP_78B_Packets:TCP_1518B_Packets,"
OUT="%(ip_add)s,%(IDC_NAME)s,%(cpu_code)s,%(mem_latency)s,%(mem_triad)s,%(1024_write)s,%(write_iops)s,%(write_lt)s,%(read_iops)s,%(read_lt)s,%(TCP_THROUGHPUT)s,%(UDP_THROUGHPUT)s,%(UDP_78B_Packet)s,%(UDP_1518B_Packet)s,%(TCP_78B_Packet)s,%(TCP_1518B_Packet)s,%(io_runtime(m))s,%(cpu_runtime(m))s,%(net_runtime(m))s,%(mem_runtime(m))s,%(test_date)s" %IP_OUT
result=OUT_name+OUT
#print(result)
header = {'Content-Type': 'application/json'}
URL="http://xxx.xxx.xxx.xx:12345/"+result
request1 = urllib2.Request(url=URL)
response = urllib2.urlopen(request1)
#res = response.read()
#with open(IP+'.csv','wb') as c:
#	w = csv.writer(c)
#	title=IP_OUT.keys()
#	w.writerow(title)
#       w.writerow(IP_OUT.values())

