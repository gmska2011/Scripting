#!/bin/sh
rm -rf /home/scripts/copy_kass_south/very_very_bad

get_ip ()
{
 FILE=$1
  PARAM=`cat /home/scripts/copy_kass_south/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
   echo $PARAM
   }

IP_KASSA=`get_ip very_bad`
PASS='111111'


for ip in $IP_KASSA ; do
 sshpass -p $PASS scp -o 'StrictHostKeyChecking no' root@$ip:/home/1/.dosemu/drives/c/SOUTH.TML/POSTSTOP.PRG /home/scripts/copy_kass_south/tmp/ # > /dev/null 2>&1
 if [ $? == 0 ] ; then 
    echo $ip - OK
    sshpass -p $PASS scp /home/scripts/copy_kass_south/new/POSTSTOP.PRG root@$ip:/home/1/.dosemu/drives/c/SOUTH.TML/POSTSTOP.PRG # > /dev/null 2>&1
 else echo ERROR - BAD PATH - $ip;
echo $ip >> /home/scripts/copy_kass_south/very_very_bad
 fi
done
