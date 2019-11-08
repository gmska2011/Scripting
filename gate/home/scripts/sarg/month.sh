#!/bin/bash
 
#Get current date
TODAY=$(date +%d/%m/%Y)
 
#Get one week ago today
YESTERDAY=$(date --date "1 month ago" +%d/%m/%Y)
 
#/usr/local/bin/sqmgrlog -l /usr/local/squid/logs/access.log -o /usr/local/apache/htdocs/reports/monthly -z -d $YESTERDAY-$TODAY
/usr/sbin/sarg -o /var/www/html/squid/monthly -d $YESTERDAY-$TODAY > /dev/null 2>&1
# echo $YESTERDAY-$TODAY
/usr/sbin/squid -k rotate
 
exit 0