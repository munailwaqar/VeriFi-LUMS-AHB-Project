FLIST = ./flist.f

.PHONY = all simulate gui clean help

all: help

simulate:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc

gui:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc -gui

clean:
	rm -rf xrun* waves.shm .simvision xcelium.d xcelium.shm INCA* *.log *.key *.vcd cov_work 

help:
	@echo "Available targets:"
	@echo "simulate  ##Simulate without gui"
	@echo "gui       ##Simulate with gui"
	@echo "clean     ##Remove all generated files"
	@echo "help      ##Print all available targets"
code_coverage:
	xrun -f $(FLIST)-access +rwc -covdut ahb3liten -coverage all -covoverwrite -covfile ./covfile.ccf
	imc -load cov_work/scope/test/

functional_coverage:
	xrun -f $(FLIST) -access +rwc -covdut ahb3liten -coverage all -covoverwrite -covfile ./covfile.ccf
	imc -load cov_work/scope/test/