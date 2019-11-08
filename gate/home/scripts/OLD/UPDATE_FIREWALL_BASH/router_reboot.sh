#!/bin/bash

get_ip ()
 {
  FILE=$1
  #####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id group by shop.id" | awk -F "." '{print $1"."$2"."$3".4"}'`
#  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT DISTINCT(CONCAT(SUBSTRING_INDEX(ip_ws, '.', 3), '.4')) FROM ws"`
 
  echo $PARAM

 }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM


for ip in $IP_KASSA ; do

  echo "PING" $ip " - OK"                                                                                                                                       
    ### 3D Scaner Check ###
    /usr/bin/sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@$ip 'reboot' 

   if [ $? -ne 0 ]; then
    echo $ip - Reboot Error>> ./LOG_reboot.TXT
    echo $ip - Reboot Error!
    else
    echo $ip - OK! >> ./LOG_reboot.TXT
    echo $ip - OK! 

    #Mysql update puppet info
#    echo "update ws_kas set 3D_scanner='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;
    fi
    ### END 3D Scaner Check ###


done
