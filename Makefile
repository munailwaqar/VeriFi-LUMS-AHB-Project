FLIST = ./flist.f

.PHONY = all simulate gui clean help

all: help

simulate:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc

gui:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc -gui

clean:
	rm -rf xrun* waves.shm .simvision xcelium.d xcelium.shm INCA* *.log *.key *.vcd

help:
	@echo "Available targets:"
	@echo "simulate  ##Simulate without gui"
	@echo "gui       ##Simulate with gui"
	@echo "clean     ##Remove all generated files"
	@echo "help      ##Print all available targets"
