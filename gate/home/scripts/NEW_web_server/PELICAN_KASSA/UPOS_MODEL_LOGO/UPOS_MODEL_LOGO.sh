#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

# ОГРАНИЧЕНИ СКОРОСТИ
speedlimit=1000
MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"

get_ip ()
    {
        PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE o.open=1 and w.id_object=o.id and w.type=1"`
        echo $PARAM
    }

get_id_ws ()
    {
        VAR=$1
        PARAM=`mysql $MYSQL -e "SELECT id FROM ws WHERE ip='$VAR'" `
        echo $PARAM
    }


IP_KASSA=`get_ip`
#IP_KASSA="192.168.123.11"
#IP_KASSA="10.20.51.12"
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
	ID_WS=`get_id_ws "$ip"`

        # �.�.вод �.ооб�.ени�. на �.к�.ан и в �.�.�.
        if [ $COP_CODE -eq 0 ]; then
            
#            echo "update ws_kas set pinpad_model='$MODEL' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;
#            echo "update ws_kas set pinpad_model='$MODEL' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;
	    echo "insert into pinpad (id_ws, pinpad_model) values ('$ID_WS','$MODEL') ON DUPLICATE KEY UPDATE pinpad_model='$MODEL' ;"|mysql $MYSQL;
	    case $MODEL in
	        *805*)
			echo "It is 805"
#			/usr/bin/sshpass -p 111111 scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./UPOS/805/LOGO.BMP root@$ip:/home/1/drives/c/south.tml/upos/LOGO.BMP
		        ;;
	        *820*|*320*)
			echo "It is 820 or 320"
#			/usr/bin/sshpass -p 111111 scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./UPOS/820/LOGO.BMP root@$ip:/home/1/drives/c/south.tml/upos/LOGO.BMP
		        ;;
	        *PAX*)
			echo "It is PAX"
#			/usr/bin/sshpass -p 111111 scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./UPOS/PAX/LOGO.BMP root@$ip:/home/1/drives/c/south.tml/upos/LOGO.BMP
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
