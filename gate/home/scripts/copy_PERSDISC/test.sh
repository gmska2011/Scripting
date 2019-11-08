#!/bin/sh

#get_ip ()
#{
# FILE=$1
#  PARAM=`cat /home/scripts/copy_kass_south/$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
#   echo $PARAM
#   }

get_ip ()
{
 FILE=$1
  PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3,ip_kassa_4,ip_kassa_5,ip_kassa_6,ip_kassa_7,ip_kassa_8 FROM  
users where name not in ('П 7/3 кв','П 2 кв','П 2/3 кв','П 3/2 кв','П Ленина')" ` 
#  PARAM=`mysql  -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ip_kassa_1,ip_kassa_2,ip_kassa_3,ip_kassa_4,ip_kassa_5,ip_kassa_6,ip_kassa_7,ip_kassa_8 FROM  users" ` 


   echo $PARAM
   }


IP_KASSA=`get_ip ip`
PASS='111111'

echo $IP_KASSA 