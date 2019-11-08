#!/bin/sh

id_mag="131"
id_mag_new="11$id_mag"

get_tables ()
    {
        FILE=$1
        PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SHOW TABLES" `
        echo $PARAM
    }

select_id ()
    {
        table=$1
        id_mag=$2
        id_mag_new=$3
        PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "UPDATE $table SET id_mag=$id_mag_new where id_mag=$id_mag" `
        echo $PARAM
    }

TABLES=`get_tables`

for table in $TABLES ; do

    echo $table

    if [ $table != "shop" ]
    then
        PARAM=`select_id $table $id_mag $id_mag_new`
        #    echo $PARAM
        #Mysql update puppet info
        #echo "update ws_kas set 3D_scanner='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    fi

done

NEW_COMM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "UPDATE shop SET comm='comm$id_mag_new' where id=$id_mag" `
NEW_COMM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "UPDATE shop SET id=$id_mag_new where id=$id_mag" `

#INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=1" `
#NOT_INSTALLED=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT COUNT(ws_kas.ip_kas) FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id and 3D_scanner=0" `
#echo "На $(date +%d.%m.%Y) установлено $INSTALLED сканеров"
#echo "Осталось установить $NOT_INSTALLED сканеров. Удачи!"
