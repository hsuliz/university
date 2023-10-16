#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

help() {
  echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 02 ~~~~~~~~~~~~~~~~~~~~~"
  echo "Help:"
  echo "  Printing multiplication table from first argument"
  echo "  to second."
  echo "Usage:"
  echo "  bash ex_02.csh [-h --help] [arg1] [arg2]"
  echo "Options:"
  echo "  -h, --help  Displays this help message."
  echo "  arg1        First number."
  echo "  arg2        Second number."
  exit 0
}

error() {
  echo "Error. Given argument is not a number."
  exit 1
}


calculate() {
  echo
  echo '~~~~~~~~~~~~~~~~~~~~~ EXERCISE 02 ~~~~~~~~~~~~~~~~~~~~~'

  for (( i=$1; i<=$2; i++ ))
  do
      for (( j=$1; j<=$2; j++ ))
      do
          if [ $j -eq $1 ]; then
            printf " %d -> " $i
          fi

          val=$(($i*$j))
          printf "%d " $val
      done
      printf "\n"
  done

  echo
}


number='^[+-]?[0-9]+$'

if [ $# -eq 0 ]; then
  calculate 1 9
else
  for var in "$@"; do
    if [ "$var" == "-h" ] || [ "$var" == "--help" ]; then
      help
      exit 0
    fi
  done

  if [ $# -eq 1 ]; then
    if [[ $1 =~ $number ]]; then
      if [ $1 -gt 1 ]; then
        calculate 1 $1
      else
        calculate $1 1
      fi
    else
      error
    fi
  else
    if [[ $1 =~ $number ]] && [[ $2 =~ $number ]]; then
      if [ $1 -gt $2 ]; then
        calculate $2 $1
      else
        calculate $1 $2
      fi
    else
      error
      exit 1
    fi
  fi
fi