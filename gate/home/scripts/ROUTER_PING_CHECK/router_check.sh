#!/bin/sh

cd /home/scripts/KASSA_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT
MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"

get_ip ()
    {
        PARAM=`mysql $MYSQL -e "SELECT i.mask FROM internet as i,object as o WHERE o.open=1 and i.id_object=o.id"`
        echo $PARAM
    }

#get_ip ()
#{
# FILE=$1
    #PARAM=`cat /tmp/$FILE`
    #####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
#      PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id group by shop.id" `
#   echo $PARAM
#   }

IP_KASSA=`get_ip`
#IP_KASSA=$PARAM
#IP_KASSA="192.168.74.11"
PASS='nhf[nty,thu01'


for ip in $IP_KASSA ; do

fping -c1 -t1000 "$ip.4" 2>/dev/null 1>/dev/null 
if [ "$?" = 0 ]                                                                                                                                           
then                                                                                                                                                      
  echo "PING" $ip.4" - OK"                                                                                                                                       

    ### 3D Scaner Check ###
#    /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=1 -o 'StrictHostKeyChecking no' root@$ip "lsusb"

#    if [ $? -ne 0 ]; then
#    echo $ip - 3D Scanner not found! >> ./LOG.TXT
#    echo $ip - 3D Scanner not found!
#    else
#    echo $ip - OK! INSTALLED and ADDED to DATABASE >> ./LOG.TXT
#    echo $ip - OK! INSTALLED and ADDED to DATABASE

    #Mysql update puppet info
#    echo "update ws_kas set 3D_scanner='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
#    fi
    ### END 3D Scaner Check ###

else                                                                                                                                                      
  echo "PING" $ip.4 " - Unreachetable"                                                                                                                            
  echo "$ip.4" >> ./LOG.TXT
                                                                                                                                                          
fi 

done
