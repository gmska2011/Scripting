#!/bin/bash
host="$1"
[[ $# -eq 0 ]] && { echo "Использование: $0 имя.хоста.com"; exit 1;}
ips=$(host "$host" | awk -F'address' '{ print $2}' | sed -e 's/^ //g')
ssh-keygen -R "$host"
for i in $ips
do
    ssh-keygen -R "$i"
done