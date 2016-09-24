! This is a sample program
program sample
  use mpi
  integer::ii_rank, ierr, size, partner

  call mpi_init(ierr)

  write(*,*) ierr, MPI_SUCCESS


  call mpi_comm_rank(MPI_COMM_WORLD, ii_rank, ierr)
  call mpi_comm_size(MPI_COMM_WORLD, size, ierr)


  write(*,100) ii_rank, size

  if(ii_rank.eq.0) then
    write(*,*) 'That`s all for now!'
  end if


  call mpi_finalize(ierr)

  100 format ('Hello World! I am rank ', I2, ' of size ', I2)

end program sample
