#!/bin/sh
get_ip ()
{
 FILE=$1
  PARAM=`cat ./$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
   echo $PARAM
   }

IP_TUN=`get_ip tun1`
IP_TUN3=`get_ip tun3`


for tun in $IP_TUN ; do
ip ro replace $tun dev tun1 table VT1    
 echo $tun
done  

for tun in $IP_TUN3 ; do
ip ro replace $tun dev tun3 table VT1    
 echo $tun
done