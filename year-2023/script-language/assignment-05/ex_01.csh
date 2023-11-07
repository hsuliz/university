#!/bin/tcsh
# Hlib-Oleksandr Suliz, Script Language, group no.2


set dn=`dirname $0`

set ip="127.0.0.1"
set port="8080"

set client = 0
set options = 0
set paramCounter = 1
set globCounter = 0
set lineNumber = 0


set link=`echo $0 | grep -E -o 'ex_01.csh'`
if ( $link == "ex_01.csh") then
    echo "#\!/bin/tcsh" >! "$dn/serwer.csh"
    echo 'dn=$(dirname $0)'  >>! "$dn/serwer.csh"
    echo "$dn/ex_01.csh"' $*' >>! "$dn/serwer.csh"
    chmod u=rwx $dn/serwer.csh

    echo "#\!/bin/tcsh" >! "$dn/klient.csh"
    echo 'dn=$(dirname $0)'  >>! "$dn/klient.csh"
    echo "$dn/ex_01.csh -c"' $*' >>! "$dn/klient.csh"
    chmod u=rwx $dn/klient.csh
endif

if ( $#argv != 0 ) then
    while ( $paramCounter <= $#argv )
        if ( "$argv[$paramCounter]" == "-c" || "$argv[$paramCounter]" == "--klient" ) then
            @ client=1
        else
            if ( "$argv[$paramCounter]" == "-i") then
                if ($options == 0) then
                    set options = 1
                else
                    if ($options == 1) then
                        @ options=1
                    else
                        if ($options == 2) then
                            @ options=3
                        endif
                    endif
                endif
                @ paramCounter = $paramCounter + 1
                if ($paramCounter > $#argv) then
                    echo "Give me ip address\!"
                    exit 1
                else
                    source $dn/ip_validator.csh "$argv[$paramCounter]"
                    if ( $? != 0) then
                        exit 1
                    else
                        set ip="$argv[$paramCounter]"
                    endif
                endif
            else
                if ( "$argv[$paramCounter]" == "-p") then
                    if ($options == 0) then
                        @ options=2
                    else
                        if ($options == 2) then
                            @ options=2
                        else
                            if ($options == 1) then
                                @ options=3
                            endif
                        endif
                    endif
                    @ paramCounter = $paramCounter + 1
                    if ($paramCounter > $#argv) then
                        echo "Give me port\!"
                        exit 2
                    else
                        set status = `echo "$argv[$paramCounter]" | grep -E -o '^([0-9]+,{0,1})+'`
                        if ( "$status" == "") then
                            echo "Port must be a number\!"
                            exit 2
                        else
                            set port="$argv[$paramCounter]"
                        endif
                    endif
                endif
            endif
        endif

        @ paramCounter = $paramCounter + 1
    end
endif

set file="$dn/.licznik.rc"

if ( -e "$file" ) then
    echo "Config $file exists..."

    @ globalLineNumber=1
    foreach line ( "`cat $file`" )
        if ($options == 1 || $options == 0) then
            set message = `echo "$line" | grep -E -o 'default port'`
            if ("$message" == "default port") then
                set port = `echo "$line" | grep -E -o '[0-9]+'`
            endif
        endif

        if ($options == 2 || $options == 0) then
            set message = `echo "$line" | grep -E -o 'default ip'`
            if ("$message" == "default ip") then
                set ip = `echo "$line" | grep -E -o '127.0.0.1'`
                if ("$ip" == "") then
                    set ip = `echo "$line" | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
                endif
            endif
        endif
        set address=`echo "$line" | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\:[0-9]+'`
        if ( "$address" == "$ip"':'"$port" ) then
            @ globCounter = `echo "$line" | grep -E -o ' [0-9]+'`
            @ lineNumber = $globalLineNumber
        endif
        @ globalLineNumber = $globalLineNumber + 1
    end
    if ($lineNumber == 0) then
        @ lineNumber = $globalLineNumber
        echo "$ip"':'"$port $globCounter" >>! .licznik.rc
    endif
else
    echo "Config file doest exists; Creating..."
    echo "default ip = $ip" >! .licznik.rc
    echo "default port" = $port >>! .licznik.rc
endif
if ($client == 0) then
    set status = `nc -zv -w 1 $ip $port |& grep -E -o 'failed'`
    if ("$status" == "failed") then
        echo "Server successfully created $ip $port"
        while (1)
            set status = `nc -d -l $ip $port`
                echo "Message: $status"
                @ globCounter = $globCounter + 1
                if ($lineNumber == 0) then
                    sed -i "3 s/.*/${ip}:${port} ${globCounter}/" $file
                else
                    sed -i "${lineNumber} s/.*/${ip}:${port} ${globCounter}/" $file
            endif
            echo "Number of calls to server: $globCounter"
            set status = ""
        end
    else
        echo "$ip"":$port"
        echo "Server already exists on this address"
        exit 3
    endif
else
    echo "Connection established $ip $port"
    while (1)
        set message = $<
        echo "$message" | nc -w 0 $ip $port
    end
endif