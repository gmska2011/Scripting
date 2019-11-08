#!/bin/bash

DIR="/var/spool/asterisk/monitor/"

#find $DIR -type f -exec mv {} \;
#find $DIR -name "*.mp3" | xargs
# mv {} /destdir/



#for f in `find $DIR -type f -name "*.mp3"`; do 
#    print $f 
#    mv $f $DIR/OLD/; 
#done

#for f in `du -ah -d 1 /var/spool/asterisk/monitor/ | head -n 1000|awk '{print $2}'`; do
for i in {0..300}; do
    for f in `find $DIR -maxdepth 1 -type f -name "*.mp3"| head -n 1000`; do
        name=`echo "$f"|awk 'BEGIN{FS="/"}{print $NF}'`
        dir=`echo $name|awk -F "-" '{print $2"-"$3"-"$4}'`
    #    echo "FILE - "$name
    #    echo "DIR -  "$dir
        mkdir -p $DIR/$dir/ 
        mv $f $DIR/$dir/
    done
done