#!/bin/bash

DATE=`date "+%Y-%m-%d"`

MYSQL="-h 127.0.0.1 -N -D asteriskcdr -u astuser -pastpass"

NUM="4" #DAYS to COPY
DIR="/var/www/html/acdr/records/"

get_files ()
    {
        PARAM=`mysql $MYSQL -e "SELECT filename FROM cdr WHERE dst='8482580101' and DATE_FORMAT(calldate, '%Y-%m-%d') <= CURDATE() and DATE_FORMAT(calldate, '%Y-%m-%d') > (CURDATE() - INTERVAL $NUM DAY)"`
        echo $PARAM
    }

CALLS=`get_files`

for call in $CALLS ; do
    ls $DIR/$call;    
done
