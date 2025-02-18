Zeby uruchomić program, proszę wpisać:
make
./ex2

Operacje dominujące:

    insert:
        while (index >= arraySize)
    
    remove:
        for (int i = index; i <= elementsIn + 1; ++i)

    retrieve:
        return data[index - 1]

    locate:
        for (int i = 0; i <= elementsIn; ++i)

    end:
        return elementsIn + 1
    
    first:
        return 0

    next:
        return data[index + 1]
    
    previous:
        data[index - 1]

    last:
        return elementsIn

    back:
        return data[elementsIn - 1]

    push_front:
        for (int i = 0; i < elementsIn + 1; ++i)

    push_back:
        for (int i = 0; i < elementsIn; ++i)

    pop_front:
        for (int i = 1; i < elementsIn; ++i)

    pop_back:
        for (int i = 0; i < elementsIn - 1; ++i)

    elementDestr:
        for (int i = 0; i <= elementsIn; ++i)

    reverseArray:
        for (int low = 0, high = n; low <= high; low++, high--)