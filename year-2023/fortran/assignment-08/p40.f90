PROGRAM prog40
    USE moje_procedury_i_funkcje; IMPLICIT NONE
    REAL :: fahr
    CALL Input(fahr) !wywolanie procedury "Input", jej definicja jest udostepniona prez "USE ! nazwa modulu"
    CALL Output(fahr, Temp_C(fahr)) ! wywolanie procedury "Output", drugim argumentem ! aktualnym jest wartosc zwracana prez funkcje "Temp_C" - parametrami procedur moga byc funkcje !!!
    STOP;
END PROGRAM prog40