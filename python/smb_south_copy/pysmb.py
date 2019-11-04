#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import ipdb
import pymysql.cursors
import pymysql


def run_debugger(type, value, tb):
    ipdb.pm()

#sys.excepthook = run_debugger

def copySouth(ip,filetocopy):
    from smb.SMBConnection import SMBConnection
    userID = 'user'
    password = ''
    client_machine_name = 'NEODC'

    server_name = 'servername'
    server_ip = ip

    domain_name = 'domainname'
    conn = SMBConnection(userID, password, client_machine_name, server_name, domain=domain_name, use_ntlm_v2=True, is_direct_tcp=True)
    error="OK"
    try:
        conn.connect(server_ip, 445)
        with open(filetocopy, 'rb') as file:
            try:
                conn.storeFile('south', filetocopy, file)
                conn.close()
            except Exception:
                error="Could not copy file to " +server_ip
                pass

    except Exception:
        error="Could not CONNECT to " +server_ip
        pass
    return(ip+" - "+error)

#tr1 = copySouth('192.168.225.225','cip_out.bat')
#copySouth('192.168.225.225','cip_out2.bat')

# Connect to the database
connection = pymysql.connect(host='10.63.0.242',
                             user='pelican',
                             password='pelican123',
                             db='pelican',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
try:
    with connection.cursor() as cursor:
        # Read a single record
        sql = "SELECT ws.ip FROM ws, object WHERE ws.id_object=object.id and object.type = 'ПЕЛИКАН' and object.open=1 and ws.os LIKE '%Windows%'"
        cursor.execute(sql)
        result = cursor.fetchall()
        for row in result:
            print("try: "+row['ip'])
            print(copySouth(row['ip'],'cip_out.bat'))
            print(copySouth(row['ip'],'cip_out2.bat'))
except: 
    pass
#            print(result)
finally:
    connection.close()

