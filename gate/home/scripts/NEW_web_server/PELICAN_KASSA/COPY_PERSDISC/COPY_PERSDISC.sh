#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"
get_ip ()
    {
        # Новый Web server
        PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE o.open=1 and w.id_object=o.id and w.type=1 and o.id not in ('42','81','86')"`
        echo $PARAM
    }


IP_KASSA=`get_ip`
PASS='111111'
#IP_KASSA='192.168.10.11 192.168.10.12'
echo $IP_KASSA

#exit
#ПУТЬ К ФАЙЛУ
FILENAME='PERSDISC.PRG'

scp_copy ()
    {
	ip=$1
	copypath=$2

	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/ -iname '$FILENAME' -exec rm -rf {} \;"  >> /dev/null 2>&1
	/usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME root@$ip:$copypath/   >>$LOGFILE 2>&1
    }


multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        scp_copy $ip "/home/1/drives/c/south"
        COP_CODE=$?

        # 2 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/home/1/.dosemu/drives/c/south" 
        COP_CODE=$?
	fi
	# 3 попытка
	if [ $COP_CODE -ne 0 ]; then
        scp_copy $ip "/home/1/drives/c/south.tml"
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
