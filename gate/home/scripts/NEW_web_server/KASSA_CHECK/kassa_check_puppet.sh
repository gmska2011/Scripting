#!/bin/sh

WORK_DIR=`pwd`
DATE=`date "+%Y-%m-%d_%H:%M"`
LOGFILE="LOG_PUPPET.TXT"
cd $WORK_DIR

echo $DATE > $LOGFILE

get_ip ()
{
    FILE=$1
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
    COUNT=`/usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "puppet agent -t"|grep 'puppet cert clean'`
    #echo $COUNT
	if [ $COUNT -ge 0 ]; then
            echo $ip PUPPET ERROR! >> $LOGFILE
            echo $ip PUPPET ERROR!
        else
            echo $ip OK
        fi
        ### END Check ###
        #Mysql update info
    	#echo "update ws_kas set upos_errors='$COUNT' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;
else
  echo "PING" $ip " - Unreachetable"
  echo $ip - PING ERROR >> $LOGFILE
                                                                                                                                                          
fi 
exit
done

#INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=1" `
#NOT_INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=0" `
#echo "На $(date +%d.%m.%Y) установлено $INSTALLED сканеров"
#echo "Осталось установить $NOT_INSTALLED сканеров. Удачи!"
