#!/bin/bash
 
#Get yesterday date
YESTERDAY=$(date --date "1 day ago" +%d/%m/%Y)
 
/usr/sbin/sarg -o /var/www/html/squid/daily -d $YESTERDAY > /dev/null 2>&1
 
exit 0
