#!/bin/tcsh
# Hlib-Oleksandr Suliz, Script Language, group no.2

echo "~~~~~~~~~~~~~~~~~~~~~EXERCISE 01~~~~~~~~~~~~~~~~~~~~~\n"

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
