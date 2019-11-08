#!/bin/bash
 
#SPAMUSERDIR='/home/artur/Maildir/.Spam/cur/*'
SPAMLEARNDIR='/tmp/SPAM/'
 
/bin/mkdir $SPAMLEARNDIR

##find /home/ -iname ".Spam" -type f -exec mv {}/cur/  $SPAMLEARNDIR \;
#/bin/mv $SPAMUSERDIR $SPAMLEARNDIR

 #!/bin/bash

MAILDIRS=$(find /var/vmail/neo63.ru/*/.Spam/cur/ -maxdepth 0 -type d)
for basedir in $MAILDIRS; do
#  for dir in .Trash .Junk .Spam .Low\ Priority; do
#    for dir2 in cur new; do
      [ -e "$basedir" ] && (
        echo "Processing $basedir..."
#        find "$basedir/$dir/$dir2/" -type f -mtime +30 -delete
#        find "$basedir/$dir/$dir2/" -type f -mtime +30 -delete
	mv $basedir* $SPAMLEARNDIR
      )
#    done
# done
done
 


/bin/chown -R amavis:amavis $SPAMLEARNDIR
/bin/chmod -R 777 $SPAMLEARNDIR
 
/bin/su - amavis -c 'sa-learn --dump magic'
/bin/su - amavis -c "sa-learn --no-sync --spam /tmp/SPAM"
/bin/su - amavis -c 'sa-learn --dump magic'
 
/bin/rm -rf /tmp/SPAM
 
service spamassassin reload