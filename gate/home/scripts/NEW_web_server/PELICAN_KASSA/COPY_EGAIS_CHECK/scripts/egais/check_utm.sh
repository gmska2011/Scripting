#!/bin/sh

FILEPATH="/home/1/drives/c/south.tml/STOP_UTM.INF"
EGAISFILEPATH="/home/1/drives/c/south.tml/common/EGAISPOS.CFG"

IP=`cat $EGAISFILEPATH |grep UTM |awk -F ":" '{print $'2'}' | sed -E ''/../s///'' `
PORT="8080"

#echo CURRENT IP - $IP
if [ -z $IP ]
then
#    echo BAD IP
    IP_GOOD=`cat /home/scripts/egais/IP`
#    echo ARCHIVE IP - $IP_GOOD
else
#    echo GOOD IP
    echo $IP > /home/scripts/egais/IP
    IP_GOOD=$IP
fi
#    echo GOOD IP - $IP_GOOD

timeout.sh -t 1 telnet $IP_GOOD $PORT |grep Escape >> /dev/null && rm -rf $FILEPATH || touch $FILEPATH
