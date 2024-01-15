import sys
import os
import re

def parse_score(score_str):
    # Funkcja do parsowania ocen z uwzględnieniem różnych formatów
    # Przyjmuje napis zawierający ocenę i zwraca wartość liczbową
    # uwzględniając poprawki o 0.25 w górę i w dół
    score = float(score_str)
    if score.is_integer():
        return score
    else:
        return round(score * 4) / 4

def generate_summary(filename):
    # Funkcja generująca podsumowanie z danego pliku
    # Tworzy tabelkę z posortowaną alfabetycznie listą
    # oraz liczy średnią ocen
    summary = {}
    total_score = 0
    total_count = 0

    try:
        with open(filename, 'r') as file:
            for line in file:
                line = line.strip()
                parts = line.split()

                if len(parts) < 3:
                    sys.stderr.write(f"Ignoring invalid line: {line}\n")
                    continue

                name = parts[1] + ' ' + parts[0]
                score = parse_score(parts[2])

                if name not in summary:
                    summary[name] = {'scores': [], 'average': 0}

                summary[name]['scores'].append(score)
                total_score += score
                total_count += 1

        for name, data in summary.items():
            scores = data['scores']
            average = round(sum(scores) / len(scores), 2)
            data['average'] = average

        sorted_summary = sorted(summary.items(), key=lambda x: x[0].lower())

        output_filename = os.path.splitext(filename)[0] + '.oceny'
        with open(output_filename, 'w') as output_file:
            for name, data in sorted_summary:
                output_file.write(f"{name}: Lista ocen: {data['scores']} średnia: {data['average']}\n")

        total_average = round(total_score / total_count, 2)
        return total_average

    except FileNotFoundError:
        sys.stderr.write(f"File not found: {filename}\n")
        return None

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py file1.txt [file2.txt ...]")
        sys.exit(1)

    total_averages = []
    for filename in sys.argv[1:]:
        average = generate_summary(filename)
        if average is not None:
            total_averages.append(average)

    if total_averages:
        total_average = round(sum(total_averages) / len(total_averages), 2)
        print(f"Total average for all files: {total_average}")
