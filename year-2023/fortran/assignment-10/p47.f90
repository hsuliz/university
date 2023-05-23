module J11M
    implicit none
    public :: Calc
contains
    subroutine Calc(Z, Answer)
        real, intent(in), dimension(:) :: Z
        real, intent(out) :: Answer
        Answer = sum(Z ** 2)
        return
    end subroutine Calc
end module J11M

program p47
    use J11M
    implicit none
    character (len = 79) :: Buffer
    real, dimension (13) :: Z
    real :: Answer
    integer :: N, EoF
    open (unit = 1, file = "in_47.txt", status = "old", &
            action = "read", position = "rewind")
    N = 0
    do
        N = N + 1
        read (unit = 1, fmt = "(a79)", iostat = EoF) Buffer
        if (EoF /= 0) then
            exit
        else if (Buffer(1:1) == "C") then
            write (unit = *, fmt = *) Buffer(2:)
        else if (Buffer(1:1) == " ") then
            read (unit = Buffer, fmt = "(tr1, 13 f6.3)") Z
            write (unit = *, fmt = *) Z
            call Calc(Z, Answer)
            write (unit = *, fmt = *) Answer
        else
            write (unit = *, fmt = *) " Column 1 is not blank or C &
                    & at record number h", N
        end if
    end do
    stop
end program p47