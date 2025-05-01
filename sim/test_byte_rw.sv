///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : test_byte_rw.sv
// Title : test_byte_rw
// Description : Single Transfer byte size
// Notes :
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module test_byte_rw #(parameter HADDR_SIZE = 32, HDATA_SIZE = 32, DEBUG=0) (
  input logic HCLK,
  input logic HRESETn,
  ahb3lite_if.master bus
);
  timeunit 1ns;
  timeprecision 1ns;

  // Single transfer with byte size test
  task automatic test_byte_rw(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data, read_data;
    if (DEBUG) $display("[%0t] Starting AHB-Lite single transfer with byte size test", $time);
    
    // write and read at mem location 4
    write_data = 32'h0000_00AA;
    bus.ahb_write(.addr(32'h0000_0004),
    .data(write_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0000_0004),
    .data(read_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) $display("[%0t] Addr 0x0004: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    
    // write and read at mem location 5
    write_data = 32'h0000_BB00;
    bus.ahb_write(.addr(32'h0000_0005),
    .data(write_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0000_0005),
    .data(read_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) $display("[%0t] Addr 0x0005: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
  endtask

  initial begin
    wait(HRESETn);
    repeat(2) @(posedge HCLK);
    
    test_byte_rw(DEBUG);
    
    $finish;
  end

endmodule
