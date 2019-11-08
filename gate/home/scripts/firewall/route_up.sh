#!/bin/sh
# OPENVPN1 Server
# WARNING!!! ALL ROUTES BY OSPF!!!

/sbin/ip ru del from 198.18.254.32 lookup SIP
/sbin/ip ru del from 198.18.254.32 lookup SIP
/sbin/ip ru add from 198.18.254.32 lookup SIP

/sbin/ip ro add default via 198.18.254.1 dev eth6 table SIP
/sbin/ip ro add 198.19.255.155 via 198.18.254.1 dev eth6

# Ебучий маршрут
/sbin/ip ro delete 10.0.0.0/8
/sbin/ip ro add 10.63.0.0/23 dev eth0  proto kernel  scope link  src 10.63.1.4

##### WIFI
#/sbin/ip ru del from 192.168.1.0/24 lookup VT2
#/sbin/ip ru del from 192.168.1.0/24 lookup VT2
#/sbin/ip ru add from 192.168.1.0/24 lookup VT2
#/sbin/ip ro add 192.168.1.0/24 dev eth0.100 table VT2
#/sbin/ip ro add default dev eth1.2600 table VT2

#/sbin/ip ru del from 10.20.30.0/24 lookup VT1
#/sbin/ip ru del from 10.20.30.0/24 lookup VT1
#/sbin/ip ru add from 10.20.30.0/24 lookup VT1
#/sbin/ip ro add 10.20.30.0/24 dev eth0.200 table VT1
#/sbin/ip ro replace default dev eth1.2600 table VT1
