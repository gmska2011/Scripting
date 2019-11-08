#!/bin/bash

export LC_ALL=""
export LANG="en_US.UTF-8"
#
  ##### PARAMETERS #####
  HOST="$1"
  CPUNAME="$2"
#  TABLE=`sensors 2>&1 | awk '{if (tolower($1)~"adapter") { counter +=1; } if (tolower($1)=="core")
#      { if ($3 > temperature[counter]) temperature[counter] = $3;}}
#      END {for (i=1; i<=counter; i+=1) printf ( "CPU%1d %2.1f\n", i-1, temperature[i]); }'`
 TABLE=`sensors 2>&1 |grep Core |awk '{print "CPU"$2,$3}'|sed 's/+//'|sed 's/://'|sed 's/°C//'`
  echo "${TABLE}" | awk "/${CPUNAME}/ {print \$2}" | head -n1
#
