#!/bin/sh

cd /home/scripts/PRINTER_CHECK/
DATE=`date "+%Y-%m-%d_%H:%M"`

echo $DATE > LOG.TXT


get_ip ()
    {
    VAR=$1
    #####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
#    PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws.ip_ws FROM ws,shop WHERE shop.online=1 and ws.id_mag=shop.id" `
    PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws.ip_ws FROM ws,shop WHERE shop.online IN ('1','2') and ws.id_mag=shop.id" `
    echo $PARAM
    }

get_id_mag ()
    {
    VAR=$1
    #####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
    PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT id_mag FROM ws WHERE ip_ws='$VAR'" `
    echo $PARAM
    }

get_id_ws ()
    {
    VAR=$1
    #####  PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT ws_kas.ip_kas FROM ws_kas,shop WHERE shop.online=1 and shop.id=156 and ws_kas.id_mag=shop.id" `
    PARAM=`mysql -N -D ip_pelican -u root -puk.rjyfn2009 -e "SELECT id FROM ws WHERE ip_ws='$VAR'" `
    echo $PARAM
    }

IP_WS=`get_ip ip`
#IP_WS='192.168.5.10'
#IP_KASSA=$PARAM
#IP_KASSA="192.168.74.11"
PASS='111111'


for ip in $IP_WS ; do

fping -c1 -t300 $ip 2>/dev/null 1>/dev/null                                                                                                              
if [ "$?" = 0 ]                                                                                                                                           
then                                                                                                                                                      
  echo "PING" $ip " - OK"
  echo ""
  echo "----- PRINTERS -----"
    ### 3D Scaner Check ###
#    /usr/bin/sshpass -p $PASS ssh -o 'StrictHostKeyChecking no' root@$ip "lsusb |grep 0c2e:0be1"
#    PRINTERS=`smbclient -L $ip -N 2> /dev/null| awk '/Printer/'|awk '{print $3,$4,$5}'|tr '\n' ';'`
    PRINTERS=null
#    PRINTERS=`smbclient -L $ip -N 2> /dev/null| awk '/Printer/'| sed -n '/.*\(Printer[^\n]*\)/s//\1/p'|awk '{print $2,$3}'|tr '\n' ';'`
    PRINTERS=`smbclient -L $ip -N 2> /dev/null| awk "/Printer/"| awk -F 'Printer   ' '{print $2}'|tr '\n' ';'`
#    PRINTERS=`smbclient -L $ip -N 2> /dev/null| awk '/Printer/'|awk '{print $3,$4,$5}'|tr '\n' ';'`
#| awk '/Printer/'| sed -n '/.*\(Printer[^\n]*\)/s//\1/p'|awk '{print $2,$3}'|tr '\n' ';'`


    for i in 1 2 3 4 5 ; do
    printer=null
    printer=`echo $PRINTERS |awk -F ";" '{print $'$i'}'`

    #Mysql update printers info
    
if [ -z "$printer" ]; then
    echo  - ERROR 
    else 
#    echo $printer - OK 


    ID_MAG=`get_id_mag "$ip"`
#    echo $ID_MAG
    ID_WS=`get_id_ws "$ip"`
#    echo $ID_WS

    if [ $i -eq 1 ]; then  
    echo delete all printers from this mag
    echo "delete from printers where id_mag='$ID_MAG';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
#    echo "delete from printers where id_mag='$ID_MAG' and id_ws='$ID_WS' and printer_name='$printer';" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    fi

    # Удаляем символ '
    printer=`echo $printer | sed -e "s/'//g"` 

    
    case $printer in
#	*HL-2240D*) printer=`echo "Brother HL-2240D"`;;
#	*HL-2240*|!HL-2240D*) printer=`echo "Brother HL-2240"`;;
#	*Brother*|*!7065*|*!HL-2240*|!HL-2240D*) printer=`echo "Brother HL-2240"`;;
#	*7065*) printer=`echo "Brother DCP-7065"`;;
	*Citizen*) printer=`echo "Citizen"`;;
	*Datamax*) printer=`echo "Datamax"`;;
#	*Canon*|*CANON*) printer=`echo "Canon"`;;
	*Xerox*|*XEROX*) printer=`echo "Xerox"`;;
#	*HP*|*hp*) printer=`echo "HP"`;;
#	*Kyocera*) printer=`echo "Kyocera"`;;
    esac

    echo $printer - OK 

    echo "INSERT INTO printers (id_mag,id_ws,printer_name) VALUES('$ID_MAG','$ID_WS','$printer');" | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    echo "INSERT INTO printers (id_mag,id_ws,printer_name) VALUES('$ID_MAG','$ID_WS','$printer');"
# | mysql -uroot -puk.rjyfn2009 ip_pelican; 
    
    fi
    done

#| while read line; do echo $printer "$line"; done
#    for printer in $PRINTERS ; do
#    done
    
    if [ $? -ne 0 ]; then
    echo $ip - ERROR >> ./LOG.TXT
    else
    echo $ip - OK >> ./LOG.TXT

    fi
    ### END 3D Scaner Check ###

else                                                                                                                                                      
  echo "PING" $ip " - Unreachetable"                                                                                                                            
  echo $ip - PING ERROR >> ./LOG.TXT
                                                                                                                                                          
fi 

done
