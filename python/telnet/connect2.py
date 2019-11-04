import getpass
import sys
import telnetlib

HOST = "10.100.0.13"
user = raw_input("Enter your remote account: ")
password = getpass.getpass()

tn = telnetlib.Telnet(HOST)

tn.read_until("User Name:")
tn.write(user + "\n")
if password:
   tn.read_until("Password:")
   tn.write(password + "\n")

tn.write("sh running config\n")
tn.write("exit\n")
print tn.read_all()