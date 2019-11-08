#!/bin/sh

cd /home/scripts/NEW_web_server/KASSA_IP_UPDATE/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT
MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"

get_ip ()
    {
        PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE o.open=1 and w.id_object=o.id and w.type=1"`
        echo $PARAM
    }

get_ips ()
    {
	KASSA=$1
        PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE w.id_object IN (SELECT w.id_object FROM ws as w,object as o WHERE w.ip='$KASSA' and o.open=1 and w.id_object=o.id and w.type=1) and o.open=1 and w.id_object=o.id and w.type=1"`
        echo $PARAM
    }

IP_KASSA=`get_ip`
#IP_KASSA=$PARAM
#IP_KASSA="192.168.202.10 192.168.202.11"
PASS='111111'


for ip in $IP_KASSA ; do

    fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
    if [ "$?" = 0 ]                                                                                                                                           
        then                                                                                                                                                      
    	    ### Check ###
    	    echo "---------------------"
	    echo "IP - $ip"
	    # SQL from base

WC=`/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find /home/checks/$ip/ -type f -newermt '2017-12-20 08:00' ! -newermt '2017-12-22 23:59' |wc -l"`
	echo "CHECKS $WC"
        echo "update ws set check20th='$WC' where ip='$ip';" | mysql $MYSQL;
#	    /usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no /tmp/ip root@$ip:/home/scripts/copy_pass/
	# COPY SCRIPTS
	# /usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -r -o StrictHostKeyChecking=no /home/scripts/NEW_web_server/KASSA_IP_UPDATE/sync_checks root@$ip:/home/scripts/
	# /usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no /home/scripts/NEW_web_server/KASSA_IP_UPDATE/sync_checks/cron.d/copy_checks root@$ip:/etc/cron.d/
    	else
    	    #echo "PING" $ip " - Unreachetable"
    	    echo $ip - PING ERROR >> ./LOG.TXT
    fi 
done
