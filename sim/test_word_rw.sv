///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : test_word_rw.sv
// Title : test_word_rw
// Description : Single Transfer word size
// Notes :
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module test_word_rw #(parameter HADDR_SIZE = 32, HDATA_SIZE = 32, DEBUG=0) (
  input logic HCLK,
  input logic HRESETn,
  ahb3lite_if.master bus
);
  timeunit 1ns;
  timeprecision 1ns;

  // Single transfer with word size test
  task automatic test_word_rw(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data, read_data;
    if (DEBUG) $display("[%0t] Starting AHB-Lite single transfer with word size test", $time);
    
    // write and read at mem location 0
    write_data = 32'hCAFE_BABE;
    bus.ahb_write(.addr(32'h0000),
    .data(write_data),
    .hsize(3'b010),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0000),
    .data(read_data),
    .hsize(3'b010),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) $display("[%0t] Addr 0x0000: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    
    // write and read at mem location 1
    write_data = 32'hDEAD_BEEF;
    bus.ahb_write(.addr(32'h0004),
    .data(write_data),
    .hsize(3'b010),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0004),
    .data(read_data),
    .hsize(3'b010),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) $display("[%0t] Addr 0x0004: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
  endtask

  initial begin
    wait(HRESETn);
    repeat(2) @(posedge HCLK);
    
    test_word_rw(DEBUG);
    
    $finish;
  end

endmodule
