#!/bin/bash
all="tun0 tun1 tun2 tun3"
for tun in  $all ; do
    echo $tun
    tc qdisc del dev $tun root
    tc qdisc add dev $tun root handle 1: prio priomap 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 0
    tc qdisc add dev $tun parent 1:1 handle 10: sfq limit 3000
    tc qdisc add dev $tun parent 1:2 handle 20: sfq
    tc qdisc add dev $tun parent 1:3 handle 30: sfq
    tc filter add dev $tun protocol ip parent 1: prio 1 handle 5 fw flowid 1:1
    tc filter add dev $tun protocol ip parent 1: prio 1 handle 6 fw flowid 1:2
    tc filter add dev $tun protocol ip parent 1: prio 1 handle 7 fw flowid 1:3
done    