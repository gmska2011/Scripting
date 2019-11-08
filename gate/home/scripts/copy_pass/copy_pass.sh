#!/bin/bash
get_ip ()
{
 FILE=$1
  PARAM=`cat /home/scripts/copy_pass/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
#IF=`ifconfig |grep 192.168. |awk '{print $2}'|sed 's/addr://'|sed 's/^\(.*\).$/\1/'|sed 's/^\(.*\).$/\1/'`

IF=`ip ro |grep default |awk '{print $3}'|sed 's/^\(.*\).$/\1/'`


PASS='111111'

PATH1='/home/1/drives/c/south.tml/common/bd_user.cdx'
PATH2='/home/1/drives/c/south.tml/common/bd_user.dbf'
PATH3='/home/1/drives/c/south.tml/common/bd_users.dbf'
PATH4='/home/1/drives/c/south.tml/common/bd_users.fpt'

PATHOUT=':/home/1/drives/c/south.tml/common/'

PATHSSH='/home/1/drives/c/south.tml/common/'

for ip in $IP_KASSA ; do
#echo $PATH1
echo $IF

#exit
#/usr/bin/scp $PATH1 root@$IF$ip:/tmp
### Backup Old Files
sshpass -p $PASS /usr/bin/ssh -o StrictHostKeyChecking=no root@$IF$ip "if [ -e /home/copy/ ] ; then cp {$PATH1,$PATH2,$PATH3,$PATH4} /home/copy/ ; else mkdir /home/copy && cp {$PATH1,$PATH2,$PATH3,$PATH4} /home/copy/ ; fi"

if [ $? == 0 ] ; then
    echo "Backup Complite";

	sshpass -p $PASS /usr/bin/scp {$PATH1,$PATH2,$PATH3,$PATH4} root@$IF$ip$PATHOUT
	if [ $? == 0 ] ; then
	    echo Copying pass files $IF$ip - OK
	   else
	    echo "ERROR COPYING FILES !!! - " $IF$ip;
	fi

    else
    echo "ERROR - BACKUP AND COPY - " $IF$ip;

fi

done


