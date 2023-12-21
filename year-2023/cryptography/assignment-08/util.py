import numpy as np


def inv(d, n):
    if np.isnan(d) or d == 0:
        return float('nan')

    x, prev_x = 1, 0
    y, prev_y = 0, 1

    while n != 0:
        quotient = d // n
        x, prev_x = prev_x, x - quotient * prev_x
        y, prev_y = prev_y, y - quotient * prev_y
        d, n = n, d % n

    x += prev_x if x < 0 else 0

    if d > 1:
        return float('nan')

    return x