import numpy as np
import matplotlib.pyplot as plt

trapX = [-1, 0, 2, 3]
trapY = [0, 1 / 3, 1 / 3, 0]

params = {
    'bins': 100,
    'density': True
}


def dist_inverse(u):
    if u <= 1 / 6:
        return np.sqrt(6 * u) - 1
    elif u <= 5 / 6:
        return 3 * u - 1 / 2
    else:
        return 3 - np.sqrt(6 - 6 * u)


def generator_Brr(power):
    data = np.empty((10 ** power))
    for x in range(0, 10 ** power):
        data[x] = dist_inverse(np.random.uniform())
    return data


def plotter(name, data):
    fig = plt.figure(figsize=(6, 3), dpi=150)
    plt.title(name)
    plt.hist(data, **params)
    plt.plot(trapX, trapY)
    fig.savefig(name, dpi=200)
    print(name, "generated!!")


data_small = generator_Brr(3)
data_medium = generator_Brr(5)
data_big = generator_Brr(6)

plotter("Small random(1,000)", data_small)
plotter("Medium random(100,000)", data_medium)
plotter("Big random(1,000,000)", data_big)