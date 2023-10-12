#!/bin/bash
# Hlib-Oleksandr Suliz, Script Language, group no.2

echo "~~~~~~~~~~~~~~~~~~~~~EXERCISE 01~~~~~~~~~~~~~~~~~~~~~"

for i in {1..9}
do
    for j in {1..9}
    do
        a=$(($i*$j))
        printf "%2d " $a 
    done
    printf "\n"
done
