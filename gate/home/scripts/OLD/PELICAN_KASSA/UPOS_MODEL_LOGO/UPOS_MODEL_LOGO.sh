#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

# ОГРАНИЧЕНИ СКОРОСТИ
speedlimit=1000

get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	PARAM=`mysql -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and ws_kas.id_mag=shop.id"`

	# Для всех
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ip_kas FROM ws_kas where id_mag not IN ('68','71','8')"`

	# Вывод IP касс, где касс в магазине больше чем 1 + Вывод только первого такого IP из каждого магазина:
#	PARAM=`mysql -N -D ip_pelican -u pelican -ppelican123 -e "SELECT b.ip_kas FROM shop as a, ws_kas as b WHERE a.id=b.id_mag and b.id_mag IN (SELECT a.id AS Total FROM shop as a,ws_kas as b WHERE a.id=b.id_mag and a.online=1 and a.id not IN ('68','71','8') group by a.id HAVING COUNT(*) > 1 order by a.name) group by b.id_mag"`

	# Для одной кассы
#	PARAM='192.168.133.10'

        echo $PARAM

    }

#IP_KASSA=`get_ip`
#IP_KASSA="192.168.123.11"
IP_KASSA="10.20.51.12"
PASS='111111'


check_udev ()
    {
	ip=$1
	# Check udev rules
	MODEL=""
	MODEL=$(sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat \`find /home/1/drives/c/south.tml/upos/ | grep inf.txt\` |iconv -f koi8-r -t utf8|grep \"Модель:\" -m 1"|awk -F: {'print $2'} |sed 's/^[ \t]*//')
        COP_CODE=$?
	
	echo "COP_CODE - $COP_CODE"
	echo "$MODEL"
	
        # �.�.вод �.ооб�.ени�. на �.к�.ан и в �.�.�.
        if [ $COP_CODE -eq 0 ]; then
            
            echo "update ws_kas set pinpad_model='$MODEL' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;
	    case $MODEL in
	        *805*)
			echo "It is 805"
			/usr/bin/sshpass -p 111111 scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./UPOS/805/LOGO.BMP root@$ip:/home/1/drives/c/south.tml/upos/LOGO.BMP
		        ;;
	        *820*|*320*)
			echo "It is 820 or 320"
			/usr/bin/sshpass -p 111111 scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./UPOS/820/LOGO.BMP root@$ip:/home/1/drives/c/south.tml/upos/LOGO.BMP
		        ;;
	        *PAX*)
			echo "It is PAX"
			/usr/bin/sshpass -p 111111 scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./UPOS/PAX/LOGO.BMP root@$ip:/home/1/drives/c/south.tml/upos/LOGO.BMP
		        ;;
	        *)
		    echo "no" ;;
	        # You should have a default one too.
	    esac

#	    echo $ip - OK! ADDED to DATABASE >> ./LOG.TXT
            echo $ip - OK! ADDED to DATABASE
	    

        else
            echo $ip - ERROR!!!!!!!! '\n'
            echo $ip - ERROR!!!!!!!! '\n' >> $LOGFILE
        fi

    }


multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        check_udev $ip
        COP_CODE=$?

	# Вывод сообщения на экран и в ЛОГ
	if [ $COP_CODE -eq 0 ]; then
        echo $ip - OK! ADDED to DATABASE >> ./LOG.TXT
#        echo $ip - OK! ADDED to DATABASE

        #Mysql update puppet info
#        echo "update ws_kas set udev='1' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;

        else
	echo $ip - ERROR!!!!!!!! '\n'
	echo $ip - ERROR!!!!!!!! '\n' >> $LOGFILE
	fi
	}

for ip in $IP_KASSA ; do

echo TRYING $ip :
multi_copy $ip &
sleep 1
#exit
done
