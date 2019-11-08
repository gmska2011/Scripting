#!/usr/bin/env python3

import connect as s
import pyodbc
import os

cnxn = pyodbc.connect('DRIVER='+s.driver+';SERVER='+s.server+';PORT=1433;DATABASE='+s.database+';UID='+s.username+';PWD='+s.password)
cursor = cnxn.cursor()
#cursor.execute("SELECT TOP 6 * from dbo.pLogData WHERE 'HozOrgan' is not NULL order by 'TimeVal' DESC;")
cursor.execute("SELECT TOP 500 * from dbo.pLogData WHERE 'HozOrgan' is not NULL and Event='28' order by 'TimeVal' DESC;")
#cursor.execute("SELECT * from dbo.pLogData WHERE 'HozOrgan' is not NULL and CAST(TimeVal as date) BETWEEN '2019-10-14 00:00:00' AND '2019-10-14 23:59:00' order by 'TimeVal' DESC;")

def userName(user):
    cursor.execute("SELECT TOP 1 * from dbo.pList WHERE ID='%s';" % (user))
    row2 = cursor.fetchone()
#    return(row2[1]+" "+row2[2][:1]+"."+row2[3][:1]+".") 	# Фамилия И.О.
    return(row2[1]+" "+row2[2]+" "+row2[3]) 			# Фамилия Имя Отчество

def userPhoto(user):
    cursor.execute("SELECT TOP 1 * from dbo.pList WHERE ID='%s';" % (user))
    row2 = cursor.fetchone()
    return(row2[7])

try:
    list1 = list(cursor)
#    print(list1)
    for row in list1:

        if (str(row[10]) != '0' and str(row[10]) != 'None' and row[7] == 28):
#            print(row[0])
#        if ( str(row[10]) != 'None'):
            empty_str="			"
            try: 
                direction=(str(row[12]).split(': ')[1].split(' ')[0].lower())
                print(direction+":	"+str(row[0])+empty_str+str(row[10])+" ", end='')
            except:
                pass
#            FILENAME = str(row[10])+".jpg"
            try: 
#                FILENAME = str(row[10])+"_"+userName(int(str(row[10])))+".jpg"
##                FILENAME = userName(int(str(row[10])))+".jpg"
##                somefile = open('photo/'+FILENAME, "wb")
                print(userName(int(str(row[10]))))
##                somefile.write(userPhoto(int(str(row[10]))))
##                somefile.close()
            except:
                pass
except:
    pass
