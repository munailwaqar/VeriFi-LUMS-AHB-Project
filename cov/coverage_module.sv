///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : coverage_module.sv
// Title : coverage_module
// Description : Covergroups and coverpoints are in this file
// Notes : 
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import ahb3lite_pkg::*;

module coverage_module(
    input logic HCLK,
    input logic HRESETn,
    ahb3lite_if.master bus1
  );

  timeunit 1ns;
  timeprecision 1ns;

////////////////////////////////////////////////////////////////////////Coverage of HTRANS 
covergroup HTRANS_covergroup @(posedge HCLK);
   option.per_instance = 1;
   option.cross_auto_bin_max = 0;
 coverpoint bus1.HTRANS {
   bins idle = {2'b00};
   bins bus1y = {2'b01};
   bins nonseq = {2'b10};
   bins seq = {2'b11};
  }
 coverpoint bus1.HREADY {
   bins ready = {1'b1};
   bins not_ready = {1'b0};
  }

 cross bus1.HTRANS, bus1.HREADY {
    //bus1 is idle and the slave is ready to accept a new transfer
   bins idle_ready = binsof(bus1.HTRANS.idle) && binsof(bus1.HREADY.ready);

    //bus1 is performing a non-sequential transfer and the slave is not ready to accept the transfer

   bins nonseq_not_ready = binsof(bus1.HTRANS.nonseq) && binsof(bus1.HREADY.not_ready);
   
  }
endgroup : HTRANS_covergroup
HTRANS_covergroup hc;




//////////////////////////////////////////////////////////////////////coverage of BURST type
covergroup BURST_covergroup @(posedge HCLK);
     option.per_instance = 1;
     option.cross_auto_bin_max = 0;
coverpoint bus1.HBURST{
  bins single_Burst = {3'b000};
  bins incr_undefine_length = {3'b001};
  bins wrap4 = {3'b010};
  bins incr4 = {3'b011};
  bins wrap8 = {3'b100};
  bins incr8 = {3'b101};
  bins wrap16 ={3'b110};
  bins incr16 ={3'b111};
}
coverpoint bus1.HTRANS {
   bins idle = {2'b00};
   bins bus1y = {2'b01};
   bins nonseq = {2'b10};
   bins seq = {2'b11};
  }
 cross bus1.HBURST, bus1.HTRANS {
   bins single_idle = binsof(bus1.HBURST.single_Burst) && binsof(bus1.HTRANS.idle);
   bins single_bus1y = binsof(bus1.HBURST.single_Burst) && binsof(bus1.HTRANS.bus1y);
   bins incr_wrap = binsof(bus1.HBURST.incr_undefine_length) && binsof(bus1.HTRANS.nonseq);
  }
endgroup : BURST_covergroup 
BURST_covergroup br;

///////////////////////////////////////////////////////////////////////coverage of response
covergroup response@(posedge HCLK);
        option.per_instance = 1;
        coverpoint bus1.HRESP{
  // bins HRESP_high = {1'b1};
  bins HRESP_low = {1'b0};
  }
endgroup : response
response rsp;

//////////////////////////////////////////////////////////////////////////////coverage of size 
covergroup size_covergroup @(posedge HCLK);
       option.per_instance = 1;
coverpoint bus1.HSIZE {
  bins size_byte = {3'b000};
  bins size_halfword = {3'b001};
  bins size_world = {3'b010};
  bins size_doubleword = {3'b011};
  bins size_4_word_line = {3'b100};
  bins size_8_word_line = {3'b101};
  bins size_512 = {3'b110};
  bins size_1024 ={3'b111};
  
  }
endgroup : size_covergroup
size_covergroup sg;


////////////////////////////////////////////////////////////////////////////////////// HPROT
covergroup HPROT_covergroup @(posedge HCLK);
       option.per_instance = 1;
  coverpoint bus1.HPROT {
    bins hprot_1={4'b0000}; //Non-cacheable, non-bufferable, user mode, opcode fetch
    bins hprot_2 = {4'b0001};//Non-cacheable, non-bufferable, user mode, data access
    bins hprot_3 = {4'b0010};//Non-cacheable, non-bufferable, privileged mode, opcode fetch
    bins hprot_4 = {4'b0011}; //Non-cacheable, non-bufferable, privileged, data access
     
  }
endgroup
HPROT_covergroup protect;
///////////////////////////////////////////////////////////////////////coverage of transfer status
covergroup transfer_status@(posedge HCLK);
        option.per_instance = 1;
 coverpoint bus1.HREADYOUT{
  bins hreadyout_high = {1'b1};
  bins hreadyout_low = {1'b0};
  }
endgroup : transfer_status
transfer_status Trs;
///////////////////////////////////////////////////////////////////////coverage of transfer status

covergroup previous_transfer_status@(posedge HCLK);
        option.per_instance = 1;
 coverpoint bus1.HREADYOUT{
  bins hreadyout_high = {1'b1};
  bins hreadyout_low = {1'b0};
  }
endgroup : previous_transfer_status
previous_transfer_status pts;

initial 
begin
hc=new;
br=new;
rsp=new;
sg=new;
protect=new;
Trs=new;
pts=new;
end

endmodule

