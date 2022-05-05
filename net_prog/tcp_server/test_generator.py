def tester():
    with open('test/test_1.txt', 'w') as file:
        file.write('2,2\r\n723 -15 22\r\n9 11 4\r\n7 0.5\r\n2 2\r\n')


def main():
    tester()


if __name__ == '__main__':
    main()
