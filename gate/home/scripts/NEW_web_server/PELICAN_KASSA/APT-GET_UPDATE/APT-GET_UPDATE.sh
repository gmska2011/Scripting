#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

MYSQL="-h 10.0.0.242 -N -D pelican -u pelican -ppelican123"

get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	# Для ПЕЛИКАФЕ
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT a.ip_kas FROM ws_kas as a, shop as b where b.pcafe = 1 and b.online = 1 and a.id_mag=b.id"`
#	PARAM=`mysql  -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE ws_kas.id_mag=shop.id and shop.pcafe='1' "` #Пеликафе


	PARAM=`mysql $MYSQL -e "SELECT w.ip FROM ws as w,object as o WHERE o.open=1 and w.id_object=o.id and w.type=1"`

	# Для одной кассы
#	PARAM='192.168.225.10'

        echo $PARAM

    }

IP_KASSA=`get_ip`
PASS='111111'

#ПУТЬ К ФАЙЛУ
#FILENAME='POSCOUNT.PRG'

ssh_script ()
    {
	ip=$1
	copypath=$2

	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "apt-get -y update"  >> /dev/null 2>&1
#	/usr/bin/sshpass -p $PASS scp -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME root@$ip:$copypath/  # >>$LOGFILE 2>&1
    }


for ip in $IP_KASSA ; do

echo TRYING $ip :
#ssh_script $ip 
ssh_script $ip &

#exit
done
