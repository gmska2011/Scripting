#!/bin/sh

cd /home/scripts/NEW_web_server/KASSA_IP_UPDATE/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT
MYSQL="-h 10.0.0.242 -N -D pelican -u dbadmin -pgtkbrfirf2019"

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
#IP_KASSA="192.168.31.10"
PASS='111111'
SSH_OPTIONS='-q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=2'

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
	    /usr/bin/sshpass -p $PASS scp $SSH_OPTIONS /tmp/ip root@$ip:/home/scripts/copy_pass/
    	else
    	    #echo "PING" $ip " - Unreachetable"
    	    echo $ip - PING ERROR >> ./LOG.TXT
    fi 
done
