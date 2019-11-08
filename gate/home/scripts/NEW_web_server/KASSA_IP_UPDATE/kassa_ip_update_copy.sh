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
IP_KASSA="10.20.23.10 10.20.23.11 10.20.23.12"
PASS='111111'


for ip in $IP_KASSA ; do

    fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
    if [ "$?" = 0 ]                                                                                                                                           
        then                                                                                                                                                      
    	    ### Check ###
    	    echo "---------------------"
	    echo "IP - $ip"
	    # SQL from base
	    IPS=`get_ips $ip`
	    IPS2=`echo $IPS | sed 's/'$ip'//'`
	    echo $IPS2 | sed 's/ /\n/g' | awk -F "." {'print $4'} > /tmp/ip
	    echo $IPS
	    /usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no /tmp/ip root@$ip:/home/scripts/copy_pass/
	# COPY SCRIPTS
	 /usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -r -o StrictHostKeyChecking=no /home/scripts/NEW_web_server/KASSA_IP_UPDATE/sync_checks root@$ip:/home/scripts/
	# /usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no /home/scripts/NEW_web_server/KASSA_IP_UPDATE/sync_checks/cron.d/copy_checks root@$ip:/etc/cron.d/
    	else
    	    #echo "PING" $ip " - Unreachetable"
    	    echo $ip - PING ERROR >> ./LOG.TXT
    fi 
done
