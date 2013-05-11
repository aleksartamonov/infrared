CC = gfortran
OBJS = main.o trap.o constants.o subfun.o
MODS = constants_module.mod  integration_module.mod  prolate_subfun_module.mod
SRC = fortran_source
EXE = main
PLOTS = plotP.p plottau.p
all:	$(EXE)

$(EXE):	$(OBJS)
	$(CC) $(OBJS) -o $(EXE)
	

main.o: constants.o trap.o subfun.o $(SRC)/main.f95
	$(CC) -c $(SRC)/main.f95

subfun.o: constants.o trap.o $(SRC)/subfun.f95
	$(CC) -c $(SRC)/subfun.f95

trap.o: $(SRC)/trap.f95
	$(CC) -c $(SRC)/trap.f95

constants.o: $(SRC)/constants.f95
	$(CC) -c $(SRC)/constants.f95 

clean:
	rm -f $(OBJS) $(EXE) $(MODS)

# The '@' symbol at the start of a line suppresses output
run:	$(EXE)
	./$(EXE)

plot: $(PLOTS)
	gnuplot $(PLOTS)
	convert -density 300 ../plots/P-to-tau.eps ../plots/P-to-tau.jpg
	convert -density 300 ../plots/tau.eps ../plots/tau.jpg
