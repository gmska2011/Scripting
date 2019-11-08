#!/bin/bash

# mysql
#echo "SELECT ip_uprav FROM users" | mysql -uroot -puk.rjyfn2009 ip_pelican

IFS=$'\n';
for row in $(echo "SELECT ip_uprav FROM shop" | mysql -uroot -puk.rjyfn2009 ip_pelican); do 
    # ...
#    echo $row

fping -c1 -t300 $row 2>/dev/null 1>/dev/null
if [ "$?" = 0 ]
then
  echo $row " - OK"
#  echo "update shop set ping='1' where ip_uprav='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican

else
  echo $row " - Unreachetable"
 # echo "update shop set ping='0' where ip_uprav='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican

fi

done

