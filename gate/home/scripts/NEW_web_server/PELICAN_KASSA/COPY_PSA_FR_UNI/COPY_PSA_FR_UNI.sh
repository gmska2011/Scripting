#!/bin/sh
DATE=`date +%Y-%m-%d`
LOGFILE=bad_ip.log
echo $DATE "Start Log"> $LOGFILE

# ВЕРСИЯ ОБНОВЛЕНИЯ ПО НА КАССАХ
version=13

# ОГРАНИЧЕНИ СКОРОСТИ
speedlimit=1000

get_ip ()
    {
	# Для одного магазина
#	PARAM=`mysql  -N -D ip_mindal -u mindal -pmindal123 -e "SELECT ip_kas FROM ws_kas where id_mag = 10"`

	# Для всех
	PARAM=`mysql -N -D ip_pelican -u pelican -ppelican123 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1  and ws_kas.id_mag=shop.id and version<$version"`

	# Вывод IP касс, где касс в магазине больше чем 1 + Вывод только первого такого IP из каждого магазина:
#	PARAM=`mysql -N -D ip_pelican -u pelican -ppelican123 -e "SELECT b.ip_kas FROM shop as a, ws_kas as b WHERE a.id=b.id_mag and b.id_mag IN (SELECT a.id AS Total FROM shop as a,ws_kas as b WHERE a.id=b.id_mag and a.online=1 and a.id not IN ('68','71','8') group by a.id HAVING COUNT(*) > 1 order by a.name) group by b.id_mag"`

	# Для одной кассы
#	PARAM='192.168.2.10'

        echo $PARAM

    }

IP_KASSA=`get_ip`
PASS='111111'

#ПУТЬ К ФАЙЛУ
FILENAME_0='south.exe'
FILENAME_1='psa_fr_uni_copy.exe'
FILENAME_2='fr_start.sh'
FILENAME_3='watch_proc.exe'


scp_copy ()
    {
	ip=$1
	copypath=$2
	
	# Обновляем версию SOUTH
###	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_0 root@$ip:$copypath/versions/  # >>$LOGFILE 2>&1
	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_3 root@$ip:$copypath/south.tml/  # >>$LOGFILE 2>&1

#	/usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/versions/ -iname '$FILENAME_1' -exec rm -rf {} \;"  >> /dev/null 2>&1
##        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "find $copypath/versions/ -iname '$FILENAME_2' -exec rm -rf {} \;"  >> /dev/null 2>&1
##	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_2 root@$ip:$copypath/versions/  # >>$LOGFILE 2>&1

	# Перезаписываем .bashrc (CURL)
#        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat /home/1/.bashrc|grep curl_nix.exe ||sed -i 's/.\/wait_nix.exe \&/.\/curl_nix.exe \&\n.\/wait_nix.exe \&/g' /home/1/.bashrc"  >> /dev/null 2>&1
#        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat /home/1/.bashrc|grep 'killall curl_nix.exe' ||sed -i 's/killall wait_nix.exe/killall curl_nix.exe\nkillall wait_nix.exe/g' /home/1/.bashrc"  >> /dev/null 2>&1


	# Перезаписываем .bashrc (PSA_FR_UNI_COPY)
###	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_1 root@$ip:$copypath/south.tml/  # >>$LOGFILE 2>&1
#	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no ./$FILENAME_2 root@$ip:/home/scripts/kassa/fr/  # >>$LOGFILE 2>&1
	#Для старых касс
        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat /home/1/.bashrc|grep 'watch_proc.exe psa_fr_uni.exe' && sed -i 's/.\/watch_proc.exe psa_fr_uni.exe \".\/psa_fr_uni.exe \&\" \&/.\/psa_fr_uni.exe \&\n.\/watch_proc.exe psa_fr_uni.exe \".\/psa_fr_uni.exe \&\" \&/g' /home/1/.bashrc"  >> /dev/null 2>&1
###        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat /home/1/.bashrc|grep 'watch_proc.exe psa_fr_uni.exe'||sed -i 's/.\/psa_fr_uni.exe \&/.\/watch_proc.exe psa_fr_uni.exe \".\/psa_fr_uni.exe \&\" \&/g' /home/1/.bashrc"  >> /dev/null 2>&1

#        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat /home/scripts/kassa/fr/fr_start.sh|grep './psa_fr_uni_copy.exe'||sed -i 's/.\/psa_fr_uni.exe \&/cp .\/psa_fr_uni_copy.exe .\/psa_fr_uni.exe\n.\/psa_fr_uni.exe \&/g' /home/scripts/kassa/fr/fr_start.sh"  >> /dev/null 2>&1
#        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "cat /home/1/.bashrc|grep './psa_fr_uni.exe &'||sed -i 's/.\/psa_fr_uni.exe \&/cp .\/psa_fr_uni_copy.exe .\/psa_fr_uni.exe\n.\/psa_fr_uni.exe \&/g' /home/1/.bashrc"  >> /dev/null 2>&1


#        /usr/bin/sshpass -p $PASS ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no root@$ip "if [ -a /home/scripts/1.sh ]; then cat /home/scripts/kassa/fr/fr_start.sh|grep './psa_fr_uni_copy.exe'||sed -i 's/.\/psa_fr_uni.exe \&/cp .\/psa_fr_uni_copy.exe .\/psa_fr_uni.exe\n.\/psa_fr_uni.exe \&/g' /home/scripts/kassa/fr/fr_start.sh;  else cat /home/1/.bashrc|grep './psa_fr_uni_copy.exe'||sed -i 's/.\/psa_fr_uni.exe \&/cp .\/psa_fr_uni_copy.exe .\/psa_fr_uni.exe\n.\/psa_fr_uni.exe \&/g' /home/1/.bashrc;  fi"  >> /dev/null 2>&1
#if [ -a /home/scripts/1.sh ]; then  echo '1';  else echo '0';  fi

	# Копируем CURL и CURL_NIX в папку south.tml
#	/usr/bin/sshpass -p $PASS scp -l $speedlimit -o ConnectTimeout=2 -o StrictHostKeyChecking=no -r ./south.tml/* root@$ip:$copypath/south.tml/  # >>$LOGFILE 2>&1

    }



multi_copy ()

    {
	ip=$1
        # Пробуем скопировать файл
        scp_copy $ip "/home/1/drives/c/"
        COP_CODE=$?

	# Вывод сообщения на экран и в ЛОГ
	if [ $COP_CODE -eq 0 ]; then
        echo $ip - OK! VERSION $version INSTALLED and ADDED to DATABASE >> ./LOG.TXT
        echo $ip - OK! VERSION $version INSTALLED and ADDED to DATABASE

        #Mysql update puppet info
       echo "update ws_kas set version='$version' where ip_kas='$ip';" | mysql -uroot -puk.rjyfn2009 ip_pelican;


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
