! This is a sample program to test mpi functionality in Fortran 90
program sample
  use mpi
  use types, only: dp, pi_sp, pi_dp, pi_qp
  use misc, only: myfun

  integer :: rank, ierr, size, host_len, partner
  integer :: status(mpi_status_size)
  character(len=100) :: greeting
  character(mpi_max_processor_name) :: hostname

  call mpi_init(ierr)

!  write(*,*) ierr, MPI_SUCCESS

  call mpi_comm_rank(mpi_comm_world, rank, ierr)
  call mpi_comm_size(mpi_comm_world, size, ierr)
  call mpi_get_processor_name(hostname, host_len, ierr)
!  write(*, *) hostname, host_len, ierr
!  stop

  if ( rank.eq.0 ) then
    write(*, *) myfun(0.0_dp), myfun(0.5_dp), myfun(1.0_dp)
  end if

  write(greeting, 100) rank, size, trim(hostname)

  if(rank.eq.0) then
    write(6, *) trim(greeting)
    do partner=1, size-1
!      call mpi_recv(greeting, 100, MPI_CHARACTER, partner, 1, mpi_comm_world, status, ierr)
      call mpi_recv(greeting, 100, MPI_CHARACTER, MPI_ANY_SOURCE, 1, mpi_comm_world, status, ierr)
      write(6, *) trim(greeting)
!      write(6, *) status(MPI_SOURCE)
    end do
  else
    call mpi_send(greeting, 100, MPI_CHARACTER, 0, 1, mpi_comm_world, ierr)
  end if

  if(rank.eq.0) then
    write(6, *) 'That`s all for now!'
  end if

  call mpi_finalize(ierr)

  100 format ('Hello World! I am rank ', I2, ' of size ', I2, ', running on ', a)

end program sample
