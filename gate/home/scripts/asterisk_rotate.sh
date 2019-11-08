#!/bin/bash
# путь к хранилищу записей
RECORDINGS=/var/spool/asterisk/monitor

# Количество дней для сохранения
RECORDINGEXPIRY=100

# Количество дней хранения логов очистки
LOGEXPIRY=100

# Текущая дата
DATE=`date "+%Y-%m-%d_%H:%M:%S"`

# Удаляются записи старше чем $EXPIRY дней
find $RECORDINGS -mtime +$RECORDINGEXPIRY -exec rm -rfv {} \; > /var/spool/asterisk/del_logs/removal-$DATE.log


# Удаляются логи старше чем $LOGEXPRY дней
find /var/spool/asterisk/del_logs -mtime +$LOGEXPIRY -exec rm -f {} \;

#Mysql rotate CDR
echo "delete FROM cdr WHERE calldate < (NOW() - INTERVAL 100 DAY);" | mysql -uroot -puk.rjyfn2009 asteriskcdr;

