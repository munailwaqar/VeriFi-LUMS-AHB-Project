interface ahb3lite_if #(parameter HADDR_SIZE = 16, HDATA_SIZE = 32) (
  input logic HCLK,
  input logic HRESETn
);
timeunit 1ns;
timeprecision 1ns;

  logic HSEL;
  logic [HADDR_SIZE-1:0] HADDR;
  logic [HDATA_SIZE-1:0] HWDATA;
  logic [HDATA_SIZE-1:0] HRDATA;
  logic HWRITE;
  logic [2:0] HSIZE;
  logic [2:0] HBURST;
  logic [3:0] HPROT;
  logic [1:0] HTRANS;
  logic HREADY;
  logic HREADYOUT;
  logic HRESP;

  // Master modport
  modport master (
    output HSEL, HADDR, HWDATA, HWRITE, HSIZE, HBURST, HPROT, HTRANS, HREADY,
    input  HRDATA, HREADYOUT, HRESP
  );

endinterface