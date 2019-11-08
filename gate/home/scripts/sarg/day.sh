#!/bin/bash
 
#Get current date
TODAY=$(date +%d/%m/%Y)
 
#Get one week ago today
YESTERDAY=$(date --date "1 day ago" +%d/%m/%Y)
 
#/usr/sbin/sarg -l /usr/local/squid/logs/access.log -o /usr/local/apache/htdocs/reports/daily -z -d $YESTERDAY-$TODAY
/usr/sbin/sarg -o /var/www/html/squid/daily -d $YESTERDAY-$TODAY
# > /dev/null 2>&1
 
  
exit 0
