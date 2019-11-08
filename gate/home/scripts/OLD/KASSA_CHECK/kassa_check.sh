#!/bin/sh

cd /home/scripts/KASSA_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT

get_ip ()
{
 FILE=$1
#####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=0" `
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
#IP_KASSA="192.168.74.11"
PASS='111111'


for ip in $IP_KASSA ; do

fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
if [ "$?" = 0 ]                                                                                                                                           
then                                                                                                                                                      
#  echo "PING" $ip " - OK"                                                                                                                                       

    ### 3D Scaner Check ###
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "lsusb |grep 0c2e:0be1"
    if [ $? -ne 0 ]; then
    echo $ip - 3D Scanner not found! >> ./LOG.TXT
    echo $ip - 3D Scanner not found!
    else
    echo $ip - OK! INSTALLED and ADDED to DATABASE >> ./LOG.TXT
    echo $ip - OK! INSTALLED and ADDED to DATABASE

    #Mysql update puppet info
    echo "update ws_kas set 3D_scanner='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    fi
    ### END 3D Scaner Check ###

else                                                                                                                                                      
  echo "PING" $ip " - Unreachetable"                                                                                                                            
  echo $ip - PING ERROR >> ./LOG.TXT
                                                                                                                                                          
fi 

done

INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=1" `
NOT_INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=0" `
echo "На $(date +%d.%m.%Y) установлено $INSTALLED сканеров"
echo "Осталось установить $NOT_INSTALLED сканеров. Удачи!"
