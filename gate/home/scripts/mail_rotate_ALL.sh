#!/bin/sh
DIR="/var/vmail/neo63.ru/"

find $DIR  -type f -mtime +720 -exec rm -rf {} \;
