#!/bin/bash

result_dir=$1
if [ -z $3 ]; then
	interval=30
else
	interval=$3
fi
if [ $# -lt 2 ]; then
	result_dir="."
	sample=0
else
	result_dir=$1
	sample=$2
	sample=$((sample/interval+1))
fi

mpstat -P ALL $interval $sample >${result_dir}/CPU.log &
free -m -s $interval -c $sample >${result_dir}/memory.log &
iostat -xm $interval -c $sample >${result_dir}/io.log &
sar -n DEV $interval $sample >${result_dir}/net.log &