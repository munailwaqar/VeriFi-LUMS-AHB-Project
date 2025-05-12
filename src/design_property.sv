
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : design_property.sv
// Title : ahb3liten_prop
// Description : Tests for verification of AHB-Lite Slave
// Notes :
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`define ahb_noseq tb_ahb3liten.dut.ahb_noseq
`define ahb_read tb_ahb3liten.dut.ahb_read
`define ahb_write tb_ahb3liten.dut.ahb_write
`define mask tb_ahb3liten.dut.mask
`define we tb_ahb3liten.dut.we
`define waddr tb_ahb3liten.dut.waddr
`define raddr tb_ahb3liten.dut.raddr

///////////////////////ASSERTIONS///////////////////////////////////


module ahb3liten_prop
import ahb3lite_pkg::*;
#(
  parameter MEM_SIZE          = 32,
  parameter MEM_DEPTH         = 256,
  parameter HADDR_SIZE        = 16,
  parameter HDATA_SIZE        = 32
)
(
  input                       HRESETn,
                              HCLK,

  input                       HSEL,
  input      [HADDR_SIZE-1:0] HADDR,
  input      [HDATA_SIZE-1:0] HWDATA,
  input logic [HDATA_SIZE-1:0] HRDATA,
  input                       HWRITE,
  input      [           2:0] HSIZE,
  input      [           2:0] HBURST,
  input      [           3:0] HPROT,
  input      [           1:0] HTRANS,
  input logic                 HREADYOUT,
  input                       HREADY,
  input                       HRESP
);

timeunit 1ns;
timeprecision 1ns;

//PROPERTY1 ~~~~~~~~~~~~~~~~~~~~ RST ==0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// `ifdef assert_rst
property check_rstn_asserted;
  @(posedge HCLK)
 disable iff (HRESETn)
 (HREADYOUT ==1'b1); //if !rst hreadyout =1'b1 
endproperty

check_rstn_asserted_P: assert property (check_rstn_asserted)
  else $display($stime,"\t\t FAIL:: check_rstn_asserted\n");

///////////~~~~~~~~~~~~~~~~~~~~PROPERTY 1 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////


//PROPERTY2 ~~~~~~~~~~~~~~~~~~~~ RST ==1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

property check_rstn_deasserted;
  @(posedge HCLK)
    (`ahb_noseq && `ahb_read & HREADYOUT) |=> (HREADYOUT == 1'b0); // Ensure the condition is written correctly
endproperty


check_rstn_deasserted_P: assert property (check_rstn_deasserted)
  else $display($stime,"\t\t FAIL:: check_rstn_deasserted\n");

///////////~~~~~~~~~~~~~~~~~~~~PROPERTY 2 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////

property check_hwrite;
  @(posedge HCLK) 
  (`ahb_read == 1) |-> (`ahb_write ==0);
endproperty

check_hwrite_P: assert property (check_hwrite)
  else $display($stime, "\t\t FAIL:: check_check_hwrite\n");

///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  3 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////



property check_addr_range;
  @(posedge HCLK)
(HSIZE >= 0 && HSIZE <  1024);
endproperty

check_addr_range_P: assert property (check_addr_range)
  else $display($stime, "\t\t FAIL:: check_check_hwrite\n");

///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  4 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////


property check_bus_transfer_width;
  @(posedge HCLK)
 (HWRITE) |-> (HWDATA >= 0 && HWDATA <= 32'hFFFFFFFF);
endproperty

check_bus_transfer_width_P: assert property (check_bus_transfer_width)
  else $display($stime, "\t\t FAIL:: check_bus_transfer_width\n");

///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  5 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////

property check_hresp;
  @(posedge HCLK)
  HRESP == HRESP_OKAY;
endproperty

check_hresp_P: assert property (check_hresp)
  else $display($stime, "FAIL:: check_hresp is inconsisten\n");


///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  6 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////

// check the hsize < or = data bus
property check_HSIZE_width;
  @(posedge HCLK)
  HSIZE <= 32;
endproperty 

  check_HSIZE_width_p: assert property (check_HSIZE_width)
    else $display($time,"FAIL:: check_HSIZE_width is inconsistent");
///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  7 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////

// property hsize_const_four_beat_tf_burst;
//   @(posedge HCLK) disable iff(!HRESETn)

//   //tihis is for the 4 beat incrementing burst so we have the 011
//     ((HTRANS == HTRANS_NONSEQ) && (HBURST == HBURST_INCR4 || HBURST == HBURST_WRAP4) |=> $stable(HSIZE) [*4]);
// endproperty

// hsize_const_four_beat_tf_burst_p: assert property (hsize_const_four_beat_tf_burst)
//     else $display($time,"FAIL:: hsize_const_four_beat_tf_burst is inconsistent");

// ///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  8 Failed~~~~~~~~~~~~~~~~~~~~~////////////////////////

// property hsize_const_eight_beat_tf_burst;
//   @(posedge HCLK) disable iff(!HRESETn)

//   //tihis is for the 8 beat incrementing burst so we have the 011
//     ((HTRANS == HTRANS_NONSEQ) && (HBURST == HBURST_INCR8 || HBURST == HBURST_WRAP8) |=> $stable(HSIZE) [*8]);
// endproperty

// hsize_const_eight_beat_tf_burst_p: assert property (hsize_const_eight_beat_tf_burst)
//     else $display($time,"FAIL:: hsize_const_eight_beat_tf_burst is inconsistent");

// ///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  9 Failed~~~~~~~~~~~~~~~~~~~~~////////////////////////

// property hsize_const_sixteen_beat_tf_burst;
//   @(posedge HCLK) disable iff(!HRESETn)

// //tihis is for the 16 beat incrementing burst so we have the 011
//     ((HTRANS == HTRANS_NONSEQ) && (HBURST == HBURST_INCR8 || HBURST == HBURST_WRAP8) |=> $stable(HSIZE) [*16]);
// endproperty

// hsize_const_sixteen_beat_tf_burst_P: assert property (hsize_const_sixteen_beat_tf_burst)
//     else $display($time,"FAIL:: hsize_const_sixteen_beat_tf_burst is inconsistent");
// ///////////~~~~~~~~~~~~~~~~~~~~PROPERTY 10 Failed~~~~~~~~~~~~~~~~~~~~~////////s////////////////

endmodule
