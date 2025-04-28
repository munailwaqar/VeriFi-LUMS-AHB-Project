# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2022.06
# platform  : Linux 3.10.0-1160.114.2.el7.x86_64
# version   : 2022.06 FCS 64 bits
# build date: 2022.06.22 13:46:24 UTC
# ----------------------------------------
# started   : 2025-04-28 13:13:41 PKT
# hostname  : pc4.(none)
# pid       : 5612
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:33489' '-style' 'windows' '-data' 'AAAAonicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpBkYvBhMGYwYLBgMGBwYkhkSGVIYUhnygKxUhmIgLmIoA5NWRKkCA8YHEJrBhhHEA2IhoKIcoCaQIj2GEqC2HJA8AHxUGME=' '-proj' '/home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/jgproject/.tmp/.initCmds.tcl' 'slave.tcl'
clear -all

# Analyze all design files explicitly (instead of using -f flist.f)
analyze -sv09 \
  /home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/include/ahb3lite_pkg.sv \
  /home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/src/design.sv \
  /home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/src/mem.sv \
  /home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/src/ahb3lite_if.sv \
  /home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/src/ahb3lite_test.sv \
  /home/ee5214s1m4/VeriFi-LUMS-AHB-Project-main/src/tb_ahb3liten.sv
include slave.tcl
include slave.tcl
include slave.tcl
