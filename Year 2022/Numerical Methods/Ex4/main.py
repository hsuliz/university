N = 50

matrixUp = 7
matrixDown = 9
u = 1
vectorB = 5

q = [0 for _ in range(N)]
z = [0 for _ in range(N)]
y = [0 for _ in range(N)]


def solvQ():
    q[N - 1] = u / matrixDown
    for x in range(N - 2, -1, -1):
        q[x] = (u - matrixUp * q[x + 1]) / matrixDown


def solveZ():
    z[N - 1] = vectorB / matrixDown
    for x in range(N - 2, -1, -1):
        z[x] = (vectorB - matrixUp * z[x + 1]) / matrixDown


def solveA():
    sumZ = 0
    sumQ = 0
    for x in range(N):
        sumZ += z[x]
        sumQ += q[x]
    sumQ += 1
    trans = sumZ / sumQ
    for x in range(N):
        y[x] = z[x] - (trans * q[x])
    print("y = ", y)


solveZ()
solvQ()
solveA()
