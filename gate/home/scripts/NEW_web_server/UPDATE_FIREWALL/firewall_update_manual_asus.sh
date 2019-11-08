#!/bin/bash

DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

#$DIALOG --title "Ввод данных" --clear \
#        --inputbox "Привет! Перед вами пример ввода даных\nВведите своё имя:" 16 51 2> $tempfile

$DIALOG --title "Ввод данных" --form "Введите IP адрес роутера ASUS" 18 40 10 \
     "IP:" 1 2 "" 1 10 16 16 2> $tempfile

retval=$?
IP=$(cat $tempfile)
case $retval in
  0)
    echo "Вы ввели `cat $tempfile`"
#    echo "Копирую новый файрвол. После этого на роутере необходимо запустить сохранение настроек через скрипт FLASH-UPDATE.SH"
    (sshpass -f sshpass scp -o 'StrictHostKeyChecking no' ./asus/post-firewall admin@$IP:/tmp/local/sbin/) | dialog --title " Копирование "  --pause 'Идет обновление правил FIREWALL на роутере IP-адрес: '$IP 10 50 3
    clear
    dialog --title 'Завершение' --msgbox 'Все готово. На роутере необходимо запустить сохранение настроек через скрипт FLASH-UPDATE.SH. Нажмите OK' 10 50

    ;;
  1)
    echo "Отказ от ввода.";;
  255)
    if test -s $tempfile ; then
      cat $tempfile
    else
      echo "Нажата клавиша ESC."
    fi
    ;;
esac

#dialog --title " Тест диалога прогресса " --gauge "Please wait ...." 10 60 0

clear
#dialog --title 'infoboxes.sh' --msgbox 'Msgbox -- please press OK' 10 50
#dialog --title 'infoboxes.sh' --pause 'Pause' 10 50 3