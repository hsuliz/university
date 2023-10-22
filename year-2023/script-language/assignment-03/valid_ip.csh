#!/bin/tcsh
# Hlib-Oleksandr Suliz, Script Language, group no.2

set IP = $1
set CHECK_IP = `echo ${IP} | egrep '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'`

if ( "$CHECK_IP" == "" ) then
  echo "0"

else
  set IP1 = `echo $IP | cut -d '.' -f 1`
  set IP2 = `echo $IP | cut -d '.' -f 2`
  set IP3 = `echo $IP | cut -d '.' -f 3`
  set IP4 = `echo $IP | cut -d '.' -f 4`

  if ( ( $IP1 >= 0 && $IP1 <= 255 ) 
  && ( $IP2 >= 0 && $IP2 <= 255 ) 
  && ( $IP3 >= 0 && $IP3 <= 255 ) 
  && ( $IP4 >= 0 && $IP4 <= 255 ) ) then
    echo "1"
  else
    echo "0"
  endif
endif