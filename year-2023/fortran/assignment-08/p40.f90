PROGRAM p40
    USE moje_procedury_i_funkcje; IMPLICIT NONE
    REAL :: fahr
    CALL Input(fahr)
    CALL Output(fahr, Temp_C(fahr))
    STOP;
END PROGRAM p40
