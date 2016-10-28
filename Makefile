# makefile: makes the adFE2D program

current_dir = $(shell pwd)
SRC=$(current_dir)/src
OBJ=$(current_dir)/obj
BIN=$(current_dir)/bin

# Compiler
FF = mpifort
FFlags = -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -g -fcheck=all -fbacktrace
# FFlags = -Wall -Wextra -Wimplicit-interface -fPIC -Werror -fmax-errors=1 -O3 -march=native -ffast-math -funroll-loops
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
	mpiexec -np 4 $(BIN)/main
