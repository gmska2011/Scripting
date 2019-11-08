#!/bin/sh
rm -rf /home/scripts/copy_kass_south/bad_del_post

get_ip ()
{
 FILE=$1
  PARAM=`cat /home/scripts/copy_kass_south/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
PASS='111111'


for ip in $IP_KASSA ; do
 sshpass -p $PASS ssh root@$ip 'rm -rf /home/1/drives/c/south.tml/poststop.prg'
 if [ $? == 0 ] ; then
    echo $ip - OK
 else
    sshpass -p $PASS root@$ip 'rm -rf /home/1/.dosemu/drives/c/south.tml/poststop.prg'
     if [ $? == 0 ] ; then
     echo $ip - OK
     else 
        sshpass -p $PASS ssh root@$ip 'rm -rf /home/1/.dosemu/drives/c/SOUTH.TML/poststop.prg'
        if [ $? == 0 ] ; then
        echo $ip - OK
        else
	    echo ERROR - BAD PATH - $ip;
	    echo $ip >> /home/scripts/copy_kass_south/bad_del_post
	fi
    fi
 fi    
done
