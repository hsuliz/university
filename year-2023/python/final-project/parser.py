import fileinput


class MatrixParser:

    @staticmethod
    def scan(file_path):
        matrix = []
        for line in fileinput.input(files=file_path):
            matrix.append([int(x) for x in line.split()])
        return matrix

    @staticmethod
    def write_to_file(matrix, file_name):
        with open(file_name, 'w') as f:
            for line in matrix:
                for number in line:
                    f.write(str(number))
                    f.write(' ')
                f.write('\n')
