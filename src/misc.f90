module misc
  use types, only: dp

contains
  function myfun(x)
    real(dp), intent(in):: x
    real(dp) :: myfun

    myfun = 4.0_dp / (1.0_dp + x)**2.0_dp

  end function myfun

end module misc
