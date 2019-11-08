#!/bin/bash

cd /home/scripts/NEW_web_server/KASSA_CASH/
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

#IP_KASSA=`get_ip`
#IP_KASSA=$PARAM
#IP_KASSA="10.20.23.10 10.20.23.11 10.20.23.12"
IP_KASSA="192.168.229.10"
PASS='111111'


for ip in $IP_KASSA ; do

    fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
    if [ "$?" = 0 ]                                                                                                                                           
        then                                                                                                                                                      
    	    ### Check ###
    	    echo "---------------------"
	    echo "IP - $ip"
	    # for 7days
	    for (( n=0; n<=6; n++ )) 
	    do
    		# Kassa query
		DATE=`date "+%Y-%m-%d" -d "$n day ago"`
#		WC=`/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find /home/checks/$ip/ -type f -newermt '$DATE 5:00' ! -newermt '$DATE 23:59' |wc -l"`
		LINK=`/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find /home/checks/$ip/ -type f -newermt '$DATE 0:00' ! -newermt '$DATE 23:59'"`
		for line in $LINK; do 
		    echo "$line"; 
		
		NAME=`echo $line|awk -F '/' '{print $6}'`
		echo "NAME $NAME"
		echo "LINK $line"
		# INSERT
   		echo "insert into cash_vouchers (\`ip_ws\`, \`name_vouchers\`, \`link\`) VALUES ('$ip','$NAME','$line');"
    		echo "insert into cash_vouchers (\`ip_ws\`, \`name_vouchers\`, \`link\`) VALUES ('$ip','$NAME','$line');"| mysql $MYSQL;
#		echo "insert into cash_vouchers (\`ip_ws\`, \`name_vouchers\`) VALUES ('$ip','$WC','$DATE');" | mysql $MYSQL;
		done
	    done
    	else
    	    #echo "PING" $ip " - Unreachetable"
    	    echo $ip - PING ERROR >> ./LOG.TXT
    fi 
done
