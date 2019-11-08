#!/bin/sh

# Проброс через Инфоладу
ip ru add from 10.10.10.0/24 lookup INET
ip ru add from 192.168.14.0/24 lookup INET
ip ru add from 192.168.0.0/16 lookup INET
ip ro replace 192.168.0.0/16 via 192.168.0.4 dev eth0 table INET
ip ro ls table INET
