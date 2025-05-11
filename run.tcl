clear -all
analyze -sv09 -f flist.f
elaborate -top tb_ahb3liten

clock HCLK            
reset ~HRESETn

visualize {1[*45]}
