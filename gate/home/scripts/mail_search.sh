#!/bin/sh

#xargs grep -Ilr 'Коллеги ,сформирована разнарядка по  позиции' /var/vmail/neo63.ru/new #| xargs 
cd /var/vmail/neo63.ru/chepkalenko.v/

find . -type f -newermt 2019-02-22 ! -newermt 2019-02-22| xargs grep -Ilr "Распределение крепкий алкоголь" |xargs
# xargs  -I{} cp "{}" /tmp/
