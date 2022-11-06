import numpy as np
from numpy import linalg as LA

# data stuff

# matrix
my_matrix = np.array([
    [
        [2.40827208, -0.36066254, 0.80575445, 0.46309511, 1.20708553],
        [-0.36066254, 1.14839502, 0.02576113, 0.02672584, -1.03949556],
        [0.80575445, 0.02576113, 2.45964907, 0.13824088, 0.0472749],
        [0.46309511, 0.02672584, 0.13824088, 2.05614464, -0.9434493],
        [1.20708553, -1.03949556, 0.0472749, -0.9434493, 1.92753926],
    ],
    [
        [2.61370745, -0.6334453, 0.76061329, 0.24938964, 0.82783473],
        [-0.6334453, 1.51060349, 0.08570081, 0.31048984, -0.53591589],
        [0.76061329, 0.08570081, 2.46956812, 0.18519926, 0.13060923],
        [0.24938964, 0.31048984, 0.18519926, 2.27845311, -0.54893124],
        [0.82783473, -0.53591589, 0.13060923, -0.54893124, 2.6276678],
    ]
])

# vector B
vectorB = np.array([5.40780228, 3.67008677, 3.12306266, -1.11187948, 0.54437218])
# vector B'
vectorB_prim = vectorB + np.array([10 ** -5, 0, 0, 0, 0])


def calculatingDude(my_i):
    print("=== FOR A", my_i + 1, " MATRIX ===", sep='')
    y = LA.solve(my_matrix[my_i], vectorB)
    print("y is:", y)
    y_prim = np.linalg.solve(my_matrix[my_i], vectorB_prim)
    print("y prim is:", y_prim)
    delta = LA.norm(y - y_prim)
    print("delta is:", delta)
    # idk what is this
    cond = LA.cond(my_matrix[my_i])
    print(cond)


# MAIN
for i in range(2):
    calculatingDude(i)
