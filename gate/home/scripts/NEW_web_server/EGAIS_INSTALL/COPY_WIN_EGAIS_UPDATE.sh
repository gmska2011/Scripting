#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip2.log
echo $DATE "Start Log"> $LOGFILE


mkdir /mnt/tmp_backup2
sleep 2  



# ВЕРСИЯ ОБНОВЛЕНИЯ ПО НА КАССАХ
version=1

# ОГРАНИЧЕНИ СКОРОСТИ
#speedlimit=1500

get_ip ()
    {
	# Для всех
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT a.ip_ws FROM ws as a, shop as b WHERE a.id_mag=b.id and a.jacarta=1 and b.online = 1 "`

	# Для одного
	PARAM='192.168.18.18'

        echo $PARAM

    }

IP_KASSA=`get_ip`

#ПУТЬ К ФАЙЛУ
FILENAME='UTM_Update.exe'


scp_copy ()
    {
	ip=$1
	
	# Обновляем версию SOUTH
#	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_1 root@$ip:$copypath/versions/  # >>$LOGFILE 2>&1

/bin/mount -t cifs //$ip/PRC_WORK /mnt/tmp_backup2  -o username=muxa,password=muxa && /usr/bin/rsync -rlcpvz ./$FILENAME /mnt/tmp_backup2 && /bin/umount /mnt/tmp_backup2 


    }



multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        scp_copy $ip
        COP_CODE=$?

	# Вывод сообщения на экран и в ЛОГ
	if [ $COP_CODE -eq 0 ]; then
        echo $ip - OK! VERSION $version INSTALLED and ADDED to DATABASE >> ./LOG.TXT
        echo $ip - OK! VERSION $version INSTALLED and ADDED to DATABASE

        #Mysql update puppet info
#        echo "update ws set version='$version' where ip_ws='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;

        else
	echo $ip - ERROR!!!!!!!! '\n'
	echo $ip - ERROR!!!!!!!! '\n' >> $LOGFILE
	fi
	}

for ip in $IP_KASSA ; do

echo TRYING $ip :
multi_copy $ip 

#exit
done

