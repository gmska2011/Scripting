#!/bin/sh

cd /home/scripts/KASSA_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG_sber.TXT

get_ip ()
{
 FILE=$1
#####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id" `
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
#IP_KASSA="192.168.0.15"
PASS='111111'


for ip in $IP_KASSA ; do

fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
if [ "$?" = 0 ]                                                                                                                                           
    then                                                                                                                                                      
    ### Check ###
    COUNT=`/usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "dmesg|grep ttyACM |wc -l"`
    #echo $COUNT
	if [ $COUNT -ge 5 ]; then
            echo $ip\; ERRORS - $COUNT\; - Sberbank in ZHOPA now! >> ./LOG_sber.TXT
            echo $ip\; ERRORS - $COUNT\; - Sberbank in ZHOPA now!
        else
            echo $ip - $COUNT OK! >> ./LOG_sber.TXT
	    echo $ip - $COUNT OK!
        fi
        ### END Check ###
        #Mysql update info
        echo "update ws_kas set upos_errors='$COUNT' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;
else
  echo "PING" $ip " - Unreachetable"
  echo $ip - PING ERROR >> ./LOG_sber.TXT
                                                                                                                                                          
fi 

done

#INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=1" `
#NOT_INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=0" `
#echo "На $(date +%d.%m.%Y) установлено $INSTALLED сканеров"
#echo "Осталось установить $NOT_INSTALLED сканеров. Удачи!"
