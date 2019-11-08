#!/bin/sh

DIR="/var/vmail/neo63.ru/"

DATE=`date "+%Y-%m-%d"`

DATE_AFTER="2010-01-01"
DATE_BEFORE="2017-01-01"

#find $DIR/zhukova/ -type f -newermt 2010-01-01 ! -newermt 2017-01-01  -exec cp {} /home/mailbackup \;
cd $DIR
tar -jcf /home/mailbackup/mail_$DATE_AFTER-$DATE_BEFORE.tar.bz2 $DIR
#find $DIR -type f -newermt $DATE_AFTER ! -newermt $DATE_BEFORE | xargs tar -zcf mail_$DATE_AFTER-$DATE_BEFORE.tar.gz
#find $DIR -type f -newermt $DATE_AFTER ! -newermt $DATE_BEFORE -exec cp -vuni "{}" /home/mailbackup \; 
