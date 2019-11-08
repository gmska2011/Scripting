#!/bin/sh
rm -rf /home/scripts/copy_dir/bad

get_ip ()
{
 FILE=$1
  PARAM=`cat /home/scripts/copy_kass_south/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
PASS='111111'


for ip in $IP_KASSA ; do
 if [ $? == 0 ] ; then
    echo $ip - OK
    sshpass -p $PASS scp -r /home/scripts/copy_pass/ root@$ip:/home/scripts/  > /dev/null 2>&1
###    sshpass -p $PASS scp  /usr/local/bin/sshpass root@$ip:/usr/local/bin/  > /dev/null 2>&1

 else
	    echo ERROR - BAD PATH - $ip;
	    echo $ip >> /home/scripts/copy_kass_south/bad
 fi    
done
