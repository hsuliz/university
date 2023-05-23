MODULE zawiera_funkcje_rekursywna
    IMPLICIT NONE
    PUBLIC :: Euclid
CONTAINS
    RECURSIVE FUNCTION Euclid(i1, i2) RESULT(gcd)
        INTEGER, INTENT(IN) :: i1, i2
        INTEGER :: gcd
        INTEGER :: remainder
        remainder = MOD(i1, i2)
        IF (remainder == 0) THEN
            gcd = i2
            RETURN
        ELSE
            gcd = Euclid(i2, remainder)
        END IF
        WRITE(*, FMT = 897) i1, i2, remainder, gcd
        897 FORMAT ('reszta z azielenia liczby =', i6, 2X, 'przez licabe =', i4, 2x, 'daje reszte = ', &
                i4, 2X, 'RESULT = ', i4)
        RETURN
    END FUNCTION Euclid
END MODULE zawiera_funkcje_rekursywna

PROGRAM p_46
    USE zawiera_funkcje_rekursywna
    IMPLICIT NONE
    INTEGER :: p, q
    PRINT *, 'wrowadz liczbe naturalna do dzielenia "p"'
    READ (UNIT = *, FMT = *) p
    PRINT *, 'wrowadz dzielnik "q"'
    READ (UNIT = *, FMT = *) q
    PRINT *, Euclid(p, q), 'to najwiekszy wspolny podzielnik zwracany przez&
            $ Euclid( P, 9)'
    STOP
END PROGRAM p_46