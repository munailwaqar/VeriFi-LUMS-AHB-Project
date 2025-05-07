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
  input                       HRESP,
  input HTRANS_NONSEQ
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




property check_write_enable;
  @(posedge HCLK) disable iff (!HRESETn)
  (HREADY == 1'b1) |->  (`waddr == `raddr); //`we == 1'b0; 
endproperty

check_write_enable_P: assert property (check_write_enable)
  else $display($stime, "FAIL:: Write Enable is inconsisten\n");
///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  6 FAILED~~~~~~~~~~~~~~~~~~~~~////////////////////////

property check_hresp;
  @(posedge HCLK)
  HRESP == HRESP_OKAY;
endproperty

check_hresp_P: assert property (check_hresp)
  else $display($stime, "FAIL:: check_hresp is inconsisten\n", HRDATA);


///////////~~~~~~~~~~~~~~~~~~~~PROPERTY  7 PASSED~~~~~~~~~~~~~~~~~~~~~////////////////////////


//// HSIZE CONSTANT THROUGHOUT BURST TRAANSFER ////


// property check_write_enable;
//   @(posedge HCLK) 
//   (HREADY == 1'b1) |->  (`waddr == `raddr); //`we == 1'b0; 
// endproperty

// check_write_enable_P: assert property (check_write_enable)
//   else $display($stime, "FAIL:: Write Enable is inconsisten\n", HRDATA);
// property check_hsize_const_when_burst_tf;
//   @(posedge HCLK)
//  (HSEL &&( HTRANS != HTRANS_IDLE) &&(HTRANS != HTRANS_NONSEQ)) |-> ##1 (HADDR != 0 && HWDATA != 0 );
// endproperty

//   check_hsize_const_when_burst_tf_p: assert property (check_hsize_const_when_burst_tf)
//     else $display($stime, "FAIL:: Hsize Const is inconsisten\n");

property check_property_hburst;
  @(posedge HCLK)
  // disable iff (!HRESETn)

 (HSEL &&( HTRANS != HTRANS_IDLE) &&(HTRANS != HTRANS_NONSEQ))  && (HBURST == HBURST_INCR) |-> (HADDR == $past(HADDR) + $clog2(HDATA_SIZE));

endproperty

  check_property_hburst_P: assert property (check_property_hburst)
    else $display($stime, "FAIL:: HBURST  is inconsisten\n");

endmodule
