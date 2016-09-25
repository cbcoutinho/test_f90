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
objects=$(OBJ)/types.o


$(BIN)/main: $(OBJ)/main.o $(objects)
	$(FF) $(FFlags) -o $@ $+ $(FLIBS)
$(OBJ)/main.o: $(SRC)/main.f90 $(objects)
	$(FF) $(FFlags) -I$(OBJ) -c -o $@ $<
$(OBJ)/types.o: $(SRC)/types.f90
	$(FF) $(FFlags) -J$(OBJ) -c -o $@ $<
clean:
	-rm $(OBJ)/*.o $(OBJ)/*.mod $(BIN)/main
