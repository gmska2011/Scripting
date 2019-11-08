#!/bin/sh

if [ -z $1 ]
then
echo "Please, add a service name. For example: service-check.sh pure-ftpd"
exit
fi
proc=`pgrep $1`

if [ $? -eq 0 ]
then
  echo "Запущен"
else
  echo "Не запущен"
  /etc/init.d/$1 restart
  echo "Service $1 is restarted AUTOMATICALY by service-check.sh" | mail -s "Service $1 is DOWN and RESTARTED" muxa@neo63.ru
fi	