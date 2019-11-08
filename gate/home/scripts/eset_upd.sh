#!/bin/sh

#wget -m --ftp-user=muxa --ftp-password=vb[fxtvgbjy2007 ftp://192.168.5.4/eset_upd/ -r --no-glob  -np  -nH -nd -L -P  /home/SOFT/nodupdate/eset_upd/
wget -m http://totel.kusto.com.ru/eset_upd/ -r --no-glob  -np  -nH -nd -L -P  /var/www/html/eset_upd/
chmod -R 777 /var/www/html/eset_upd/

