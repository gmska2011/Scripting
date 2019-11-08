#!/bin/sh
get_ip ()
{
 FILE=$1
 PARAM=`cat ./$FILE  | sed -e s'/#.*//' | sed -e s'/\ //g' | egrep -v "^#" | egrep -v "^$"`
 echo $PARAM
}

USERS=`get_ip users`
#pass="3000"
for user in $USERS ; do
#useradd -d /home/$user -s /bin/bash  $user
#echo "$user:12345" | chpasswd
echo "Пользователь - $user"
userdir="/home/$user/Maildir"
echo "	Папка для переноса - $userdir"
uservmaildir="/var/vmail/neo63.ru/$user"
echo "	Папка VMAIL - $uservmaildir\n"
# | chpasswd


# ПЕРЕНОС ПАПКИ
mv $userdir $uservmaildir
#echo $uservmaildir $userdir
# ССЫЛКА ДЛЯ СОВМЕСТИМОСТИ 
ln -s $uservmaildir $userdir
# ПРАВА ДОСТУПА
chown -R vmail.mail $uservmaildir

done


#for i in "ivanov Иванов Иван dy3mrMiS"
#"petrov Петров Иван dy4mrMiS"
#"sidorov Сидоров Иван dy5mrMiS"; do

#set -- $i

#useradd -d /home/$1 -s /bin/bash  $1
#echo "$1:12345" | chpasswd
