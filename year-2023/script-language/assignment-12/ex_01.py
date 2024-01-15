#!/usr/bin/python3
# Hlib-Oleksandr Suliz, Script Language, group no.2

import os
import re
import sys


def print_error(file, line_nr, line):
    print('ERROR at line ' + str(line_nr) + ' (' + str(file) + '): ' + str(line))


def change_name(name):
    return name.capitalize()


def get_grade(grade):
    if re.search("^[+-]?\d*[.]?\d*$", grade) or re.search("^\d*[.]?\d*[+-]?$", grade):
        if re.search("^[+]+\d*[.]?\d*$", grade):
            value = float(re.split(r'^[+]', grade)[1])

            if value == 0 or (value >= 2 and value <= 5):
                value += 0.25
                return value
            else:
                return -1

        elif re.search("^\d*[.]?\d*[+]+$", grade):
            value = float(re.split(r'[+]$', grade)[0])

            if (value == 0 or (value >= 2 and value <= 5)):
                value += 0.25
                return value
            else:
                return -1

        elif re.search("^[-]+\d*[.]?\d*$", grade):
            value = float(re.split(r'^[-]', grade)[1])

            if value == 0 or (value >= 2.25 and value <= 5):
                value -= 0.25
                return value
            else:
                return -1

        elif re.search("^\d*[.]?\d*[-]+$", grade):
            value = float(re.split(r'[-]$', grade)[0])

            if (value == 0 or (value >= 2.25 and value <= 5)):
                value -= 0.25
                return value
            else:
                return -1

        elif re.search("^\d*[.]?\d*$", grade):
            value = float(grade)
            if value == 0 or (value >= 2 and value <= 5):
                return value
            else:
                return -1

    else:
        return -1


if __name__ == '__main__':
    for i in range(1, len(sys.argv)):
        with open(sys.argv[i], 'r') as my_file:
            line_nr = 1
            grades = {}
            for line in my_file:
                split_line = line.split()

                if len(split_line) < 3:
                    print_error(sys.argv[i], line_nr, line)
                else:
                    name = change_name(split_line[0]) + " " + change_name(split_line[1])
                    grade = get_grade(split_line[2])

                    if grade != -1:
                        if name not in grades:
                            grades[name] = ['0.0']

                        grade_temp = str(float(grades[name][0]) + float(grade))
                        grades[name][0] = grade_temp
                        grades[name].append(split_line[2])

                    else:
                        print_error(sys.argv[i], line_nr, line)

                line_nr += 1

            file_name = os.path.splitext(os.path.basename(sys.argv[i]))[0]
            file_name = file_name + ".oceny"

            new_file = open(file_name, 'w')

            g_avg = 0.0
            for key in sorted(grades):
                new_file.write(key + ": ")

                for i in range(1, len(grades[key])):
                    new_file.write(str(grades[key][i]) + " ")

                avg = round(float(grades[key][0]) / (len(grades[key]) - 1), 2)
                g_avg += avg
                new_file.write(": " + str(avg) + "\n")

            new_file.write("\nAverage of all grades: " + str(round(g_avg / len(grades), 2)))
