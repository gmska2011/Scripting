#!/bin/sh

DIR="/var/vmail/neo63.ru/mironova/"
echo "ДО ОЧИСТКИ:"
du -sh $DIR/*
echo "####################################"

find $DIR/cur  -type f -mtime +365 -exec rm -rf {} \;
find $DIR/new   -type f -mtime +365 -exec rm -rf {} \;
#find $DIR/.Sent/cur   -type f -mtime +200 -exec rm -rf {} \;
#find $DIR/cur -size +5000k  -type f -exec rm -rf {} \;

echo "ПОСЛЕ ОЧИСТКИ:"
du -sh $DIR/*
echo "####################################"
