module types
!  integer, parameter:: dp=kind(0.d0)
  integer, parameter :: sp = selected_real_kind(6)
  integer, parameter :: dp = selected_real_kind(15)
  integer, parameter :: qp = selected_real_kind(33)
  real(sp), parameter:: pi_sp = 4.0_sp*atan(1.0_sp)
  real(dp), parameter:: pi_dp = 4.0_dp*atan(1.0_dp)
  real(qp), parameter:: pi_qp = 4.0_qp*atan(1.0_qp)
end module
