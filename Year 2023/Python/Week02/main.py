word = "abcdefg"
line = "roses are red violets are blue"


def ex_10(x):
    print("Exercise 10:")
    print(len(x.split(" ")))


def ex_11(x, y):
    print("Exercise 11:")
    print('_'.join(map(str, y)))
    print('_'.join(map(str, x)))


def ex_12(x):
    pass


def ex_13(x):
    print("Exercise 13:")
    x = x.split(" ")
    out = 0
    for i in range(len(x)):
        out += len(x[i])
    print(out)


def ex_14(x):
    print("Exercise 14:")
    x = x.split(" ")
    print("Longest word:", max(x))
    print("With size of:", len(max(x)))


def ex_15(x):
    list_of_number = [1, 2, 3]
    pass


def ex_16():
    gvr = "GvR"
    _gvr = "Guido van Rossum"
    gvr = gvr.split(" ")
    _gvr = _gvr.split(" ")

    for i in range(3):
        gvr[i] = _gvr[i]

    print(gvr)


if __name__ == '__main__':
    ex_10(line)
    ex_11(word, "a")
    ex_13(line)
    ex_14(line)
    ex_16()
