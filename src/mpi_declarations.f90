module mpi_declarations
  use mpi

  ! MPI-related initializations
  integer :: rank, ierr, size, host_len, partner
  integer :: status(mpi_status_size)
  character(len=100) :: greeting
  character(mpi_max_processor_name) :: hostname

contains
  subroutine declare_all()

    write(greeting, 100) rank, size, trim(hostname)

    if(rank.eq.0) then
      write(6, *) trim(greeting)
      do partner=1, size-1
        ! call mpi_recv(greeting, 100, mpi_character, mpi_any_source, 1, mpi_comm_world, status, ierr)
        call mpi_recv(greeting, 100, mpi_character, partner, 1, mpi_comm_world, status, ierr)
        write(6, *) trim(greeting)
      end do
    else
      call mpi_send(greeting, 100, mpi_character, 0, 1, mpi_comm_world, ierr)
    end if

    if(rank.eq.0) then
      write(6, *) 'That`s all for now!'
      write(6, *)
    end if

    100 format ('Hello World! I am rank ', I2, ' of size ', I2, ', running on ', a)

  end subroutine declare_all

end module mpi_declarations
