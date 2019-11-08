#!/bin/sh
/bin/find /var/www/html/squid/daily   -type f -mtime +180 -exec rm -rf {} \;
