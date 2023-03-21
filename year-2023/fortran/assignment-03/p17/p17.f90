program p17
    implicit NONE
    real a, b, c, x, y, z, f1
    data c / 5./

    f1(x, y) = a + b * x**2 + C * y
    a = 1
    b = 2
    z = f1(2., 2.)
    print *, 'f1(2.,2.) =', z
    z = f1(b, b)
    print *, 'f1(b ‚b) =', z
    z = f2(2., 2.)
    print *, 'f2(2.,2.) =', z
    z = f2(b, b)
    print *, 'f2(b ,b) =', z

contains
    function f2(x, y)
        real x, y, f2
        f2 = a + b * x**2 + c * y
        return
    end function f2

end program p17