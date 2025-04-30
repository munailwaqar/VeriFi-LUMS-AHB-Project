
FLIST="-f ./flist.f"
BASICFLAGS="-access +rwc -sv -disable_sem2009 -clean"
GUI="-gui"
DUT="./src/design.sv"
TOP="./sim/tb_ahb3liten.sv"

.PHONNY: all

run:
	xrun ${FLIST} ${DUT} ${TOP} ${BASICFLAGS} -logfile tb_ahb3liten_nobugs.log

assert_rst:
	xrun ${FLIST} ${DUT} ${TOP} ${BASICFLAGS} -logfile test_fifo_assert_rst.log -define assert_rst

deassert_rst:
	xrun ${FLIST} ${DUT} ${TOP} ${BASICFLAGS} -logfile test_fifo_deassert_rst.log -define deassert_rst

compile:
	./RUNME.sh
clean:
	rm -r jgproject
clean:
	@-rm -rf ./xcelium.d
	@-rm -rf ./*.shm
	@-rm ./*.log
	@-rm ./*.history
	@-rm ./*.key
	@-rm ./*.vcd
	@-rm -rf ./.simvision
	@-rm qalog.txt
	@-clear