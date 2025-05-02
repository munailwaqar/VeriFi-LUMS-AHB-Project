///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : test_incr4_word.sv
// Title : test_incr4_word
// Description : Burst Transfer Incrementing 4
// Notes :
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module test_incr4_word #(parameter HADDR_SIZE = 32, HDATA_SIZE = 32, DEBUG = 0) (
  input  logic HCLK,
  input  logic HRESETn,
  ahb3lite_if.master bus
);
  timeunit 1ns;
  timeprecision 1ns;

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
    wait (HRESETn);
    repeat (2) @(posedge HCLK);
    
    test_incr4_word(DEBUG);
    
    $finish;
  end

endmodule

