#!/usr/bin/python3
# Hlib-Oleksandr Suliz, Script Language, group no.2


import os
import sys


def count_pattern_occurrences(directory, patterns):
    pattern_counts = {}
    error_files = []

    for root, _, files in os.walk(directory):
        for filename in files:
            file_path = os.path.join(root, filename)
            try:
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                    content = file.read()
                    for pattern in patterns:
                        count = content.count(pattern)
                        if count > 0:
                            if file_path not in pattern_counts:
                                pattern_counts[file_path] = {}
                            if pattern not in pattern_counts[file_path]:
                                pattern_counts[file_path][pattern] = 0
                            pattern_counts[file_path][pattern] += count
            except PermissionError:
                error_files.append(file_path)

    return pattern_counts, error_files


def main():
    directories = []
    patterns = []

    i = 1
    while i < len(sys.argv):
        if sys.argv[i] == "-d":
            i += 1
            if i < len(sys.argv):
                directories.append(sys.argv[i])
            else:
                print("Missing directory argument after -d option.")
                return
        else:
            patterns.append(sys.argv[i])
        i += 1

    if not directories:
        print("No directories specified. Use -d option to specify at least one directory.")
        return

    for directory in directories:
        pattern_counts, error_files = count_pattern_occurrences(directory, patterns)
        for file_path, pattern_count in pattern_counts.items():
            for pattern, count in pattern_count.items():
                print(f"{file_path}: {count} {pattern} occurrences")


if __name__ == "__main__":
    main()
