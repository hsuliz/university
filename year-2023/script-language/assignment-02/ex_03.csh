#!/bin/csh
# Hlib-Oleksandr Suliz, Script Language, group no.2

set values = ()
set operator = ""

foreach arg ($argv)
  if ($arg:q == "-h" || $arg:q == "--help") then
      echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 03 ~~~~~~~~~~~~~~~~~~~~~"
      echo "Help:"
      echo "  Printing a table of your desirable operator with two arguments."
      echo "  Order of arguments doesn't matter."
      echo "  Operators to use: +, -, *, /, ^, %"
      echo "Usage:"
      echo "  tcsh ex_03.csh [-h --help] [num1] [num2] [operator]"
      echo "Options:"
      echo "  -h, --help   Displays this help message."
      echo "  num1         First number."
      echo "  num2         Second number."
      echo "  operator     The operator (+, -, *, /, ^, %)."
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      end
    exit 0
  endif
end

set i = 0

foreach arg ($argv)
  set i = `expr $i + 1`

  if ($i > 3) then
    break
  else
    set check_number = `echo ${arg} | egrep '^[+-]?[0-9]+$'`
    if ( "$check_number" != "" ) then
      set values = ($values $arg)
    else
      if ( "$arg" == "-" || "$arg" == "+" || "$arg" == "/" || "$arg" == "^" || "$arg" == "%" ) then
        set operator = $arg
      else if ( "$arg" == "m" ) then
        set operator = \*
      else
        echo "Error. Number error!!"
        exit 1
      endif
    endif
  endif
end

if ($i == 0 || ${#values} < 2) then
    echo "Error. Operator error!!"
    exit 1
endif

else if ("$operator" == "") then
    echo "Error. Operator error!!"
    exit 2
endif

set val1 = $values[1]
set val2 = $values[2]

if ( "$val1" > "$val2" ) then
  set i = $val1
  set j = $val1

  echo
  while ($i >= $val2)
      echo "$i -> " | tr '\n' ' '
      while ($j >= $val2)
          if ( ("$operator" == "/" ||  "$operator" == "%" ) && ( "$j" == "0" )) then
            echo "NaN" | tr '\n' ' '
          else if ( "$operator" == "^"  &&  "$i" == 0  &&  "$j" < 0 ) then
            echo "NaN" | tr '\n' ' '
          else
            echo "$i $operator $j" | bc | tr '\n' ' '
          endif
          set j = `expr $j - 1`
      end
      set i = `expr $i - 1`
      set j = $val1
      echo
  end
  echo
else
  set i = $val1
  set j = $val1

  echo
  while ($i <= $val2)
      echo "$i -> " | tr '\n' ' '
      while ($j <= $val2)
          if ( ("$operator" == "/" ||  "$operator" == "%" ) && ( "$j" == "0" )) then
            echo "NaN" | tr '\n' ' '
          else if ( "$operator" == "^"  &&  "$i" == 0  &&  "$j" < 0 ) then
            echo "NaN" | tr '\n' ' '
          else
            echo "$i $operator $j" | bc | tr '\n' ' '
          endif
          set j = `expr $j + 1`
      end
      set i = `expr $i + 1`
      set j = $val1
      echo
  end
  echo
endif
