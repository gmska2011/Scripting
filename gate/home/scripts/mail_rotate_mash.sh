#!/bin/sh
DIR="/var/vmail/neo63.ru/mashinzeva"

find $DIR/cur -type f -mtime +250 -exec rm -rf {} \;
find $DIR/new -type f -mtime +250 -exec rm -rf {} \;
#find $DIR/cur -size +5000k  -type f -exec rm -rf {} \;
