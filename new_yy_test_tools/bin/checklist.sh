#!/bin/bash

pkill mpstat
pkill iostat
pkill free
pkill sar
if  ! which iostat 2>&1 >/dev/null; then
	echo "Please install sysstat first."
	exit 1
fi
if ! which lsscsi 2>&1 >/dev/null; then
	echo "No lsscsi command, exit!"
	exit 1
fi
if ! which lspci 2>&1 >/dev/null; then
	echo "No lspci command, exit!"
	exit 1
fi
if ! which bc 2>&1 >/dev/null; then
	echo "No bc command, exit!"
	exit 1
fi
