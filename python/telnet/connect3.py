import os,re,telnetlib
host = "10.100.0.2"
port = 23

telnet = telnetlib.Telnet()
telnet.open(host, port)
telnet.write('muxa\r\n')
telnet.write('vb[fxtvgbjy2015\r\n')
out = telnet.read_until("#", 5)
print(out)

telnet.write('sh mac address-table | include b0:61:c7\r\n') #Mycommand
out = telnet.read_until("#", 5)
print(out)
telnet.write('quit\r\n')
telnet.close()