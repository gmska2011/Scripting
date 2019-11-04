import getpass
import sys
import telnetlib

HOST = '10.100.0.13'
#user = raw_input("Enter your remote account: ")
password = ""
user = "muxa"

tn = telnetlib.Telnet(HOST,23,5)
tn.read_until("Username: ", 5)
tn.write(user + "\n")
if password:
    tn.read_until("Password: ", 5)
    tn.write(password + "\n")

tn.read_until("#", 5)
tn.write('sh ver \n')

data = ''
while data.find('#') == -1:
    data = tn.read_very_eager()
print data