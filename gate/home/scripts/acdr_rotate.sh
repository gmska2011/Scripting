#!/bin/sh

find /var/spool/asterisk/monitor/ -type f -mtime +365 -exec rm -rf {} \;
