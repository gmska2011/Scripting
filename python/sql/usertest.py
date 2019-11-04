import pyodbc

server = 'BOLID\SQLSERVER2008'
database = 'orion1203'
username = 'sa'
password = '123456'
driver= 'ODBC Driver 17 for SQL Server'

cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
id = 21

#cursor.execute("SELECT * from dbo.pList;")
cursor.execute("SELECT * from dbo.pList WHERE ID='%s';" % (id))
row = cursor.fetchone()
while row:
    print (str(row[0]) + " " + str(row[1]) + " " + str(row[2]))
    row = cursor.fetchone()