#!/bin/bash

get_ip ()
 {
  FILE=$1
  #####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id not in (99) and ws_kas.id_mag=shop.id group by shop.id" | awk -F "." '{print $1"."$2"."$3".4"}'`
#  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT DISTINCT(CONCAT(SUBSTRING_INDEX(ip_ws, '.', 3), '.4')) FROM ws"`
 
  echo $PARAM

 }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM


for ip in $IP_KASSA ; do

  echo $ip                                                                                                                                        
    ### 3D Scaner Check ###
#    /usr/bin/sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@$ip 'echo "\$IPTABLES -I FORWARD 1 -i \$LAN -p udp --dport 123  -j ACCEPT" >>/etc/firewall.user' 
    /usr/bin/sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@$ip "cat /etc/firewall.user |grep 'ACCEPT\$IP'" 
#    /usr/bin/sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@$ip 'reboot'

done
