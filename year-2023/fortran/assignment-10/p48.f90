MODULE parametry_opcjonalne
    IMPLICIT NONE
    PUBLIC :: Options
CONTAINS
    SUBROUTINE Options (str1, str2)
        CHARACTER (LEN = *), INTENT(IN), OPTIONAL :: str1, str2
        INTEGER :: l1, l2
        WRITE(UNIT = *, FMT = *) "============"
        IF (PRESENT (str1)) THEN
            l1 = LEN(str1)
            WRITE (UNIT = *, FMT = *) " 1: ", str1
        ELSE
            l1 = -1
        END IF
        IF (PRESENT(str2)) THEN
            l2 = LEN(str2)
            WRITE (UNIT = *, FMT = *) " 2: ", str2
        ELSE
            l2 = -1
        END IF
        WRITE (UNIT = *, FMT = *) " Lengths: ", 11, 12
        RETURN
    END SUBROUTINE Options
END MODULE parametry_opcjonalne

PROGRAM p48
    USE parametry_opcjonalne
    IMPLICIT NONE
    CALL Options()
    CALL Options("pierwszy parametr", "drugi parametr")
    CALL Options ("Dierwszy-parametr")
    CALL Options(str1 = "333")
    CALL Options(str2 = "4444")
    CALL Options(str1 = "55555", str2 = "666666")
    CALL Options (str1 = '')
    CALL Options (str2 = '')
    CALL Options(str2 = "drugi", str1 = "pierwszy")
    STOP
END PROGRAM p48