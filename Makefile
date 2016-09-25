# makefile: makes the adFE2D program

current_dir = $(shell pwd)
SRC=$(current_dir)/src
OBJ=$(current_dir)/obj
BIN=$(current_dir)/bin

# Compiler
FF = mpifort
#FFlags = -Wall -fbounds-check
#FLIBS = -lblas -llapack

# Extra object files required by main program
objects=$(OBJ)/types.o $(OBJ)/misc.o $(OBJ)/mpi_declarations.o

$(BIN)/main: $(OBJ)/main.o $(objects)
	$(FF) $(FFlags) -o $@ $+ $(FLIBS)
$(OBJ)/main.o: $(SRC)/main.f90 $(objects)
	$(FF) $(FFlags) -I$(OBJ) -c -o $@ $<
$(OBJ)/misc.o: $(SRC)/misc.f90 $(OBJ)/types.o
	$(FF) $(FFlags) -J$(OBJ) -c -o $@ $<
$(OBJ)/mpi_declarations.o: $(SRC)/mpi_declarations.f90
	$(FF) $(FFlags) -J$(OBJ) -c -o $@ $<
$(OBJ)/types.o: $(SRC)/types.f90
	$(FF) $(FFlags) -J$(OBJ) -c -o $@ $<
clean:
	rm -f $(OBJ)/*.o $(OBJ)/*.mod $(BIN)/main
run: $(BIN)/main
	mpiexec $(BIN)/main
