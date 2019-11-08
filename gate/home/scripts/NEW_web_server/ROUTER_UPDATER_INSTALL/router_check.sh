#!/bin/sh

#cd /home/scripts/KASSA_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT
MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"
#MYSQL="-h 10.0.0.240 -N -D pelican -u root -p111111"

get_ip ()
{
    FILE=$1
    # TPLINK ALL
    PARAM=`mysql $MYSQL -e "SELECT DISTINCT(CONCAT(i.mask, '.4')) FROM internet as i,object as o WHERE o.open=1 and i.id_object=o.id and s.model NOT IN ('ASUS')"`

    # TPLINK NOT Synced
    #PARAM=`mysql $MYSQL -e "SELECT s.lanip FROM stat as s WHERE ver<7 and s.model not in ('ASUS')"`
    echo $PARAM
}

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
IP_KASSA="192.168.209.4"
PASS='nhf[nty,thu01'
#echo $IP_KASSA
#exit
for ip in $IP_KASSA ; do

fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
if [ "$?" = 0 ]                                                                                                                                           
then                                                                                                                                                      
  echo "PING" $ip " - OK"                                                                                                                                       

    ### 3D Scaner Check ###
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "wget -O - http://update.neo63.ru/script/tp-link/update.sh | sh"
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "wget -O /etc/scripts/update.sh http://update.neo63.ru/script/tp-link/update.sh && chmod 777 /etc/scripts/update.sh && /etc/init.d/cron enable && /etc/init.d/cron restart"

    if [ $? -ne 0 ]; then
    echo $ip - Error! >> ./LOG.TXT
    echo $ip - Error!
    else
    echo $ip - OK! INSTALLED >> ./LOG.TXT
    echo $ip - OK! INSTALLED

    #Mysql update puppet info
#    echo "update ws_kas set 3D_scanner='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    fi
    ### END 3D Scaner Check ###

else                                                                                                                                                      
  echo "PING" $ip " - Unreachetable"                                                                                                                            
  echo $ip - PING ERROR >> ./LOG.TXT
                                                                                                                                                          
fi 

done

#INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=1" `
#NOT_INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=0" `
#echo "На $(date +%d.%m.%Y) установлено $INSTALLED сканеров"
#echo "Осталось установить $NOT_INSTALLED сканеров. Удачи!"
