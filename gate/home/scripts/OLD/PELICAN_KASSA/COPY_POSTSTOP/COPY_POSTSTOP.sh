#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	# Для Сызрани
#        PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE ws_kas.id_mag=shop.id and shop.gorod IN ('SZN')"`

	# Для Тольятти + Федоровка
        PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE ws_kas.id_mag=shop.id and (shop.gorod IN ('TLT') or shop.id='94')"`

	# Для всех
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ip_kas FROM ws_kas "`

	# Для одной кассы
#	PARAM='192.168.14.6 192.168.115.11'
#	PARAM='192.168.80.10 192.168.23.12 192.168.80.12 192.168.223.10 192.168.230.10 192.168.216.10 192.168.81.12 192.168.109.11 192.168.109.10 192.168.122.10 192.168.112.10 192.168.84.12 192.168.80.11 192.168.30.11 192.168.30.10'
        echo $PARAM

    }

IP_KASSA=`get_ip`
PASS='111111'

#ПУТЬ К ФАЙЛУ
FILENAME='POSTSTOP.PRG'

scp_copy ()
    {
	ip=$1
	copypath=$2

	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/ -iname '$FILENAME' -exec rm -rf {} \;"  >> /dev/null 2>&1
	/usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME root@$ip:$copypath/  # >>$LOGFILE 2>&1
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
