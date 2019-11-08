#!/bin/sh

cd /home/scripts/NEW_web_server/KASSA_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT
MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"

get_ip ()
    {
        PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE o.open=1 and w.id_object=o.id and w.type=1"`
        echo $PARAM
    }
get_id_ws ()
    {
    VAR=$1
    PARAM=`mysql $MYSQL -e "SELECT w.id FROM ws as w, object as o WHERE w.ip='$VAR' and o.open=1 and w.id_object=o.id limit 1" `
    echo $PARAM
    }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
#IP_KASSA="192.168.27.10 192.168.27.11"
PASS='111111'


for ip in $IP_KASSA ; do

fping -c1 -t1000 $ip 2>/dev/null 1>/dev/null                                                                                                              
if [ "$?" = 0 ]                                                                                                                                           
then                                                                                                                                                      
#  echo "PING" $ip " - OK"                                                                                                                                       
    MODEL=""
    ID_WS=`get_id_ws "$ip"`

    echo "delete from scanners where id_ws='$ID_WS' ;"|mysql $MYSQL;

    ### 1450 3D Scaner Check ###
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "lsusb |grep 0c2e:0ca1"
    if [ $? -ne 0 ]; then
        echo $ip - 1450g Scanner not found! >> ./LOG.TXT
#        echo $ip - 1450 Scanner not found!
    else
        echo $ip - 1450g FOUND >> ./LOG.TXT
        echo $ip - 1450g FOUND
        MODEL="1450g"
        echo "insert into scanners (id_ws, model) values ('$ID_WS','$MODEL') ON DUPLICATE KEY UPDATE model='$MODEL' ;"|mysql $MYSQL;
	echo "insert into scanners (id_ws, model) values ('$ID_WS','$MODEL') ON DUPLICATE KEY UPDATE model='$MODEL' ;"
    fi
    ### 7580 3D Scaner Check ###
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "lsusb |grep 0c2e:0be1"
    if [ $? -ne 0 ]; then
        echo $ip - 7580g Scanner not found! >> ./LOG.TXT
    #    echo $ip - 7580 Scanner not found!
    else
        echo $ip - 7580g FOUND! >> ./LOG.TXT
        echo $ip - 7580g FOUND!
        MODEL="7580g"
	echo "insert into scanners (id_ws, model) values ('$ID_WS','$MODEL') ON DUPLICATE KEY UPDATE model='$MODEL' ;"|mysql $MYSQL;
	echo "insert into scanners (id_ws, model) values ('$ID_WS','$MODEL') ON DUPLICATE KEY UPDATE model='$MODEL' ;"
    fi



else                                                                                                                                                      
  echo "PING" $ip " - Unreachetable"                                                                                                                            
  echo $ip - PING ERROR >> ./LOG.TXT
                                                                                                                                                          
fi 

done
