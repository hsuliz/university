program ex2
    implicit none
    integer, parameter :: N1 = 1
    integer, parameter :: N2 = 10
    integer :: suma

    suma = 0
    call ObliczSume(N1, suma)
    write(*, '(A, I0)') "Suma liczb od ", N1, " do ", N2, ": ", suma

contains

    recursive subroutine ObliczSume(n, acc)
        implicit none
        integer, intent(in) :: n
        integer, intent(inout) :: acc

        if (n <= N2) then
            acc = acc + n
            call ObliczSume(n + 1, acc)
        end if
    end subroutine ObliczSume

end program ex2
