#!/bin/sh


if  (/sbin/ifconfig | grep ppp )
{/home/scripts/weather_gismeteo/prikol_bash.pl};
exit 0;