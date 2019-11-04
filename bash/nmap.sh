#!/bin/bash

nmap -sn 10.0.10.0/24 > /tmp/ikvm

readarray array < /tmp/ikvm

for ((a=0; a < ${#array[*]}; a++)); do
    if [[ ${array[$a]} =~ 10.0.* ]]; then
	ip=$(echo ${array[$a]}|awk '{print $5}'| tr '[:upper:]' '[:lower:]')
	mac=$(echo ${array[$a+2]}|awk '{print $3}'| tr '[:upper:]' '[:lower:]')
	if [[ $mac =~ ":" ]]; then
	    mac=$mac
	echo "$mac $ip"
	else
	    mac=""
	fi
    fi
done
