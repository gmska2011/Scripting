#!/bin/sh
DIR="/var/vmail/neo63.ru/sbs/"

find $DIR/cur  -type f -mtime +30 -exec rm -rf {} \;
find $DIR/new   -type f -mtime +30 -exec rm -rf {} \;
find $DIR/cur -size +5000k  -type f -exec rm -rf {} \;
