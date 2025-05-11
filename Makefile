FLIST = ./flist.f
BASICFLAGS = -access +rwc -sv -disable_sem2009 -clean
TOP = ./sim/tb_ahb3liten.sv
DUT = ./src/design.sv

.PHONY: all simulate gui run assert_rst deassert_rst compile clean help code_coverage functional_coverage

all: help

simulate:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc

gui:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc -gui

code_coverage:
	xrun -f $(FLIST)-access +rwc -covdut tb_ahb3liten -coverage all -covoverwrite -covfile ./covfile.ccf
	imc -load cov_work/scope/test/

functional_coverage:
	xrun -f $(FLIST) -access +rwc -covdut tb_ahb3liten -coverage all -covoverwrite -covfile ./covfile.ccf
	imc -load cov_work/scope/test/

run:
	xrun -f $(FLIST) $(DUT) $(TOP) $(BASICFLAGS) -logfile tb_ahb3liten_nobugs.log

assert_rst:
	xrun -f $(FLIST) $(DUT) $(TOP) $(BASICFLAGS) -logfile test_fifo_assert_rst.log -define assert_rst

deassert_rst:
	xrun -f $(FLIST) $(DUT) $(TOP) $(BASICFLAGS) -logfile test_fifo_deassert_rst.log -define deassert_rst

compile:
	./RUNME.sh

clean:
	rm -rf xrun* waves.shm .simvision xcelium.d xcelium.shm INCA* *.log *.key *.vcd cov_work jgproject ./*.history qalog.txt

help:
	@echo "Available targets:"
	@echo "simulate            ##Simulate without gui"
	@echo "gui                 ##Simulate with gui"
	@echo "run                 ##Run top-level testbench"
	@echo "assert_rst          ##Run test with assert_rst define"
	@echo "deassert_rst        ##Run test with deassert_rst define"
	@echo "compile             ##Run compile script"
	@echo "code_coverage       ##Run code coverage"
	@echo "functional_coverage ##Run functional coverage"
	@echo "clean               ##Remove all generated files"
	@echo "help                ##Print all available targets"

