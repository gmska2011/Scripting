#!/bin/sh
cd /home/scripts/PUPPET_INSTALL

DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT

get_ip ()
{
 FILE=$1
#####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and ws_kas.puppet=0" `
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
#IP_KASSA="192.168.74.11"
PASS='111111'


for ip in $IP_KASSA ; do

fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
if [ "$?" = 0 ]                                                                                                                                           
then                                                                                                                                                      
  echo "PING" $ip " - OK"                                                                                                                                       
                                                                                                                                                          
    #/usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' root@$ip:/home/1/drives/c/south.tml/POSTSTOP.PRG /home/scripts/copy_kass_south/tmp/
    echo TRYING $ip :
    echo "=========== COPYING APT.CONF ============="
    /usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' ./FILES/apt.conf root@$ip:/etc/apt/apt.conf 

    echo "====== APT-GET UPDATE & INSTALL PUPPET ======="
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "apt-get update && apt-get install -y puppet"

    echo "====== COPY PUPPET CONF======="
    /usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' ./FILES/puppet root@$ip:/etc/default/puppet 
    cp ./FILES/puppet.conf ./tmp/
    echo certname=$ip >> ./tmp/puppet.conf
    /usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' ./tmp/puppet.conf root@$ip:/etc/puppet/puppet.conf

    echo "====== PUPPET AGENT START ======="
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "puppet agent -t"
    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "/etc/init.d/puppet restart"
    if [ $? -ne 0 ]; then
    echo $ip - ERROR >> ./LOG.TXT
    else
    echo $ip - OK >> ./LOG.TXT

    #Mysql update puppet info
    echo "update ws_kas set puppet='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    fi
    ### END PUPPET INSTALL ###

else                                                                                                                                                      
  echo "PING" $ip " - Unreachetable"                                                                                                                            
  echo $ip - ERROR >> ./LOG.TXT
                                                                                                                                                          
fi 

done
