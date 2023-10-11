PROGRAM p41
    USE funkcja_korzysta_z_procedury
    IMPLICIT NONE
    INTEGER, PARAMETER :: value = 789
    TYPE(new) :: exter
    INTEGER :: inter
    exter = module_function()
    PRINT *, "exter = ", exter
    inter = internal_function()
    PRINT *, "inter = ", inter

CONTAINS
    FUNCTION internal_function() RESULT(internal_function_r)
        INTEGER :: internal_function_r
        internal_function_r = value
    END FUNCTION internal_function
END PROGRAM p41