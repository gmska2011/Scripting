#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

DIR="/mnt/tmp_backup_dir"

mkdir $DIR
 
sleep 2  



# ВЕРСИЯ ОБНОВЛЕНИЯ ПО НА КАССАХ
version=12

# ОГРАНИЧЕНИ СКОРОСТИ
#speedlimit=1500

get_ip ()
    {
	# Для всех
	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT a.ip_ws FROM ws as a, shop as b WHERE a.id_mag=b.id and a.jacarta=1 and b.online = 1 and a.version<$version"`

	# Для одного
#	PARAM='192.168.43.43'

        echo $PARAM

    }

IP_KASSA=`get_ip`

#ПУТЬ К ФАЙЛУ
#FILENAME='silentsetup-2_0_3.exe'
#FILENAME='JaCartaUnifiedClient_2.9.0.1531_win-x86_ru-Ru.msi'
#FILENAME='kontur.toolbox2.exe'
FILENAME='usb_network_gate.exe'


scp_copy ()
    {
	ip=$1
	
	# Обновляем версию SOUTH
#	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_1 root@$ip:$copypath/versions/  # >>$LOGFILE 2>&1

/bin/mount -t cifs //$ip/PRC_WORK $DIR  -o username=muxa,password=muxa && /usr/bin/rsync -rlcpvz ./$FILENAME $DIR && /bin/umount $DIR 


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
        echo "update ws set version='$version' where ip_ws='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;

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

