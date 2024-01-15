#!/usr/bin/python3
# Hlib-Oleksandr Suliz, Script Language, group no.2


import os
import re
import sys

f = open(os.devnull, 'w')
sys.stdout = f


def process_file(file_path, options):
    counts = {
        'word': 0,
        'line': 0,
        'char': 0,
        'integer': 0,
        'all_numbers': 0
    }

    with open(file_path, 'r') as my_file:
        for line in my_file:
            if options['e'] and line.strip().startswith("#"):
                continue

            counts['line'] += 1
            counts['char'] += len(line)

            for word in line.split():
                if word:
                    counts['word'] += 1

                if word.isdigit() or re.match(r"^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([EeQqDd^]([+-]?\d+))?$", word):
                    counts['integer'] += 1
                    counts['all_numbers'] += 1

    return counts


def print_file_statistics(file_path, counts, options):
    print("\nFile: ", file_path, " -- lines: ", counts['line'], ", words: ", counts['word'], ", characters: ",
          counts['char'], end=" ")

    if options['i']:
        print(", integers: ", counts['integer'], end=" ")

    if options['d']:
        print(", all numbers: ", counts['all_numbers'], end=" ")

    print()


def main():
    options = {'d': False, 'i': False, 'e': False}
    files_nr = 0
    w_counts = {
        'word': 0,
        'line': 0,
        'char': 0,
        'integer': 0,
        'all_numbers': 0
    }

    for arg in sys.argv[1:]:
        if arg.startswith('-'):
            if arg == '-d':
                options['d'] = True
            elif arg == '-i':
                options['i'] = True
            elif arg == '-e':
                options['e'] = True
        else:
            files_nr += 1

    for file_index in range(1, len(sys.argv)):
        if not sys.argv[file_index].startswith('-'):
            counts = process_file(sys.argv[file_index], options)

            for key in w_counts:
                w_counts[key] += counts[key]

            print_file_statistics(sys.argv[file_index], counts, options)

    if files_nr > 1:
        print("\nALL FILES -- lines: ", w_counts['line'], ", words: ", w_counts['word'], ", characters: ",
              w_counts['char'], end=" ")

        if options['i']:
            print(", integers: ", w_counts['integer'], end=" ")

        if options['d']:
            print(", all numbers: ", w_counts['all_numbers'], end=" ")

    print()


if __name__ == "__main__":
    main()
