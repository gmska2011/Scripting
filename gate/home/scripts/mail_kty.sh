#!/bin/sh

grep -Ilr 'распределение' /var/vmail/neo63.ru/ | xargs rm -f
