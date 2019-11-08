#!/bin/sh

#cd /home/scripts/KASSA_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT

MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"

get_ip ()
{
    FILE=$1
    # ASUS ONLY
    PARAM=`mysql $MYSQL -e "SELECT DISTINCT(CONCAT(i.mask, '.4')) FROM internet as i,object as o WHERE o.open=1 and i.id_object=o.id and i.router='ASUS'"`
    echo $PARAM
}

IP_KASSA=`get_ip ip`
IP_KASSA="192.168.241.4"
PASS='nhf[nty,thu01'
echo $IP_KASSA

for ip in $IP_KASSA ; do

    fping -c1 -t30 $ip 2>/dev/null 1>/dev/null                                                                                                              
    #echo "1"
    if [ "$?" = 0 ]                                                                                                                                           
    then                                                                                                                                                      
	echo "PING" $ip " - OK"                                                                                                                                       

        ### 3D Scaner Check ###
        /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' admin@$ip "wget -O - http://update.neo63.ru/script/asus/update.sh | sh"
        /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' admin@$ip "wget -O /tmp/etc/crontabs/admin http://update.neo63.ru/script/asus/admin && wget -O /tmp/local/sbin/update.sh http://update.neo63.ru/script/asus/update.sh && chmod 777 /tmp/local/sbin/update.sh && crontab /tmp/etc/crontabs/admin && PATH=/sbin:/usr/sbin:/bin:/usr/bin && export PATH && flashfs save && flashfs commit && flashfs enable"

        if [ $? -ne 0 ]; then
	    echo $ip - Error! >> ./LOG.TXT
	    echo $ip - Error!
        else
	    echo $ip - OK! INSTALLED >> ./LOG.TXT
	    echo $ip - OK! INSTALLED
        #Mysql update puppet info
	#echo "update ws_kas set 3D_scanner='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
        fi
    else                                                                                                                                                      
	echo "PING" $ip " - Unreachetable"                                                                                                                            
	echo $ip - PING ERROR >> ./LOG.TXT
    fi 
done
