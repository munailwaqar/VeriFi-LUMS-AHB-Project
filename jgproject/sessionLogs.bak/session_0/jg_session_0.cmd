# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2022.06
# platform  : Linux 3.10.0-1160.114.2.el7.x86_64
# version   : 2022.06 FCS 64 bits
# build date: 2022.06.22 13:46:24 UTC
# ----------------------------------------
# started   : 2025-05-06 15:41:02 PKT
# hostname  : pc4.(none)
# pid       : 6852
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:46099' '-style' 'windows' '-data' 'AAAAnnicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpBkYvBhMGYwYLBgMGBwYkhkSGVIYUhnygKxUhmIgLmIoA5NWRKkCA8YHEJrBhhHEA2I+oFQpULkeQwlQSw5IDgAXSBf3' '-proj' '/home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/jgproject/.tmp/.initCmds.tcl' 'run.tcl'
clear -all
analyze -sv09 -f flist.f
elaborate -top tb_ahb3liten

clock HCLK            
reset ~HRESETn

visualize {1[*45]}
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
visualize -violation -property <embedded>::tb_ahb3liten.dut.BIND_UUT.check_write_enable_P -new_window
visualize -min_length [expr [visualize -get_length -window visualize:1] + 1] -window visualize:1; visualize -freeze [visualize -get_length -window visualize:1] -window visualize:1; visualize -replot -bg -window visualize:1
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
visualize -violation -property <embedded>::tb_ahb3liten.dut.BIND_UUT.check_write_enable_P -new_window
visualize -min_length [expr [visualize -get_length -window visualize:1] + 1] -window visualize:1; visualize -freeze [visualize -get_length -window visualize:1] -window visualize:1; visualize -replot -bg -window visualize:1
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
visualize -violation -property <embedded>::tb_ahb3liten.dut.BIND_UUT.check_write_enable_P -new_window
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
visualize -violation -property <embedded>::tb_ahb3liten.dut.BIND_UUT.check_write_enable_P -new_window
visualize -min_length [expr [visualize -get_length -window visualize:1] + 1] -window visualize:1; visualize -freeze [visualize -get_length -window visualize:1] -window visualize:1; visualize -replot -bg -window visualize:1
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
include /home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/run.tcl
prove -bg -all
