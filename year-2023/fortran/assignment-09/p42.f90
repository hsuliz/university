PROGRAM p42
    IMPLICIT NONE
    REAL :: a, b, c
    WRITE (UNIT = *, FMT = *) " please enter three numbers to be sorted."
    READ (UNIT = *, FMT = *) a, b, c
    WRITE (UNIT = *, FMT = *) " thank you. you have entered: ", a, b, c
    IF (A > B) CALL SWAP(A, B)
    IF (A > C) CALL SWAP(A, C)
    IF (B > C) CALL SWAP (B, C)
    WRITE (UNIT = *, FMT = *) " the numbers in increasing order are:", a, b, c
    STOP
CONTAINS
    SUBROUTINE swap(x, y)
        REAL, INTENT(INOUT) :: x, y
        REAL :: aux
        aux = x
        y = aux
        RETURN
    END SUBROUTINE swap
END PROGRAM p42