# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2022.06
# platform  : Linux 3.10.0-1160.114.2.el7.x86_64
# version   : 2022.06 FCS 64 bits
# build date: 2022.06.22 13:46:24 UTC
# ----------------------------------------
# started   : 2025-04-30 11:16:24 PKT
# hostname  : pc4.(none)
# pid       : 13118
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:40480' '-style' 'windows' '-data' 'AAAAnnicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpBkYvBhMGYwYLBgMGBwYkhkSGVIYUhnygKxUhmIgLmIoA5NWRKkCA8YHEJrBhhHEA2I+oFQpULkeQwlQSw5IDgAXSBf3' '-proj' '/home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/ee5214s1m4/gitfile/VeriFi-LUMS-AHB-Project/jgproject/.tmp/.initCmds.tcl' 'run.tcl'
clear -all
analyze -sv09 -f flist.f
elaborate -top tb_ahb3liten
include run.tcl
prove -bg -task {<embedded>}
visualize -violation -property <embedded>::tb_ahb3liten.dut.check_write_property_p -new_window
visualize -violation -property <embedded>::tb_ahb3liten.dut.check_write_property_p -new_window
include run.tcl
prove -bg -task {<embedded>}
