#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	# Для всех
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ip_kas FROM ws_kas "`
	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE ws_kas.id_mag=shop.id and shop.pcafe='1' "` #Пеликафе

	# Для одной кассы
#	PARAM='192.168.225.10'

        echo $PARAM

    }

IP_KASSA=`get_ip`
PASS='111111'

#ПУТЬ К ФАЙЛУ
FILENAME_1='POSCOUNT.PRG'
FILENAME_2='PERSDISC.PRG'

scp_copy ()
    {
	ip=$1
	copypath=$2

	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/ -iname '$FILENAME_1' -exec rm -rf {} \;"  >> /dev/null 2>&1
	/usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_1 root@$ip:$copypath/  # >>$LOGFILE 2>&1
    }


multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        scp_copy $ip "/home/1/drives/c/south.tml/"
        COP_CODE=$?

        # 2 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/home/1/drives/c/south"
        COP_CODE=$?
	fi
        # 2 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/home/1/.dosemu/drives/c/south"
        COP_CODE=$?
	fi
	# 3 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/var/lib/dosemu/drives/c"
        COP_CODE=$?
	fi

        # 4 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/home/1/.dosemu/drives/c/south.kas"
        COP_CODE=$?
	fi

	# Вывод сообщения на экран и в ЛОГ
	if [ $COP_CODE -eq 0 ]; then
        echo $ip - OK
        else
	echo $ip - ERROR!!!!!!!! '\n'
	echo $ip - ERROR!!!!!!!! '\n' >> $LOGFILE
	fi
	}

for ip in $IP_KASSA ; do

echo TRYING $ip :
multi_copy $ip &

#exit
done
