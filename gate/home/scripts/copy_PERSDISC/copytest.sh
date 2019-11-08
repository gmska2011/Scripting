#!/bin/sh
rm -rf /home/scripts/copy_kass_south/bad

get_ip ()
{
 FILE=$1
#  PARAM=`cat /home/scripts/copy_kass_south/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
#PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3,ip_kassa_4,ip_kassa_5,ip_kassa_6,ip_kassa_7,ip_kassa_8 FROM  users" `
  PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3,ip_kassa_4,ip_kassa_5,ip_kassa_6,ip_kassa_7,ip_kassa_8 FROM 
users where name not in ('П 7/3 кв','П 2 кв','П 2/3 кв','П 3/2 кв','П Ленина')" `
   echo $PARAM
   }

IP_KASSA=`get_ip ip`
#IP_KASSA=$PARAM
PASS='111111'


for ip in $IP_KASSA ; do
 /usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' root@$ip:/home/1/drives/c/south.tml/POSTSTOP.PRG /home/scripts/copy_kass_south/tmp/  > /dev/null 2>&1
 if [ $? == 0 ] ; then
    echo $ip - OK
    /usr/bin/sshpass -p $PASS scp /home/scripts/copy_kass_south/new/POSTSTOP.PRG root@$ip:/home/1/drives/c/south.tml/POSTSTOP.PRG  > /dev/null 2>&1

 else
    /usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' root@$ip:/home/1/.dosemu/drives/c/south.tml/POSTSTOP.PRG /home/scripts/copy_kass_south/tmp/  > /dev/null
     if [ $? == 0 ] ; then
     echo $ip - OK
     /usr/bin/sshpass -p $PASS scp /home/scripts/copy_kass_south/new/POSTSTOP.PRG root@$ip:/home/1/.dosemu/drives/c/south.tml/POSTSTOP.PRG  > /dev/null 2>&1
    
     else 
        /usr/bin/sshpass -p $PASS scp -o 'StrictHostKeyChecking no' root@$ip:/home/1/.dosemu/drives/c/SOUTH.TML/POSTSTOP.PRG /home/scripts/copy_kass_south/tmp/  > /dev/nu
        if [ $? == 0 ] ; then
        echo $ip - OK
        /usr/bin/sshpass -p $PASS scp /home/scripts/copy_kass_south/new/POSTSTOP.PRG root@$ip:/home/1/.dosemu/drives/c/SOUTH.TML/POSTSTOP.PRG  > /dev/null 2>&1
        
        else
	    echo ERROR - BAD PATH - $ip;
	    echo $ip >> /home/scripts/copy_kass_south/bad
	fi
    fi
 fi    
done
