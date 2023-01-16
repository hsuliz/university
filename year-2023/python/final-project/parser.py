import fileinput


class MatrixParser:

    @staticmethod
    def scan(file_path):
        matrix = []
        for line in fileinput.input(files=file_path):
            matrix.append([int(x) for x in line.split()])
        return matrix
