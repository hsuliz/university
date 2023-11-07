#!/bin/tcsh

if( $#argv == 1 ) then
    set ip=`echo $1 | grep -E -o '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
    if ( $ip == $1 ) then
        set address=`echo $ip | awk 'BEGIN { FS="." } { print $1; print $2; print $3; print $4 }'`
        set ip =($address:as/\n/ /)
        if ( $ip[1] > 255 || $ip[2] > 255 || $ip[3] > 255 || $ip[4] > 255) then
            goto error
        endif
        exit 0
    endif
    error:
    echo "IP is wrong"
else
    echo "Give me IP"
endif
exit 1