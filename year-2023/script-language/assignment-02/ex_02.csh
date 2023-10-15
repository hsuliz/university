#!/bin/tcsh
# Hlib-Oleksandr Suliz, Script Language, group no.2

if ($#argv == 0) then
    echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 02 ~~~~~~~~~~~~~~~~~~~~~"
    set i = 1
    set j = 1
    set line = ""

    while ($i <= 9)
        while ($j <= 9)
            set value = `expr $i \* $j`
            set line = "$line $value"
            set j = `expr $j + 1`
        end
        printf "%s\n" "$line"
        set line = ""
        set i = `expr $i + 1`
        set j = 1
    end
else
    foreach arg ($argv)
        if ($arg:q == "-h" || $arg:q == "--help") then
            echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 02 ~~~~~~~~~~~~~~~~~~~~~"
            echo "Help:"
            echo "  Printing multiplication table from first argument"
            echo "  to second."
            echo "Usage:"
            echo "  tcsh ex_02.csh [-h --help] [arg1] [arg2]"
            echo "Options:"
            echo "  -h, --help  Displays this help message."
            echo "  arg1        First number"
            echo "  arg2        Second number"
            echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            exit 0
        endif
    end

    if ( $#argv == 1 ) then
      set check = `echo $1 | egrep '^[+-]?[0-9]+$'`
      if ( "$check" == "" ) then
          error
      else
        if ( $1 > 1 ) then
            set num1 = 1
            set num2 = $1
        else
            set num1 = $1
            set num2 = 1
        endif

        set i = $num1
        set j = $num1
        set line = ""

        while ($i <= $num2)
            set line = "$i"
            while ($j <= $num2)
                set value = `expr $i \* $j`
                set line = "$line $value"
                set j = `expr $j + 1`
            end

            echo $line
            set line = ""
            set i = `expr $i + 1`
            set j = $num1
        end

        echo
      endif

    else
      set check1 = `echo $1 | egrep '^[+-]?[0-9]+$'`
      set check2 = `echo $2 | egrep '^[+-]?[0-9]+$'`

      if ( "$check1" == "" ) then
            echo "Error. Given argument is not a number."
            exit 1
      else
          if ( "$check2" == "" ) then
            echo "Error. Given argument is not a number."
            exit 1
          else
                if ( $1 > $2 ) then
                    set num1 = $2
                    set num2 = $1
                else
                    set num1 = $1
                    set num2 = $2
                endif

                set i = $num1
                set j = $num1
                set line = ""

                while ($i <= $num2)
                    set line = "$i "
                    while ($j <= $num2)
                        set value = `expr $i \* $j`
                        set line = "$line $value"
                        set j = `expr $j + 1`
                    end

                    echo $line
                    set line = ""
                    set i = `expr $i + 1`
                    set j = $num1
                end
                echo
          endif
      endif
    endif
endif
