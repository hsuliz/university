N = 100

# matrix
matrix = [
    [0.2 for _ in range(0, N - 1)],
    [1.2 for _ in range(0, N)],
    [0.1 / (n + 1) for n in range(0, N - 1)],
    [0.4 / (n + 1) ** 2 for n in range(0, N - 2)]
]

lower = [
    [0 for _ in range(0, N - 1)],
    [1 for _ in range(0, N)]
]

upper = [
    [0 for _ in range(0, N)],
    [0 for _ in range(0, N - 1)],
    [0 for _ in range(0, N - 2)]

]


def detMatrix():
    sum = 1
    for i in range(N):
        sum *= upper[0][i]
    print("Det is:\n", sum)


def luDecomp():
    for x in range(N):
        # upper
        for i in range(x, x + 3):

            if x == 0:
                upper[i][0] = matrix[i + 1][0]

            else:
                diff = i - x
                if diff == 0:
                    upper[diff][i] = matrix[1][x] - (lower[0][x - 1] * upper[1][x - 1])

                if diff == 1 and x < N - 1:
                    upper[diff][i - 1] = matrix[2][x] - (lower[0][x - 1] * upper[2][x - 1])

                if diff == 2 and x < N - 2:
                    upper[diff][i - 2] = matrix[3][x]

                # print("Upper", upper)
        # lower
        for j in range(x, x + 1):
            if x == 0:
                lower[0][0] = matrix[0][1] / upper[0][0]
            elif x < N - 1:
                lower[0][x] = matrix[0][x] / upper[0][x]
                # print("Lower")


y = [0 for _ in range(N)]
b = [0 for _ in range(N)]
vector = [x for x in range(1, N + 1)]


def forwardAndBack():
    # forward
    b[0] = 1
    dude = 0
    for x in range(1, N):
        b[x] = vector[x] - lower[0][x - 1] * b[x - 1]

    # backward
    y[99] = b[99] / upper[0][99]
    for x in range(99, -1, -1):
        if x == 99:
            y[x] = b[x] / upper[0][99]
            continue
        if x == 98:
            y[x] = (b[x] - upper[1][x] * y[99]) / upper[0][98]
            continue
        y[x] = (b[x] - upper[1][x] * y[x+1] - upper[2][x] * y[x+2]) / upper[0][x]
    print()
    print("y is: ")
    print(y)


luDecomp()

print("Upper")
for i in range(3):
    print(upper[i])

print("Lower")
for i in range(2):
    print(lower[i])

forwardAndBack()
detMatrix()