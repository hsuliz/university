PROGRAM ex4
    IMPLICIT NONE
    INTEGER, PARAMETER :: idp = SELECTED_INT_KIND(15)
    REAL :: a, b, krok, x, fx, fx_next
    INTEGER(KIND = idp) :: i, ilosc_pierwiastkow
    REAL, DIMENSION(:), ALLOCATABLE :: pierwiastki

    a = -3.0
    b = 4.0
    krok = 0.001

    ilosc_pierwiastkow = 0
    ALLOCATE(pierwiastki(7000))

    DO i = 1, 7000
        x = a + REAL(i-1) * krok
        fx = funkcja(x)
        fx_next = funkcja(x + krok)

        IF (SIGN(1.0, fx) /= SIGN(1.0, fx_next)) THEN
            ilosc_pierwiastkow = ilosc_pierwiastkow + 1
            pierwiastki(ilosc_pierwiastkow) = x + krok/2
        END IF
    END DO

    PRINT *, "Znalezione pierwiastki:"
    DO i = 1, ilosc_pierwiastkow
        PRINT *, pierwiastki(i)
    END DO

    DEALLOCATE(pierwiastki)

CONTAINS
    FUNCTION funkcja(x)
        REAL, INTENT(IN) :: x
        REAL :: funkcja

        funkcja = x**3 - 3*x**2 - 4*x + 12
    END FUNCTION funkcja

END PROGRAM ex4
