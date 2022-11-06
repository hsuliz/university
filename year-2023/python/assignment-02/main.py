word = "abcdefg"
line = """Roses are red violets are blue"""


def ex_10(x):
    print("Exercise 10:")
    print(len(x.split(" ")))


def ex_11(x, y):
    print("Exercise 11:")
    print('_'.join(map(str, y)))
    print('_'.join(map(str, x)))


def ex_12(x):
    print("Exercise 12:")
    a = "".join(x[0] for x in x.split())
    b = "".join(x[-1] for x in x.split())
    print(a)
    print(b)


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


def ex_15():
    print("Exercise 15:")
    list_of_number = [i + 1 for i in range(5)]
    out_string = "".join(str(n) for n in list_of_number)
    print(out_string)


def ex_16():
    print("Exercise 16:")
    in_string = "W tekście znajdującym się w zmiennej line zamienić ciąg znaków GvR na Guido van Rossum."
    out_string = in_string.replace("GvR", "Guido van Rossum")
    print(out_string)


def ex_17():
    print("Exercise 17:")
    x = line.split(" ")
    for i in range(len(x)):
        x[i] = x[i].lower()
    by_alph = sorted(x)
    print(by_alph)
    by_len = sorted(x, key=len)
    print(by_len)


def ex_18():
    print("Exercise 18:")
    # must be 21
    x = 1000000000000000000011100
    y = str(x)
    print(y.count('0'))


def ex_19():
    print("Exercise 19:")
    arr = [1, 2, 33, 44, 555, 666]

    for i in range(len(arr)):
        print(str(arr[i]).zfill(3))


if __name__ == '__main__':
    ex_10(line)
    ex_11(word, "a")
    ex_12(line)
    ex_13(line)
    ex_14(line)
    ex_15()
    ex_16()
    ex_17()
    ex_18()
    ex_19()
