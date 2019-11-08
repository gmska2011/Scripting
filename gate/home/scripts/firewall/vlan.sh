#!/bin/sh
#/sbin/modprobe 8021q

#/sbin/ifconfig eth1 down
#/sbin/ifconfig eth1 0.0.0.0 up

#/sbin/ifconfig eth2 down
#/sbin/ifconfig eth2 0.0.0.0 up

#/usr/bin/vconfig add eth1 3501
#/sbin/ip ro add default via 85.114.181.161 dev eth1.2600
#/sbin/ip ro add default via 81.28.162.1 dev eth1.3501
#/sbin/ifconfig eth1.3501 81.28.162.69 netmask 255.255.255.0 up

#/sbin/vconfig add eth1 2600
#/sbin/vconfig rem eth1.634

#/sbin/vconfig add eth2 634
###/sbin/vconfig add eth1 634

## OLD IP!!!
#/sbin/ip ro add default via 85.114.181.161 dev eth1.2600:1
#/sbin/ifconfig eth1.2600:1 85.114.181.162 netmask 255.255.255.252 up

##/sbin/ifconfig eth1.634 10.10.10.4 netmask 255.255.255.0 up
##/sbin/ifconfig eth1.634 hw ether f8:1a:67:02:b5:c1

#/sbin/ifconfig eth2 10.10.10.4 netmask 255.255.255.0 up
#/sbin/ifconfig eth2 hw ether f8:1a:67:02:b5:c1

## NEW IP !!!!
#/sbin/ip ro add default via 81.28.162.1 dev eth1.2600
#/sbin/ifconfig eth1.2600 81.28.162.69 netmask 255.255.255.0 up

#/sbin/ifconfig eth1.3501 85.114.181.162 netmask 255.255.255.252 up
#/sbin/ip ro add default via 85.114.181.161 dev eth1.3501

#/sbin/ip ru del from 10.10.10.4 lookup INET
#/sbin/ip ru del from 10.10.10.4 lookup INET
#/sbin/ip ru add from 10.10.10.4 lookup INET

#/sbin/ip ru del from 10.10.10.0/24 lookup INET
#/sbin/ip ru del from 10.10.10.0/24 lookup INET
#/sbin/ip ru add from 10.10.10.0/24 lookup INET
#/sbin/ip ro add default dev eth1.2600 table INET
#/sbin/ip ro add 192.168.0.0/24 via 192.168.0.4 table INET
#/sbin/ip ro add 10.0.0.0/24 via 10.0.0.4 table INET
#/sbin/ip ro add 10.10.10.0/24 dev eth2 table INET
#/sbin/ip ro add 10.63.0.0/16 dev tnl63 table INET



/home/scripts/firewall/route_up.sh

exit 0