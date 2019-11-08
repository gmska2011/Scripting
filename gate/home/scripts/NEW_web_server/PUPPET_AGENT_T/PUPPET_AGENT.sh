#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

# ОГРАНИЧЕНИ СКОРОСТИ
speedlimit=1000
MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"
get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	##### Новый Web server #####
#	PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE o.open=1 and w.id_object=o.id and w.type=1"`

	# Для всех
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ip_kas FROM ws_kas where id_mag not IN ('68','71','8')"`

	# Вывод IP касс, где касс в магазине больше чем 1 + Вывод только первого такого IP из каждого магазина:
#	PARAM=`mysql -N -D ip_pelican -u pelican -ppelican123 -e "SELECT b.ip_kas FROM shop as a, ws_kas as b WHERE a.id=b.id_mag and b.id_mag IN (SELECT a.id AS Total FROM shop as a,ws_kas as b WHERE a.id=b.id_mag and a.online=1 and a.id not IN ('68','71','8') group by a.id HAVING COUNT(*) > 1 order by a.name) group by b.id_mag"`

	# Для одной кассы
	PARAM='10.20.250.10 10.20.250.11 10.20.250.12'

        echo $PARAM
    }

IP_KASSA=`get_ip`
#IP_KASSA="10.20.51.12"
PASS='111111'

check_udev ()
    {
	ip=$1
	# Check udev rules
	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "puppet agent -t"
	return $?	
    }


multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        check_udev $ip &
        COP_CODE=$?
	echo "COP_CODE - $COP_CODE"
	# Вывод сообщения на экран и в ЛОГ
	if [ $COP_CODE -eq 0 ]; then
    	    echo $ip - OK! ADDED to DATABASE >> ./LOG.TXT
    	    echo $ip - OK! ADDED to DATABASE

        elif [ $COP_CODE -eq 1 ]; then
    	    echo $ip - NO UDEV '\n'
	    echo $ip - NO UDEV '\n' >> $LOGFILE

        else
	    echo $ip - ERROR. $COP_CODE'\n'
	    echo $ip - ERROR. $COP_CODE'\n' >> $LOGFILE
	fi
	}

for ip in $IP_KASSA ; do

echo TRYING $ip :
multi_copy $ip &
sleep 1
#exit
done
