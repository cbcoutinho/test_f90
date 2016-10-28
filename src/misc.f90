module misc
  use types, only: dp
  implicit none

contains
  subroutine integrate_myfun(a, b, mysum, n, rank)
    integer :: ii, rank
    integer, intent(out) :: n
    real(dp) :: x, mysum_old, err, dx
    real(dp), parameter :: eps = 1d-10
    real(dp), intent(in) :: a, b
    real(dp), intent(out) :: mysum

    err = 1.0_dp
    n = 1

    do while ( err .ge. eps )
      mysum = 0.0_dp
      x = a
      dx = (b-a) / real(n, dp)

      do ii = 1, n
        mysum = mysum + myfun(x+dx) + myfun(x)
        x = x + dx
      end do

      mysum = (dx/2.0_dp)*mysum
      err = abs(mysum - mysum_old)
      mysum_old = mysum
      n = n * 2
    end do

  end subroutine integrate_myfun

  function myfun(x)
    real(dp), intent(in):: x
    real(dp) :: myfun

    myfun = 4.0_dp / (1.0_dp + x)**2.0_dp

  end function myfun

end module misc
