#!/bin/bash
 
#Get current date
TODAY=$(date +%d/%m/%Y)
 
#Get one week ago today
YESTERDAY=$(date --date "1 week ago" +%d/%m/%Y)
 
#/usr/local/bin/sqmgrlog -l /usr/local/squid/logs/access.log -o /usr/local/apache/htdocs/reports/weekly -z -d $YESTERDAY-$TODAY
/usr/sbin/sarg -o /var/www/html/squid/weekly -d $YESTERDAY-$TODAY > /dev/null 2>&1
 
exit 0