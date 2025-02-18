import numpy as np
from matplotlib import pyplot as plt


def poisson(x):
    q = np.exp(-x)
    k = 0
    s = q
    p = q
    u = np.random.uniform()
    while u > s:
        k += 1
        p *= x / k
        s += p
    return k


def poisson_for_y(x, k):
    return np.exp(-x) * (x ** k) / np.math.factorial(k)


fig, ax1 = plt.subplots(1, 1)

# Poisson gen
data = [poisson(4) for _ in range(0, 10 ** 4)]
ax1.set_title("For k = 10000")

# incorrect drawing
# r = range(1, 12)
# correct:
r = range(0, 12)

bins = [x - 0.5 for x in r]
ax1.hist(data, density=True, bins=bins)

# based Poisson
basedX = [x for x in r]
basedY = [poisson_for_y(4, x) for x in r]
ax1.plot(basedX, basedY, linestyle='--', marker='.', color='red')
print("GENERATED!!\n File name result.png")
fig.savefig("result.png")
