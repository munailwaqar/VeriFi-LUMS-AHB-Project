FLIST = ./flist.f

simulate:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc -gui

clean:
	rm -rf xrun* .simvision xcelium.d xcelium.shm INCA* *.log *.key *.vcd
