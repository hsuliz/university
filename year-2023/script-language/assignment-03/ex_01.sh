#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 01 ~~~~~~~~~~~~~~~~~~~~~"

HELP() {
  cat <<EOF
Help:
  This program pings a range of IP addresses and provides their status.
Usage:
  bash ex_01.sh [-h --help] [IP1] [IP2]
Options:
  -h, --help   Displays this help message.
  IP1          The first IP address (or the starting IP in a range).
  IP2          The second IP address (or the ending IP in a range).
EOF
}

IS_VALID_IP() {
    local IP="$1"

    if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        IFS='.' read -ra IP_PARTS <<< "$IP"

        if [[ ${IP_PARTS[0]} -le 255 && ${IP_PARTS[1]} -le 255 && ${IP_PARTS[2]} -le 255 && ${IP_PARTS[3]} -le 255 ]]; then
            return 0
        fi
    fi
    return 1
}

INCORRECT_IP_ERROR() {
    echo "Given IP $1 is incorrect!!"
}

NO_ARGUMENTS_ERROR() {
    echo "EXCEPTION: How i supposed to work without arguments\? Provide some.."
}

PING_ON_IP() {
    local RESULT
    RESULT=$(ping -c 1 -w 1 "$1")

    if [ $? -eq 0 ]; then
        echo "$1 is alive :)"
    else
        echo "$1 is dead ;("
    fi
}

for var in "$@"
do
  if [ "$var" == "-h" ] || [ "$var" == "--help" ]
  then
    HELP
    exit 0
  fi
done

if [ $# -lt 2 ]; then
    NO_ARGUMENTS_ERROR
    exit 1
else
    if IS_VALID_IP "$1" && IS_VALID_IP "$2"; then
        IFS='.' read -ra PING_1 <<< "$1"
        IFS='.' read -ra PING_2 <<< "$2"

        for ((I = 0; I < ${#PING_1[@]}; I++)); do
            if [ ${PING_1[$I]} -gt ${PING_2[$I]} ]; then
                TEMP=("${PING_1[@]}")
                PING_1=("${PING_2[@]}")
                PING_2=("${TEMP[@]}")
                break
            elif [ ${PING_1[$I]} -lt ${PING_2[$I]} ]; then
                break
            fi
        done

        P_1=$(IFS='.'; echo "${PING_1[*]}")
        P_2=$(IFS='.'; echo "${PING_2[*]}")

        PING_ON_IP "$P_1"

        while [ "$P_1" != "$P_2" ]; do
            I=3

            while [ ${PING_1[$I]} -eq 255 ]; do
                PING_1[$I]=0
                I=$((I - 1))
            done

            PING_1[$I]=$(( ${PING_1[$I]} + 1 ))
            P_1=$(IFS='.'; echo "${PING_1[*]}")

            PING_ON_IP "$P_1"
        done
    else
        INCORRECT_IP_ERROR "$1"
    fi
fi