///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : ahb3lite_if.sv
// Title : ahb3lite_if
// Description : Interface
// Notes : 
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface ahb3lite_if #(parameter HADDR_SIZE = 32, HDATA_SIZE = 32) (
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

  // Clocking block
  default clocking cb @(posedge HCLK);
    default input #1step output #1;
    output HSEL, HADDR, HWDATA, HWRITE, HSIZE, HBURST, HPROT, HTRANS;
    input HRDATA, HREADYOUT, HRESP, HREADY;
  endclocking

  // Master modport
  modport master (
    output HSEL, HADDR, HWDATA, HWRITE, HSIZE, HBURST, HPROT, HTRANS,
    input HRDATA, HREADYOUT, HRESP, HREADY,
    clocking cb,
    import reset, ahb_write, ahb_read
  );

  // Reset Task
  task reset();
    cb.HTRANS <= '0;
    cb.HADDR <= '0;
    cb.HWRITE <= 0;
    cb.HSIZE <= '0;
    cb.HBURST <= '0;
    cb.HPROT <= '0;
    cb.HSEL  <= 0;
    cb.HWDATA <= '0;

    wait(HRESETn == 0);
    repeat(5) @(cb);
    wait(HRESETn == 1);
    $display("[%0t] Reset Done", $time);
  endtask


  // Write Task
  task automatic ahb_write(
    input logic [HADDR_SIZE-1:0] addr,
    input logic [HDATA_SIZE-1:0] data,
    input logic [2:0] hsize,
    input logic [2:0] hburst,
    input logic [3:0] hprot,
    input logic hsel,
    input logic [1:0] htrans
  );
    // Address phase
    @(cb);
    cb.HADDR  <= addr;
    cb.HWRITE <= 1'b1;
    cb.HTRANS <= htrans;
    cb.HSIZE <= hsize;
    cb.HBURST <= hburst;
    cb.HPROT  <= hprot;
    cb.HSEL  <= hsel;
    
    // Data Phase
    @(cb);
    cb.HWDATA <= data;
    cb.HTRANS <= 2'b00;
    repeat(2) @(cb);
  endtask

  // Read Task
  task automatic ahb_read(
    input logic [HADDR_SIZE-1:0] addr,
    output logic [HDATA_SIZE-1:0] data,
    input logic [2:0] hsize,
    input logic [2:0] hburst,
    input logic [3:0] hprot,
    input logic hsel,
    input logic [1:0] htrans
  );
    // Address phase
    @(cb);
    cb.HTRANS <= htrans;
    cb.HADDR <= addr;
    cb.HWRITE <= 1'b0;
    cb.HSIZE <= hsize;
    cb.HBURST <= hburst;
    cb.HPROT <= hprot;
    cb.HSEL  <= hsel;
    
    // Data Phase
    do @(cb); while (cb.HREADY !== 1'b1);
    repeat(3) @(cb);
    data = cb.HRDATA;
    cb.HTRANS <= 2'b00;
    repeat(2) @(cb);
  endtask

endinterface
