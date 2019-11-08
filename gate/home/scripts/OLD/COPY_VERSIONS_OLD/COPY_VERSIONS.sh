#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	# Для всех
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ip_kas FROM ws_kas where id_mag not IN ('68','71','8')"`

	# Вывод IP касс, где касс в магазине больше чем 1 + Вывод только первого такого IP из каждого магазина:
#	PARAM=`mysql -N -D ip_pelican -u pelican -ppelican123 -e "SELECT b.ip_kas FROM shop as a, ws_kas as b WHERE a.id=b.id_mag and b.id_mag IN (SELECT a.id AS Total FROM shop as a,ws_kas as b WHERE a.id=b.id_mag and a.online=1 and a.id not IN ('68','71','8') group by a.id HAVING COUNT(*) > 1 order by a.name) group by b.id_mag"`

	# Для одной кассы
	PARAM='192.168.216.10
192.168.223.10
192.168.112.10
192.168.230.10
192.168.116.10
10.20.34.11
192.168.84.12
192.168.113.12
192.168.113.11
192.168.30.10
10.20.32.11
10.20.32.10
10.20.29.10
10.20.33.11
10.20.33.10
192.168.218.10
192.168.30.11
10.20.29.11
192.168.113.10
192.168.221.10
192.168.114.11
192.168.41.10
192.168.249.10
192.168.246.10
192.168.59.11
192.168.100.11
192.168.31.10
'



        echo $PARAM

    }

IP_KASSA=`get_ip`
PASS='111111'

#ПУТЬ К ФАЙЛУ
FILENAME_1='south.exe'
FILENAME_2='southprf.exe'


scp_copy ()
    {
	ip=$1
	copypath=$2

	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/ -iname '$FILENAME_1' -exec rm -rf {} \;"  >> /dev/null 2>&1
	/usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_1 root@$ip:$copypath/  # >>$LOGFILE 2>&1
        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/ -iname '$FILENAME_2' -exec rm -rf {} \;"  >> /dev/null 2>&1
	/usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_2 root@$ip:$copypath/  # >>$LOGFILE 2>&1
    
    }



multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        scp_copy $ip "/home/1/drives/c/versions/"
        COP_CODE=$?

        # 2 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/home/1/.dosemu/drives/c/versions/"
        COP_CODE=$?
	fi
	# 3 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/var/lib/dosemu/drives/c/versions/"
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
