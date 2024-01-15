class Student:
    first_name = ''
    second_name = ''
    grades = list()


def open_file(file_name):
    with open(file_name) as file:
        return file.read()


def parse_file(file):
    parsed_file = list()

    students = file.split("\n")

    for student in students:
        split_student = student.split()
        student = Student()
        student.first_name = normalize_string(split_student[0])
        student.second_name = normalize_string(split_student[1])
        student.grades.append(split_student[2])
        parsed_file.append(student)
    return parsed_file


def normalize_string(string_to_normalize):
    x = string_to_normalize.lower()
    return x[0].upper() + x[1:]


if __name__ == '__main__':
    file_list = list()

    # for arg in sys.argv[1:]:
    #    file_list.append(arg)
    file_list.append("test.txt")
    data_base = {}

    for file_name in file_list:
        opened_file = open_file(file_name)
        data_base[file_name] = parse_file(opened_file)

    for i in range(4):
        print(data_base["test.txt"][i].first_name, end=" ")
        print(data_base["test.txt"][i].second_name, end=" ")
        print(data_base["test.txt"][i].grades)

