///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : coverage_module.sv
// Title : coverage_module
// Description : Covergroups and coverpoints are in this file
// Notes : 
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import ahb3lite_pkg::*;

module coverage_module(ahb3lite_if.master bus11);

  timeunit 1ns;
  timeprecision 1ns;

////////////////////////////////////////////////////////////////////////Coverage of HTRANS 
covergroup HTRANS_covergroup @(posedge bus1.HCLK);
   option.per_instance = 1;

 coverpoint bus1.cb.HTRANS {
   bins idle = {2'b00};
   bins bus1y = {2'b01};
   bins nonseq = {2'b10};
   bins seq = {2'b11};
  }
 coverpoint bus1.cb.HREADY {
   bins ready = {1'b1};
   bins not_ready = {1'b0};
  }

 cross bus1.cb.HTRANS, bus1.cb.HREADY {
    //bus1 is idle and the slave is ready to accept a new transfer
   bins idle_ready = binsof(bus1.cb.HTRANS.idle) && binsof(bus1.cb.HREADY.ready);

    //bus1 is performing a non-sequential transfer and the slave is not ready to accept the transfer

   bins nonseq_not_ready = binsof(bus1.cb.HTRANS.nonseq) && binsof(bus1.cb.HREADY.not_ready);
  }
endgroup : HTRANS_covergroup
HTRANS_covergroup hc;




//////////////////////////////////////////////////////////////////////coverage of BURST type
covergroup BURST_covergroup @(posedge bus1.HCLK);
     option.per_instance = 1;
coverpoint bus1.cb.HBURST{
  bins single_Burst = {3'b000};
  bins incr_undefine_length = {3'b001};
  bins wrap4 = {3'b010};
  bins incr4 = {3'b011};
  bins wrap8 = {3'b100};
  bins incr8 = {3'b101};
  bins wrap16 ={3'b110};
  bins incr16 ={3'b111};
}
coverpoint bus1.cb.HTRANS {
   bins idle = {2'b00};
   bins bus1y = {2'b01};
   bins nonseq = {2'b10};
   bins seq = {2'b11};
  }
 cross bus1.cb.HBURST, bus1.cb.HTRANS {
   bins single_idle = binsof(bus1.cb.HBURST.single_Burst) && binsof(bus1.cb.HTRANS.idle);
   bins single_bus1y = binsof(bus1.cb.HBURST.single_Burst) && binsof(bus1.cb.HTRANS.bus1y);
   bins incr_wrap = binsof(bus1.cb.HBURST.incr_undefine_length) && binsof(bus1.cb.HTRANS.nonseq);
  }
endgroup : BURST_covergroup 
BURST_covergroup br;

///////////////////////////////////////////////////////////////////////coverage of write data
covergroup write_data_covergroup@(posedge bus1.HCLK);
        option.per_instance = 1;
coverpoint  bus1.cb.HADDR;
coverpoint  bus1.cb.HWRITE;
coverpoint  bus1.cb.HWDATA;
coverpoint bus1.HRESETn;  

cross bus1.cb.HWRITE, bus1.cb.HWDATA {
    bins write_data_valid = binsof(bus1.cb.HWRITE) && binsof(bus1.cb.HWDATA);//Ensures data is valid during write operati
    bins write_data_invalid = !binsof(bus1.cb.HWRITE) && binsof(bus1.cb.HWDATA);
  }

  cross bus1.cb.HADDR, bus1.cb.HWRITE {
    bins addr_write_valid = binsof(bus1.cb.HADDR) && binsof(bus1.cb.HWRITE);//Ensures address is valid when writing data.
    bins addr_write_invalid = !binsof(bus1.cb.HADDR) && binsof(bus1.cb.HWRITE);
  }

  cross bus1.HRESETn, bus1.cb.HWRITE {
    bins reset_write_valid = binsof(bus1.HRESETn) && binsof(bus1.cb.HWRITE);//Ensures write operations behave correctly during reset.
    bins reset_write_invalid = !binsof(bus1.HRESETn) && binsof(bus1.cb.HWRITE);
  }
endgroup : write_data_covergroup
write_data_covergroup wd;

////////////////////////////////////////////////////////////////coverage of read data elements
covergroup slave_signals_covergroup @(posedge bus1.HCLK);
  option.per_instance = 1;
coverpoint bus1.cb.HRDATA;
  
coverpoint bus1.cb.HREADYOUT{
  bins hreadyout_high = {1'b1};
  bins hreadyout_low = {1'b0};
  }
coverpoint bus1.cb.HREADY{
  bins hready_high = {1'b1};
  bins hready_low = {1'b0};
  }
coverpoint bus1.cb.HRESP{
  bins HRESP_high = {1'b1};
  bins HRESP_low = {1'b0};
  }
   cross bus1.cb.HREADYOUT, bus1.cb.HREADY {
   bins hreadyout_high_hready_high = binsof(bus1.cb.HREADYOUT.hreadyout_high) && binsof(bus1.cb.HREADY.hready_high);
   bins hreadyout_low_hready_low = binsof(bus1.cb.HREADYOUT.hreadyout_low) && binsof(bus1.cb.HREADY.hready_low);
  }

 cross bus1.cb.HREADYOUT, bus1.cb.HRESP {
   bins hreadyout_high_HRESP_high = binsof(bus1.cb.HREADYOUT.hreadyout_high) && binsof(bus1.cb.HRESP.HRESP_high);
   bins hreadyout_low_HRESP_low = binsof(bus1.cb.HREADYOUT.hreadyout_low) && binsof(bus1.cb.HRESP.HRESP_low);
  }
endgroup : slave_signals_covergroup 
slave_signals_covergroup rd;

//////////////////////////////////////////////////////////////////////////////coverage of size 
covergroup size_covergroup @(posedge bus1.HCLK);
       option.per_instance = 1;
coverpoint bus1.cb.HSIZE {
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


//////////////////////////////// HPROT for Non-cacheable, non-bufferable, privileged, data access
covergroup HPROT_covergroup @(posedge bus1.HCLK);
       option.per_instance = 1;
  coverpoint bus1.cb.HPROT {
    bins hprot_1={4'b0000}; //Non-cacheable, non-bufferable, user mode, opcode fetch
    bins hprot_2 = {4'b0001};//Non-cacheable, non-bufferable, user mode, data access
    bins hprot_3 = {4'b0010};//Non-cacheable, non-bufferable, privileged mode, opcode fetch
    bins hprot_4 = {4'b0011}; //Non-cacheable, non-bufferable, privileged, data access
     
  }
endgroup
HPROT_covergroup protect;


initial 
begin
rd=new;
hc=new;
br=new;
wd=new;
sg=new;
protect=new;
end

endmodule

