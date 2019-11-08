#!/bin/bash
 
##
# MySQL backup utility
# @author dmitry.bykadorov@gmail.com
##
 
# current date
DATE=`date +%Y-%M-%d`
 
# y/m/d/h/m separately
YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
HOURS=`date +%H`
MINUTES=`date +%M`
 
# database credentials
DBUSER="root"
DBPASS="uk.rjyfn2009"
DBHOST="localhost"
 
# create list of databases
/usr/bin/mysql -h $DBHOST -u $DBUSER -p$DBPASS -e "show databases;" > /tmp/databases.list
DIR="/opt/mysql_backups/"
# create backup dir (e.g. ../2011/01/01/04-00)
BACKUP_DIR=/opt/mysql_backups/$YEAR/$MONTH/$DAY/$HOURS-$MINUTES
mkdir --parents --verbose $BACKUP_DIR
 
# excludes list (Database is a part of SHOW DATABASES output)
EXCLUDES=( 'Database' 'information_schema' )
NUM_EXCLUDES=${#EXCLUDES[@]}
 
for database in `cat /tmp/databases.list`
do
  skip=0
 
  let count=0
  while [ $count -lt $NUM_EXCLUDES ] ; do
    # check if this name in excludes list
    if [ "$database" = ${EXCLUDES[$count]} ] ; then
      let skip=1
    fi
    let count=$count+1
  done
 
  if [ $skip -eq 0 ] ; then
    echo "++ $database"
    # now we can backup current database
    cd $BACKUP_DIR
    backup_name="$YEAR-$MONTH-$DAY.$HOURS-$MINUTES.$database.backup.sql.gz"
    echo "   backup $backup_name"
#    mysqldump -h "$DBHOST" --databases "$database" -u "$DBUSER" --password="$DBPASS" | gzip -f $backup_name
    /usr/bin/mysqldump -h "$DBHOST" --databases "$database" -u "$DBUSER" --password="$DBPASS" | gzip > $backup_name
  fi
done

find $DIR/ -type f -mtime +10 -o -type d -mtime +10 -exec rm -rf {} \; 
`/bin/rm /tmp/databases.list`
 
echo "done!"



if [ $skip -eq 0 ] ; then
  echo "++ $database"
  # now we can backup current database
  cd $BACKUP_DIR
  backup_name="$YEAR-$MONTH-$DAY.$HOURS-$MINUTES.$database.backup.sql.gz"
  /usr/bin/mysqldump -h "$DBHOST" --databases "$database" -u "$DBUSER" --password="$DBPASS" | gzip > $backup_name
fi

