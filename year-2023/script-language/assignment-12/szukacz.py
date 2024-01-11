#!/usr/bin/python3
# Hlib-Oleksandr Suliz, Script Language, group no.2


import os
import re
import sys

argv = sys.argv
to_find = {}


def get_args():
    directories = []
    i = 1
    while i < (len(argv)):
        if argv[i] == '-d':
            directories.append(argv[i + 1])
            i = i + 2
        else:
            to_find[argv[i]] = directories
            directories = []
            i = i + 1

    print(to_find)


if __name__ == '__main__':
    get_args()

    for word, folders in to_find.items():
        for folder in folders:
            path = folder
            to_find = word
            files_name = []
            for subdir, dirs, files in os.walk(path):
                for file in files:
                    filepath = subdir + os.sep + file
                    files_name.append(filepath)

            for file_name in files_name:
                founded = re.search(to_find, file_name)
                if founded is not None:
                    print(file_name)
