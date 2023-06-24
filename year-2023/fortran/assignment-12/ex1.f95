program ex1
    implicit none

    integer, parameter :: years = 30
    real :: principal = 1000.0
    real :: interest_rate = 0.02
    real :: balance

    integer :: i

    balance = principal

    do i = 1, years
        balance = balance + (balance * interest_rate)
    end do

    print *, "Kwota końcowa:", balance

end program ex1
