#!/bin/sh
if [ ! "$(/usr/sbin/asterisk -rx 'sip show peer SIPNET ' | grep Status)" = 'OK' ];then /usr/sbin/asterisk -rx 'sip reload'; fi