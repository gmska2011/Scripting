#!/bin/sh

grep -Ilr 'Undelivered' /var/vmail/neo63.ru/albatros/Maildir/cur/ | xargs rm -f
