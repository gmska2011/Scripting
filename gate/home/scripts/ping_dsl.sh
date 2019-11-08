#!/bin/bash

# mysql
#echo "SELECT ip_uprav FROM users" | mysql -uroot -puk.rjyfn2009 ip_pelican

IFS=$'\n';
for row in $(echo "SELECT ext_ip FROM internet where ext_ip>0" | mysql -uroot -puk.rjyfn2009 ip_pelican); do 
#echo $row
test_ping=0
NUM=1000
#fping -c1 -t300 -q -a $row | awk ' {print $1} '
test_ping=`fping -c1 -t300 1 $row  2>&1| tail -n 1 | awk '{print $8}' | cut -d/ -f2`

#echo $row - $test_ping
###2>/dev/null 1>/dev/null
#if [ "$?" = 0 ]
#then
#  echo $row " - OK"
#  echo "update shop set ping='1' where ip_uprav='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican

#else
#  echo $row " - Unreachetable"
 # echo "update shop set ping='0' where ip_uprav='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican

#fi


#let "test_ping=(test_ping*100)/100"

#echo "scale=1;4.2/2" |bc

# X=123
# echo $test_ping 
# (( test_ping++ ))

# echo $test_ping | bc -l

if [ ! -z "$test_ping" ]
    then
    NUM=$(echo "scale=0;$test_ping/1" | bc)
fi
#echo "\$? is $?"
#echo "NUM is $NUM"
if [ ! -z "$NUM" ]
    then
	if [ "$NUM" -lt "10" ] 
		then
			echo $row " PING=$NUM - ETHERNET"

		  echo "update internet set type_conn='ETHERNET' where ext_ip='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican
    
		else 
		    if	[ "$NUM" != "1000" ]
			then		
	    			echo $row " PING=$NUM - ADSL"
		    fi
		    # echo "update shop set ping='0' where ip_uprav='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican
		  echo "update internet set type_conn='ADSL' where ext_ip='$row'" | mysql -uroot -puk.rjyfn2009 ip_pelican

	fi
fi

done

