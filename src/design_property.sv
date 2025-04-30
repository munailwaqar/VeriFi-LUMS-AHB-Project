`define ahb_noseq tb_ahb3liten.dut.ahb_noseq
`define ahb_read tb_ahb3liten.dut.ahb_read


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
  input logic                  HREADYOUT,
  input                       HREADY,
  input                      HRESP
);

timeunit 1ns;
timeprecision 1ns;

//PROPERTY1 ~~~~~~~~~~~~~~~~~~~~ RST ==0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef assert_rst
property check_rstn_asserted;
  @(posedge HCLK)
  (HRESETn == 1'b0) |-> (HREADYOUT ==1'b1); //if !rst hreadyout =1'b1 
endproperty

check_rstn_asserted_P: assert property (check_rstn_asserted)
  else $display($stime,"\t\t FAIL:: check_rstn_asserted\n");
`endif


//PROPERTY2 ~~~~~~~~~~~~~~~~~~~~ RST ==1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef deassert_rst

property check_rstn_deasserted;
  @(posedge HCLK)
    (`ahb_noseq && `ahb_read && HREADYOUT) |-> (HREADYOUT == 1'b0); // Ensure the condition is written correctly
endproperty


check_rstn_deasserted_P: assert property (check_rstn_deasserted)
  else $display($stime,"\t\t FAIL:: check_rstn_deasserted\n");

`endif



endmodule