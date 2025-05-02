///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : test_ahb3liten.sv
// Title : test_ahb3liten
// Description : Tests for verification of AHB-Lite Slave
// Notes :
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module test_ahb3liten #(parameter HADDR_SIZE = 32, HDATA_SIZE = 32, DEBUG=0) (
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

  // Single transfer with halfword size test
  task automatic test_halfword_rw(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data, read_data;
    if (DEBUG) $display("[%0t] Starting AHB-Lite single transfer with halfword size test", $time);
    
    // write and read at mem location 0
    write_data = 32'h0000_BEEF;
    bus.ahb_write(.addr(32'h0000),
    .data(write_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0000),
    .data(read_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) $display("[%0t] Addr 0x0000: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    
    // write and read at mem location 2
    write_data = 32'hDEAD_0000;
    bus.ahb_write(.addr(32'h0002),
    .data(write_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0002),
    .data(read_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) $display("[%0t] Addr 0x0002: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
  endtask

  // INCR4 Word Burst Test
  task automatic test_incr4_word(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data[0:3];
    logic [HDATA_SIZE-1:0] read_data;
    logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0000;

    if (DEBUG) $display("[%0t] Starting AHB-Lite INCR4 word burst test", $time);

    write_data[0] = 32'h1111_1111;
    write_data[1] = 32'h2222_2222;
    write_data[2] = 32'h3333_3333;
    write_data[3] = 32'h4444_4444;

    // Write burst
    for (int i = 0; i < 4; i++) begin
      bus.ahb_write(
        .addr(base_addr + i * 4),
        .data(write_data[i]),
        .hsize(3'b010),
        .hburst(3'b011), //INCR4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)  // NONSEQ -> SEQ
      );
      if (DEBUG) $display("[%0t] Burst Write Addr 0x%h = 0x%h", $time, base_addr + i * 4, write_data[i]);
    end

    // Read burst
    for (int i = 0; i < 4; i++) begin
      bus.ahb_read(
        .addr(base_addr + i * 4),
        .data(read_data),
        .hsize(3'b010),
        .hburst(3'b011), // INCR4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)  // NONSEQ -> SEQ
      );
      if (DEBUG)
        $display("[%0t] Burst Read Addr 0x%h = 0x%h", $time, base_addr + i * 4, read_data);
    end
  endtask


  initial begin
    wait(HRESETn);
    repeat(2) @(posedge HCLK);
    
    test_word_rw(DEBUG);
  //  test_byte_rw(DEBUG);
  //  test_halfword_rw(DEBUG);
  //  test_incr4_word(DEBUG);
    
    $finish;
  end

endmodule
