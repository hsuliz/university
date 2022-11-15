def add_frac(frac1: list, frac2: list):
    if denominator_check(frac1, frac2):
        return -1
    elif frac1[1] == frac2[1]:
        return [frac1[0] + frac2[0], frac2[1]]
    else:
        out = [None] * 2
        out[1] = frac1[1] * frac2[1]
        out[0] = frac1[1] * frac2[0] + frac1[0] * frac2[1]
        return out


def sub_frac(frac1: list, frac2: list):
    if denominator_check(frac1, frac2):
        return -1
    elif frac1[1] == frac2[1]:
        return [frac1[0] - frac2[0], frac2[1]]
    else:
        out = [None] * 2
        out[1] = frac1[1] * frac2[1]
        out[0] = frac1[0] * frac2[1] - frac1[1] * frac2[0]
        return out


def mul_frac(frac1: list, frac2: list):
    if denominator_check(frac1, frac2):
        return -1
    else:
        return [frac1[0] * frac2[0], frac1[1] * frac2[1]]


def div_frac(frac1: list, frac2: list):
    if denominator_check(frac1, frac2):
        return -1
    else:
        return [frac1[0] * frac2[1], frac1[1] * frac2[0]]


def is_positive(frac): pass


def is_zero(frac): pass


def cmp_frac(frac1, frac2): pass


def frac2float(frac): pass


def denominator_check(frac1, frac2):
    return frac1[1] == 0 or frac2[1] == 0
