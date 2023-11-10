#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

dn=$(dirname "$0")

ip="127.0.0.1"
port='8080'

client=0
options=0
globCounter=0
paramCounter=1
lineNumber=0

valid_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

link=$(echo "$0" | grep -E -o 'ex_01.sh')
if [[ $link == "ex_01.sh" ]]; then
    echo "#!/bin/bash" > "$dn/serwer.sh"
    echo "dn=\$(dirname \$0)"  >> "$dn/serwer.sh"
    echo "\$dn/ex_01.sh \$*" >> "$dn/serwer.sh"
    chmod u=rwx "$dn"/serwer.sh

    echo "#!/bin/bash" > "$dn/klient.sh"
    echo "dn=\$(dirname \$0)"  >> "$dn/klient.sh"
    echo "\$dn/ex_01.sh -c \$*" >> "$dn/klient.sh"
    chmod u=rwx "$dn"/klient.sh
fi

if [[ $# != 0 ]]; then
    for PARAMETR in $*; do
        if [[ "$PARAMETR" == "-h" ]]; then
                    echo "help"
                    exit 0
        elif [[ "$PARAMETR" == "-c" ]] || [[ "$PARAMETR" == "--klient" ]]; then
            client=1
        elif [[ "$PARAMETR" == "-i" ]]; then
            if [[ $options -eq 0 ]]; then
                options=1
            elif [[ $options -eq 1 ]]; then
                options=1
            elif [[ $options -eq 2 ]]; then
                options=3
            fi

            ip=$((paramCounter + 1))
            ip=${!ip}
            if valid_ip $ip; then stat='1'; else stat='0'; fi
            if [ $stat == '0' ]; then echo "Wrong IPv4!!"; exit 1; fi
        elif [[ "$PARAMETR" == "-p" ]]; then

            if [[ $options -eq 0 ]]; then
                options=2
            elif [[ $options -eq 2 ]]; then
                options=2
            elif [[ $options -eq 1 ]]; then
                options=3
            fi

            port=$((paramCounter + 1))
            port=${!port}

            if [[ $(echo "$port" | grep -E -o '^([0-9]+,{0,1})+') == "" ]]; then
                echo "Wrong port number!!"; exit 2
            fi
        fi
        paramCounter=$((paramCounter + 1))
    done
fi

file="$dn/.licznik.rc"

if [[ -f "$file" ]]; then
    echo "Config $file exists..."
    globalLineNumber=1
    while read -r line; do
        if [[ $options -eq 1 ]] || [[ $options -eq 0 ]]; then
            if [[ $(echo "$line" | grep -E -o 'default port') == "default port" ]]; then
                port=$(echo "$line" | grep -E -o '[0-9]+')
            fi
        fi
        if [[ $options -eq 2 ]] || [[ $options -eq 0 ]]; then
            if [[ $(echo "$line" | grep -E -o 'default ip') == "default ip" ]]; then
                ip=$(echo "$line" | grep -E -o 'localhost')
                if [[ $ip == "" ]]; then
                    ip=$(echo "$line" | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
                fi
            fi
        fi
        address=$(echo "$line" | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\:[0-9]+')
        if [[ $address == "$ip:$port" ]]; then
            globCounter=$(echo "$line" | grep -E -o ' [0-9]+')
            lineNumber=$globalLineNumber
        fi
        globalLineNumber=$((globalLineNumber + 1))
    done <"$file"
    if [[ $lineNumber -eq 0 ]]; then
        lineNumber=$globalLineNumber
        echo "$ip:$port $globCounter" >> .licznik.rc
    fi
else
    echo "Config file doest exists; Creating..."
    echo "default ip = $ip" > .licznik.rc
    echo "default port = $port" >> .licznik.rc
fi

if [[ $client -eq 0 ]]; then
    status=$(nc -zv -w 1 "$ip" "$port" 2>&1 | grep -E -o 'failed')
    if [[ $status == 'failed' ]]; then
        echo "Server successfully created!![$ip:$port]"
        while true; do
            status=$(nc -d -l $ip "$port")
            if [[ $? -ne 0 ]]; then
                echo "Unable to create server on this address[$ip:$port]"
                exit 4
            fi
            if [[ $status != "" ]]; then
                echo "Message: $status"
                globCounter=$(($globCounter + 1))
                if [[ $lineNumber -eq 0 ]]; then
                    sed -i "3 s/.*/$ip:$port $globCounter/" $file
                else
                    sed -i "$lineNumber s/.*/$ip:$port $globCounter/" $file
                fi
            fi
            echo "Number of calls to server: $globCounter"
            status=""
        done
    else
        echo "Server already exists on this port[$port]"
        exit 3
    fi
else
    echo "Connection established [$ip:$port]"
    while true; do
        read -r message
        echo "$message" | nc -w 0 $ip $port
    done

fi