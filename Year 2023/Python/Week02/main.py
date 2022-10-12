def ex10():
    print("Exercise 10:")
    word = """
            li 
            n
             e  
             """
    count = 0

    for character in word:
        count += 1
    print(count)


def ex11():
    print("Exercise 11:")
    word = "word"
    print('_'.join(map(str, word)))


def ex12():
    print("Exercise 12:")


if __name__ == '__main__':
    ex10()
    ex11()
