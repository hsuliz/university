#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

help() {
  cat <<EOF
~~~~~~~~~~~~~~~~~~~~~ EXERCISE 03 ~~~~~~~~~~~~~~~~~~~~~
Help:
  Printing a table of your desirable operator with two arguments.
  Operators to use: +, -, \*, /, ^, %
Usage:
  bash ex_03.sh [-h --help] [num1] [num2] [operator]
Options:
  -h, --help   Displays this help message.
  num1        First number.
  num2        Second number.
  operator    The operator (+, -, *, /, ^, %).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EOF
  exit 0
}

error_one() {
  echo "Error. Number error!!"
  exit 1
}

error_two() {
  echo "Error. Operator error!!"
  exit 2
}

number='^[+-]?[0-9]+$'
chars='*[~0-9]*'
values=()
operator=""

for var in "$@"
do
  if [ "$var" == "-h" ] || [ "$var" == "--help" ]
  then
    help
  fi
done


for arg in "${@:1:3}"
do
  case "$arg" in
    [+\-*/^%])
      operator=$arg;
      continue ;;
    \*)
      operator=\*
      continue ;;
  esac

  if [[ $arg =~ $number ]]; then
    values+=($arg)
  else
    error_one
  fi

done

if [ "${#values[@]}" -ne "2" ]; then
  error_one
fi

if [ "$operator" = "" ]; then
  operator_error
fi

val1=${values[0]}
val2=${values[1]}

if [ "$val1" -gt "$val2" ]; then
  for (( i=$val1; i>=$val2; i-- ))
  do
      for (( j=$val1; j>=$val2; j-- ))
      do
          if [ $j -eq $val1 ]; then
            printf " %d | " $i
          fi

          if [ "$operator" = "/" ] || [ "$operator" = "%" ] && [ "$j" = "0" ] ; then
              printf "NaN "
          elif [ "$operator" = "^" ] && [ "$i" = 0 ] && [ "$j" -lt 0 ] ; then
              printf "NaN "
          else
            echo "$i $operator $j" | bc | tr '\n' ' '
          fi
      done
      printf "\n"
  done

else
  for (( i=$val1; i<=$val2; i++ ))
  do
      for (( j=$val1; j<=$val2; j++ ))
      do
          if [ $j -eq $val1 ]; then
            printf " %d -> " $i
          fi
          if [ "$operator" = "/" ] || [ "$operator" = "%" ] && [ "$j" = "0" ] ; then
              printf "NaN "
          elif [ "$operator" = "^" ] && [ "$i" = 0 ] && [ "$j" -lt 0 ] ; then
              printf "NaN "
          else
            echo "$i $operator $j" | bc | tr '\n' ' '
          fi
      done
      printf "\n"
  done
fi