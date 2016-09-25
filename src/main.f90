! This is a sample program to test mpi functionality in Fortran 90
program sample
  use mpi
  use mpi_declarations
  use types, only: dp, pi_sp, pi_dp, pi_qp
  use misc, only: myfun

  ! Integration-related initializations
  integer, parameter :: num_sections = 3
  real(dp) :: dx, x
  real(dp), parameter :: a = 0.0_dp, b = 1.0_dp
  real(dp) :: local_a, local_b

  call mpi_init(ierr)
  call mpi_comm_rank(mpi_comm_world, rank, ierr)
  call mpi_comm_size(mpi_comm_world, size, ierr)
  call mpi_get_processor_name(hostname, host_len, ierr)

!  call declare_all()

  call mpi_barrier(mpi_comm_world, ierr)


  dx = (b - a) / (real(size, dp) * real(num_sections, dp))
  local_a = a + real(rank, dp)/real(size, dp) * (b-a)
  local_b = real(rank+1, dp)/real(size, dp) * (b-a)

  write(6, *) dx, rank, local_a, local_b






  call mpi_finalize(ierr)

end program sample
