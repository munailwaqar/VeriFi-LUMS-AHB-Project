SIM_DEFINES += -define include_clk
FORMAL_DEFINES +=
FLIST = ./flist.f
BASICFLAGS = -access +rwc -sv -disable_sem2009 -clean
TOP = ./sim/tb_ahb3liten.sv
DUT = ./src/design.sv

.PHONY: all simulate gui run assert_rst deassert_rst compile clean help code_coverage functional_coverage

all: help

simulate:
	xrun -f $(FLIST) $(SIM_DEFINES) -top tb_ahb3liten -access +rwc

gui:
	xrun -f $(FLIST) $(SIM_DEFINES) -top tb_ahb3liten -access +rwc -gui

coverage:
	xrun -f $(FLIST) $(SIM_DEFINES) -access +rwc -covdut tb_ahb3liten -coverage all -covoverwrite -covfile ./covfile.ccf
	imc -load cov_work/scope/test/

formal:
	./RUNME.sh

clean:
	rm -rf xrun* waves.shm .simvision xcelium.d xcelium.shm INCA* *.log *.key *.vcd cov_work jgproject ./*.history qalog.txt

help:
	@echo "Available targets:"
	@echo "simulate            ##Simulate without gui"
	@echo "gui                 ##Simulate with gui"
	@echo "formal              ##Run formal verification"
	@echo "coverage            ##Run coverage"
	@echo "clean               ##Remove all generated files"
	@echo "help                ##Print all available targets"

