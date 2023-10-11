#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

SHOW_HELP=false
    
help() {
    echo "~~~~~~~~~~~~~~~~~~~~~EXERCISE 01~~~~~~~~~~~~~~~~~~~~~"
    echo "Help:"
    echo "      Printing current user login, name and surname."
    echo "Usage: "
    echo "      bash ex_01.sh [-h --help] [-q --quiet]"
    echo "Options:"
    echo "      -h, --help    Display this help message."
    echo "      -q, --quiet   Quiet mode, do nothing."
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    exit 0
}

while getopts ":h :q" FLAG;
do
  case $FLAG in
    h|--help) SHOW_HELP=true;;
    q|--quiet) QUIET_MODE=true;;
    ?);;
  esac
done

if [ "$SHOW_HELP" = true ]; then
  help
fi

if [ "$QUIET_MODE" = true ]; then
  exit 0
fi

get_current_user() {
    CURRENT_USER=$(getent passwd $USER)
    CURRENT_USER=$(echo $CURRENT_USER | cut -d : -f 5 | cut -d, -f1)
    echo "Current username is: $USER"
    echo "Name and surname is: $CURRENT_USER"
    exit 0
}

get_current_user