#!/bin/sh
rm -rf /home/scripts/copy_kass_south/bad

get_ip ()
{
 FILE=$1
#  PARAM=`cat /home/scripts/copy_kass_south/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
#PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3,ip_kassa_4,ip_kassa_5,ip_kassa_6,ip_kassa_7,ip_kassa_8 FROM  users" `
  PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3 FROM 
users where name = 'П Аэродромная 75'"`
   echo $PARAM
   }
#  PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3,ip_kassa_4,ip_kassa_5,ip_kassa_6,ip_kassa_7,ip_kassa_8 FROM
#users where name = 'П 15/3 кв'" `

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
PASS='111111'
echo $IP_KASSA

for ip in $IP_KASSA ; do
#/usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' -r  root@$ip:/home/1/drives/c/versions/ /home/scripts/copy_kass_south/tmp/ 
/usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip rm -r /home/1/drives/c/versions/
/usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' -r /home/scripts/copy_kass_south/new/versions/ root@$ip:/home/1/drives/c/

# if [ $? == 0 ] ; then
#    echo $ip - OK
#    sshpass -p $PASS scp -r /home/scripts/copy_kass_south/new/versions/ root@$ip:/home/1/drives/c/  > /dev/null 2>&1

# else
#    sshpass -p $PASS scp -o 'StrictHostKeyChecking no' -r   root@$ip:/home/1/.dosemu/drives/c/versions/ /home/scripts/copy_kass_south/tmp/  > /dev/null
#     if [ $? == 0 ] ; then
#     echo $ip - OK
#     sshpass -p $PASS scp -r /home/scripts/copy_kass_south/new/versions/ root@$ip:/home/1/.dosemu/drives/c/  > /dev/null 2>&1
    
#	    echo ERROR - BAD PATH - $ip;
#	    echo $ip >> /home/scripts/copy_kass_south/bad
#	fi
#    fi
 
  
done
