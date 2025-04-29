FLIST = ./flist.f
code_coverage:
	xrun -f $(FLIST)-access +rwc -covdut ahb3lite_test -coverage all -covoverwrite -covfile ./config.ccf
	imc -load cov_work/scope/test/
functional_coverage:
	xrun -f $(FLIST) -access +rwc -covdut ahb3lite_test -coverage all -covoverwrite -covfile ./config.ccf
	imc -load cov_work/scope/test/

simulate:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc

gui:
	xrun -f $(FLIST) -top tb_ahb3liten -access +rwc -gui

clean:
	rm -rf xrun* .simvision xcelium.d xcelium.shm INCA* *.log *.key *.vcd *.shm *.svwf


