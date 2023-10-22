#!/bin/tcsh
# Hlib-Oleksandr Suliz, Script Language, group no.2

echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 01 ~~~~~~~~~~~~~~~~~~~~~"

if ($#argv <= 1) then
    if ( "$1" == "-h" || "$1" == "--help" ) then
      cat <<EOF
Help:
  This program pings a range of IP addresses and provides their status.
Usage:
  tcsh ex_01.tcsh [-h --help] [IP1] [IP2]
Options:
  -h, --help   Displays this help message.
  IP1          The first IP address (or the starting IP in a range).
  IP2          The second IP address (or the ending IP in a range).
EOF
    exit 0
    endif
    echo EXCEPTION: How i supposed to work without arguments\? Provide some..
    exit 0
else
    set IS_IP_CORRECT = `tcsh valid_ip.csh $1`

    if ( $IS_IP_CORRECT == 0) then
        echo EXCEPTION: Given IP $1 is incorrect!!
    else
        set IS_IP_CORRECT = `tcsh valid_ip.csh $2`
        if ( $IS_IP_CORRECT == 0) then
            echo EXCEPTION: Given IP $2 is incorrect!!
        else
            set IP1 = `echo $1 | cut -d '.' -f 1`
            set IP2 = `echo $1 | cut -d '.' -f 2`
            set IP3 = `echo $1 | cut -d '.' -f 3`
            set IP4 = `echo $1 | cut -d '.' -f 4`
            set PING_1_ARR = ( $IP1 $IP2 $IP3 $IP4 )

            set IP1 = `echo $2 | cut -d '.' -f 1`
            set IP2 = `echo $2 | cut -d '.' -f 2`
            set IP3 = `echo $2 | cut -d '.' -f 3`
            set IP4 = `echo $2 | cut -d '.' -f 4`
            set PING_2_ARR = ( $IP1 $IP2 $IP3 $IP4 )

            set I = 1
            while ($I < 5)
                if ($PING_1_ARR[$I] > $PING_2_ARR[$I]) then
                    set TEMP = ( $PING_1_ARR[1] $PING_1_ARR[2] $PING_1_ARR[3] $PING_1_ARR[4] )
                    set PING_1_ARR = ( $PING_2_ARR[1] $PING_2_ARR[2] $PING_2_ARR[3] $PING_2_ARR[4] )
                    set PING_2_ARR = ( $TEMP[1] $TEMP[2] $TEMP[3] $TEMP[4] )
                    break;
                else if ($PING_1_ARR[$I] < $PING_2_ARR[$I]) then
                    break;
                endif
                set I = `expr $I + 1`
            end

            set PING_1 = `echo $PING_1_ARR[1]'.'$PING_1_ARR[2]'.'$PING_1_ARR[3]'.'$PING_1_ARR[4]`
            set PING_2 = `echo $PING_2_ARR[1]'.'$PING_2_ARR[2]'.'$PING_2_ARR[3]'.'$PING_2_ARR[4]`

            set PING_RESULT = `ping -c 1 -w 1 $PING_1`
            set SUCCESS=$?

            if ( $SUCCESS == 0 ) then
              echo $PING_1 'is alive :)'
            else
              echo $PING_1 'is dead ;('
            endif

            while ( $PING_1 != $PING_2 )
            set i = 4
            while ( $PING_1_ARR[$i] == 255 )
                set PING_1_ARR[$i] = 0
                set i = `expr $i - 1`
            end

            set PING_1_ARR[$i] = `expr $PING_1_ARR[$i] + 1`
            set PING_1 = `echo $PING_1_ARR[1]'.'$PING_1_ARR[2]'.'$PING_1_ARR[3]'.'$PING_1_ARR[4]`

            set RESULT = `ping -c 1 -w 1 $PING_1`
            set SUCCESS=$?

            if ( $SUCCESS == 0 ) then
                echo $PING_1 'is alive :)'
            else
                echo $PING_1 'is dead ;('
            endif
        end
        endif
    endif
endif