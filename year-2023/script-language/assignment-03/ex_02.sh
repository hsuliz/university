#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

echo "~~~~~~~~~~~~~~~~~~~~~ EXERCISE 02 ~~~~~~~~~~~~~~~~~~~~~"

VALID_IP() {
    IP=$1

    if [[ $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        IP=($IP)
        IFS=$OIFS

        if [[ ${IP[0]} -le 255 && ${IP[1]} -le 255 && ${IP[2]} -le 255 && ${IP[3]} -le 255 ]]; then
            echo 1
            exit
        fi
    fi
    echo 0
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

HELP() {
  cat <<EOF
Help:
  This program pings a range of IP addresses and provides their status.
Usage:
  bash ex_02.sh [-h --help] [IP1] [IP2] [PORT]
Options:
  -h, --help   Displays this help message.
  IP1          The first IP address (or the starting IP in a range).
  IP2          The second IP address (or the ending IP in a range).
  PORT         Port of IP address.
EOF
}

IS_VALID_PORT() {
    PORT=$1

    if [[ $PORT =~ ^[0-9]+$ ]]; then
        echo 1
    else
        echo 0
    fi
}

INCORRECT_IP() {
    echo "Given IP $1 is incorrect!!"
}

NO_PORT_ERROR() {
    echo "EXCEPTION: port is invalid.."
}

NO_ARGUMENTS_ERROR() {
    echo "EXCEPTION: How i supposed to work without arguments? Provide some.."
}

PING_ON_IP() {
    PORTS=("$2")
    RESULT="$1: "

    for PORT in "${PORTS[@]}"; do
        if [ $PORT -eq 22 ]; then
            EXTRA=$(ssh -v -o ConnectTimeout=1 "$1" sleep 1 2>&1 | grep -E -o '^[a-zA-Z0-9 _.]+ ')
            if [ "$EXTRA" != "" ]; then
                RESULT="${RESULT}${PORT} - ${EXTRA},"
            fi
            continue
        fi

        RESP=$(echo "stats" | nc -w 1 -v "$1" "$PORT" 2>&1)

        if [ $? -eq 0 ]; then
            SERVER=$(echo "$RESP" | grep "Server")
            if [ $? -eq 0 ]; then
                RESP_SPLIT=($SERVER)
                CLEANED_SERVER=${RESP_SPLIT[1]//[$'\t\r\n']}
                RESULT="${RESULT} $PORT - ${CLEANED_SERVER}"
            fi
            RESP_SPLIT=($RESP)
            RESULT="${RESULT}${RESP_SPLIT[5]} - opened :) "
        else
            RESULT="${RESULT}$PORT - closed ;( "
        fi

    done
    echo $RESULT
}

IPS=()
PORTS=()

for ARG in "$@"; do
    if [ "$ARG" == "-h" ] || [ "$ARG" == "--help" ]
    then
      HELP
      exit 0
    fi
    RES=$(VALID_IP $ARG)

    if [ "$RES" == "1" ]; then
        IPS+=($ARG)
    else
        PORTS_ARG=(${ARG//,/ })

        for PORT in "${PORTS_ARG[@]}"; do
            VALID=$(IS_VALID_PORT $PORT)
            if [ "$VALID" == "1" ]; then
                PORTS+=($PORT)
            else
                NO_ARGUMENTS_ERROR
                exit 1
            fi
        done
    fi
done


if [ $# -lt 3 ]; then
    NO_ARGUMENTS_ERROR
    exit 0
else
    OIFS=$IFS
        IFS='.'
        PING_1=(${IPS[0]})
        PING_2=(${IPS[1]})
        IFS=$OIFS

        for ((i=0; i<${#PING_1[@]}; i++)); do
            if [ ${PING_1[$i]} -gt ${PING_2[$i]} ]; then
                TEMP=(" ${PING_1[@]}")
                PING_1=(" ${PING_2[@]}")
                PING_2=(" ${TEMP[@]}")
                break
            elif [ ${PING_1[$i]} -lt ${PING_2[$i]} ]; then
                break
            fi
        done

        P_1=$(IFS=$'.'; echo "${PING_1[*]}")
        P_2=$(IFS=$'.'; echo "${PING_2[*]}")

        PING_ON_IP $P_1 $PORTS

        while [ "$P_1" != "$P_2" ]; do
            I=3

            while [ ${PING_1[$I]} -eq 255 ]; do
                PING_1[$I]=0
                I=$(($I - 1))
            done

            PING_1[$I]=$((${PING_1[$I]} + 1))
            P_1=$(IFS=$'.'; echo "${PING_1[*]}")

            PING_ON_IP $P_1 $PORTS
        done
fi
