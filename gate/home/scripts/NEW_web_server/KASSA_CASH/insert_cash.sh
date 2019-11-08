#!/bin/bash

cd /home/scripts/NEW_web_server/KASSA_CASH/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT
MYSQL="-h 127.0.0.1 -N -D test -u root -puk.rjyfn2009"










for (( i = 0; i < 10000000; i++ )) ; do
    echo "insert into test (\`sum\`, \`date\`) VALUES ('$i','$DATE');" | mysql $MYSQL;
done


