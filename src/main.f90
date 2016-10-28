! This is a sample program to test mpi functionality in Fortran 90
program sample
  use mpi
  use mpi_declarations
  use types, only: dp
  use misc, only: myfun, integrate_myfun

  ! Integration-related initializations
  real(dp) :: local_sum, mysum
  real(dp), parameter :: a = 0.0_dp, b = 1.0_dp
  real(dp) :: local_a, local_b

  call mpi_init(ierr)
  call mpi_comm_rank(mpi_comm_world, rank, ierr)
  call mpi_comm_size(mpi_comm_world, size, ierr)
  call mpi_get_processor_name(hostname, host_len, ierr)

  call declare_all()
  call mpi_barrier(mpi_comm_world, ierr)

  local_a = a + real(rank, dp)/real(size, dp) * (b-a)
  local_b = a + real(rank+1, dp)/real(size, dp) * (b-a)

  call integrate_myfun(local_a, local_b, local_sum, n, rank)
  ! write(6, *) rank, local_a, local_b, local_sum, n

  call mpi_reduce(local_sum, mysum, 1, mpi_double_precision, mpi_sum, 0, mpi_comm_world, ierr)

  if ( rank.eq.0 ) then
    write(6, *) mysum
  end if

  call mpi_finalize(ierr)

end program sample
