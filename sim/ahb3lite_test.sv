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
  
  int error_count = 0;

  // Single transfer with word size test
  task automatic test_word_rw(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data;
    bit [HDATA_SIZE-1:0] read_data;
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
    if (DEBUG) begin
    $display("[%0t] Addr 0x0000: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    if (read_data !== write_data) begin
  	error_count++;
  	$display("[%0t] Addr 0x0000: Mismatch! Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    end
    end

    
    // write and read at mem location 4
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
    if (DEBUG) begin
    $display("[%0t] Addr 0x0004: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    if (read_data !== write_data) begin
  	error_count++;
  	$display("[%0t] Addr 0x0004: Mismatch! Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    end
   end
  endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Single transfer with byte size test
  task automatic test_byte_rw(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data;
    bit [HDATA_SIZE-1:0] read_data;
    if (DEBUG) $display("[%0t] Starting AHB-Lite single transfer with byte size test", $time);
    
    // write and read at mem location 8
    write_data = 32'h0000_00AA;
    bus.ahb_write(.addr(32'h0000_0008),
    .data(write_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0000_0008),
    .data(read_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) begin
    $display("[%0t] Addr 0x0008: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    if (read_data !== write_data) begin
  	error_count++;
  	$display("[%0t] Addr 0x0008: Mismatch! Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    end
    end

    // write and read at mem location 9
    write_data = 32'h0000_BBAA;
    bus.ahb_write(.addr(32'h0000_0009),
    .data(write_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0000_0009),
    .data(read_data),
    .hsize(3'b000),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) begin
    $display("[%0t] Addr 0x0009: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    if (read_data !== write_data) begin
  	error_count++;
  	$display("[%0t] Addr 0x0009: Mismatch! Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    end
   end
  endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Single transfer with halfword size test
  task automatic test_halfword_rw(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data;
    bit [HDATA_SIZE-1:0] read_data;
    if (DEBUG) $display("[%0t] Starting AHB-Lite single transfer with halfword size test", $time);
    
    // write and read at mem location 10
    write_data = 32'h0000_BEEF;
    bus.ahb_write(.addr(32'h0010),
    .data(write_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0010),
    .data(read_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) begin
    $display("[%0t] Addr 0x0010: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    if (read_data !== write_data) begin
  	error_count++;
  	$display("[%0t] Addr 0x0010: Mismatch! Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    end
    end

    // write and read at mem location 12
    write_data = 32'hDEAD_BEEF;
    bus.ahb_write(.addr(32'h0012),
    .data(write_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));    
    bus.ahb_read(.addr(32'h0012),
    .data(read_data),
    .hsize(3'b001),
    .hburst(3'b000),
    .hprot(4'b0011),
    .hsel(1'b1),
    .htrans(2'b10));
    if (DEBUG) begin
    $display("[%0t] Addr 0x0012: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    if (read_data !== write_data) begin
  	error_count++;
  	$display("[%0t] Addr 0x0012: Mismatch! Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    end
    end
  endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // INCR4 Word Burst Test
  task automatic test_incr4_word(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data[0:3];
    bit [HDATA_SIZE-1:0] read_data;
    logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0020;

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

      bus.ahb_read(
        .addr(base_addr + i * 4),
        .data(read_data),
        .hsize(3'b010),
        .hburst(3'b011), // INCR4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)  // NONSEQ -> SEQ
      );
      if (DEBUG) begin
       $display("[%0t] Burst Write Addr 0x%h = 0x%h, Read = 0x%h", $time, base_addr + i * 4, write_data[i], read_data);
      if (read_data !== write_data[i]) begin
      	$error("[%0t] Mismatch at Addr 0x%h: Expected 0x%h, Got 0x%h", $time, base_addr + i * 4, write_data[i], read_data);
      	error_count++;
      end
     end
    end
  endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////

   // WRAP4 Word Burst Test
  task automatic test_wrap4_word(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data[0:5];
    bit [HDATA_SIZE-1:0] read_data;
    logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0034;
    logic [HADDR_SIZE-1:0] wrap_addr;

    if (DEBUG) $display("[%0t] Starting AHB-Lite WRAP4 word burst test", $time);

    write_data[0] = 32'hAAAA_0000;
    write_data[1] = 32'hBBBB_1111;
    write_data[2] = 32'hCCCC_2222;
    write_data[3] = 32'hDDDD_3333;
    write_data[4] = 32'hEEEE_4444;

    // Write phase
    for (int i = 0; i < 4; i++) begin
      wrap_addr = calc_wrap_addr(base_addr, 3'b010, 3'b010, i);
      bus.ahb_write(
        .addr(wrap_addr),
        .data(write_data[i]),
        .hsize(3'b010),
        .hburst(3'b010), // WRAP4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)
      );

      bus.ahb_read(
        .addr(wrap_addr),
        .data(read_data),
        .hsize(3'b010),
        .hburst(3'b010), // WRAP4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)
      );
      if (DEBUG) begin
       $display("[%0t] WRAP4 Write (logical beat %0d) to Addr 0x%08h = 0x%08h, Read = 0x%08h", $time, i, wrap_addr, write_data[i], read_data);
      if (read_data !== write_data[i]) begin
      	$error("[%0t] Mismatch at Addr 0x%h: Expected 0x%h, Got 0x%h", $time, wrap_addr, write_data[i], read_data);
      	error_count++;
      end
      end
    end
  endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////

// INCR8 Byte Burst Test
task automatic test_incr8_byte(input bit DEBUG);
  logic [HDATA_SIZE-1:0] write_data[0:8];
    bit [HDATA_SIZE-1:0] read_data;
  logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0050;
  logic [HADDR_SIZE-1:0] incr_addr;
byte expected_byte, read_byte;
logic [1:0] byte_lane;


  if (DEBUG) $display("[%0t] Starting AHB-Lite INCR8 byte burst test", $time);

  write_data[0] = 32'h0000_00A1;
  write_data[1] = 32'h0000_B200;
  write_data[2] = 32'h00C3_0000;
  write_data[3] = 32'hD400_0000;
  write_data[4] = 32'h0000_00E5;
  write_data[5] = 32'h0000_F600;
  write_data[6] = 32'h0007_0000;
  write_data[7] = 32'h1800_0000;
  write_data[8] = 32'h0000_00FF;

  // Write phase
  for (int i = 0; i < 9; i++) begin
    incr_addr = base_addr + i;
    bus.ahb_write(
      .addr(incr_addr),
      .data(write_data[i]),
      .hsize(3'b000),
      .hburst(3'b101),          // INCR8
      .hprot(4'b0011),
      .hsel(1'b1),
      .htrans(i == 0 ? 2'b10 : 2'b11)
    );

    bus.ahb_read(
      .addr(incr_addr),
      .data(read_data),
      .hsize(3'b000),
      .hburst(3'b101),          // INCR8
      .hprot(4'b0011),
      .hsel(1'b1),
      .htrans(i == 0 ? 2'b10 : 2'b11)
    );
    byte_lane = incr_addr[1:0];
    unique case (byte_lane)
      2'b00: begin
        read_byte     = read_data[7:0];
        expected_byte = write_data[i][7:0];
      end
      2'b01: begin
        read_byte     = read_data[15:8];
        expected_byte = write_data[i][15:8];
      end
      2'b10: begin
        read_byte     = read_data[23:16];
        expected_byte = write_data[i][23:16];
      end
      2'b11: begin
        read_byte     = read_data[31:24];
        expected_byte = write_data[i][31:24];
      end
    endcase

    if (DEBUG) begin
      $display("[%0t] INCR8 Write (beat %0d) to Addr 0x%h = 0x%h, Read = 0x%h", $time, i, incr_addr, expected_byte, read_byte);
      if (read_byte !== expected_byte) begin
        $error("[%0t] Mismatch at Addr 0x%h: Expected 0x%02h, Got 0x%02h", $time, incr_addr, expected_byte, read_byte);
        error_count++;
      end
    end

  end
endtask

////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // WRAP8 Byte Burst Test
  task automatic test_wrap8_byte(input bit DEBUG);
    logic [HDATA_SIZE-1:0] write_data[0:8];
    bit [HDATA_SIZE-1:0] read_data;
    logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0060;
    logic [HADDR_SIZE-1:0] wrap_addr;
byte expected_byte, read_byte;
logic [1:0] byte_lane;

    if (DEBUG) $display("[%0t] Starting AHB-Lite WRAP8 byte burst test", $time);

    write_data[0] = 32'h0000_00A1;
    write_data[1] = 32'h0000_B200;
    write_data[2] = 32'h00C3_0000;
    write_data[3] = 32'hD400_0000;
    write_data[4] = 32'h0000_00E5;
    write_data[5] = 32'h0000_F600;
    write_data[6] = 32'h0007_0000;
    write_data[7] = 32'h1800_0000;
    write_data[8] = 32'h0000_00FF;

    // Write phase
    for (int i = 0; i < 9; i++) begin
      wrap_addr = calc_wrap_addr(base_addr, 3'b000, 3'b100, i);
      bus.ahb_write(
        .addr(wrap_addr),
        .data(write_data[i]),
        .hsize(3'b000),
        .hburst(3'b100), // WRAP8
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)
      );

      bus.ahb_read(
        .addr(wrap_addr),
        .data(read_data),
        .hsize(3'b000),
        .hburst(3'b100),
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)
      );
      byte_lane = wrap_addr[1:0];
      unique case (byte_lane)
      2'b00: begin
        read_byte     = read_data[7:0];
        expected_byte = write_data[i][7:0];
      end
      2'b01: begin
        read_byte     = read_data[15:8];
        expected_byte = write_data[i][15:8];
      end
      2'b10: begin
        read_byte     = read_data[23:16];
        expected_byte = write_data[i][23:16];
      end
      2'b11: begin
        read_byte     = read_data[31:24];
        expected_byte = write_data[i][31:24];
      end
    endcase

    if (DEBUG) begin 
      $display("[%0t] WRAP8 Write (beat %0d) to Addr 0x%h = 0x%h, Read = Byte 0x%02h", $time, i, wrap_addr, expected_byte, read_byte);
    if (read_byte !== expected_byte) begin
      $error("[%0t] Mismatch at Addr 0x%h: Expected 0x%02h, Got 0x%02h", $time, wrap_addr, expected_byte, read_byte);
      error_count++;
    end
    end
    end
  endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////

// INCR16 Halfword Burst Test
task automatic test_incr16_halfword(input bit DEBUG);
  logic [HDATA_SIZE-1:0] write_data[0:16];
    bit [HDATA_SIZE-1:0] read_data;
  logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0070;
  logic [HADDR_SIZE-1:0] incr_addr;
      logic [15:0] halfword;
  logic [31:0] zero_ext_halfword;

  if (DEBUG) $display("[%0t] Starting AHB-Lite INCR16 halfword burst test", $time);

  for (int i = 0; i < 17; i++) begin
    case (i)
    0:  write_data[i] = 32'h0000_DEAD;
    1:  write_data[i] = 32'hBEEF_0000;
    2:  write_data[i] = 32'h0000_C0DE;
    3:  write_data[i] = 32'hFADE_0000;
    4:  write_data[i] = 32'h0000_ABCD;
    5:  write_data[i] = 32'h1234_0000;
    6:  write_data[i] = 32'h0000_5678;
    7:  write_data[i] = 32'h9ABC_0000;
    8:  write_data[i] = 32'h0000_DEF0;
    9:  write_data[i] = 32'hAAAA_0000;
    10: write_data[i] = 32'h0000_5555;
    11: write_data[i] = 32'h0F0F_0000;
    12: write_data[i] = 32'h0000_F00F;
    13: write_data[i] = 32'hCAFE_0000;
    14: write_data[i] = 32'h0000_BABE;
    15: write_data[i] = 32'hFACE_0000;
    16: write_data[i] = 32'h0000_1337;
    endcase
  end

  // Write phase
  for (int i = 0; i < 17; i++) begin
    incr_addr = base_addr + (i * 2); // Halfword = 2 bytes
    bus.ahb_write(
      .addr(incr_addr),
      .data(write_data[i]),
      .hsize(3'b001),
      .hburst(3'b111), // INCR16
      .hprot(4'b0011),
      .hsel(1'b1),
      .htrans(i == 0 ? 2'b10 : 2'b11)
    );

    bus.ahb_read(
      .addr(incr_addr),
      .data(read_data),
      .hsize(3'b001),
      .hburst(3'b111), // INCR16
      .hprot(4'b0011),
      .hsel(1'b1),
      .htrans(i == 0 ? 2'b10 : 2'b11)
    );
     if (incr_addr[1] == 1'b0) begin
      halfword = read_data[15:0];
      zero_ext_halfword = {16'h0000, halfword};
    end else begin
      halfword = read_data[31:16];
      zero_ext_halfword = {halfword, 16'h0000};
    end
    if (DEBUG) begin
      $display("[%0t] INCR16 Write (beat %0d) to Addr 0x%h = 0x%h, Read = 0x%h", $time, i, incr_addr, write_data[i], zero_ext_halfword);
      if (zero_ext_halfword !== write_data[i]) begin
   	$error("[%0t] Mismatch at Addr 0x%h: Expected 0x%h, Got 0x%h", $time, incr_addr, write_data[i], zero_ext_halfword);
      	error_count++;
      end
    end
  end
endtask

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// WRAP16 Halfword Burst Test
task automatic test_wrap16_halfword(input bit DEBUG);
  logic [HDATA_SIZE-1:0] write_data[0:16];
    bit [HDATA_SIZE-1:0] read_data;
  logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0080;
  logic [HADDR_SIZE-1:0] wrap_addr;
      logic [15:0] halfword;
  logic [31:0] zero_ext_halfword;

  if (DEBUG) $display("[%0t] Starting AHB-Lite WRAP16 halfword burst test", $time);

  for (int i = 0; i < 17; i++) begin
    case (i)
    0:  write_data[i] = 32'h0000_DEAD;
    1:  write_data[i] = 32'hBEEF_0000;
    2:  write_data[i] = 32'h0000_C0DE;
    3:  write_data[i] = 32'hFADE_0000;
    4:  write_data[i] = 32'h0000_ABCD;
    5:  write_data[i] = 32'h1234_0000;
    6:  write_data[i] = 32'h0000_5678;
    7:  write_data[i] = 32'h9ABC_0000;
    8:  write_data[i] = 32'h0000_DEF0;
    9:  write_data[i] = 32'hAAAA_0000;
    10: write_data[i] = 32'h0000_5555;
    11: write_data[i] = 32'h0F0F_0000;
    12: write_data[i] = 32'h0000_F00F;
    13: write_data[i] = 32'hCAFE_0000;
    14: write_data[i] = 32'h0000_BABE;
    15: write_data[i] = 32'hFACE_0000;
    16: write_data[i] = 32'h0000_1337;
  endcase
  end

  // Write phase
  for (int i = 0; i < 17; i++) begin
    wrap_addr = calc_wrap_addr(base_addr, 3'b001, 3'b110, i);
    bus.ahb_write(
      .addr(wrap_addr),
      .data(write_data[i]),
      .hsize(3'b001),
      .hburst(3'b110), // WRAP16
      .hprot(4'b0011),
      .hsel(1'b1),
      .htrans(i == 0 ? 2'b10 : 2'b11)
    );

    bus.ahb_read(
      .addr(wrap_addr),
      .data(read_data),
      .hsize(3'b001),
      .hburst(3'b110), // WRAP16
      .hprot(4'b0011),
      .hsel(1'b1),
      .htrans(i == 0 ? 2'b10 : 2'b11)
    );
     if (wrap_addr[1] == 1'b0) begin
      halfword = read_data[15:0];
      zero_ext_halfword = {16'h0000, halfword};
    end else begin
      halfword = read_data[31:16];
      zero_ext_halfword = {halfword, 16'h0000};
    end
    if (DEBUG) begin
     $display("[%0t] WRAP16 Write (logical beat %0d) to Addr 0x%h = 0x%h, Read = 0x%h", $time, i, wrap_addr, write_data[i], zero_ext_halfword);
      if (zero_ext_halfword !== write_data[i]) begin
   	$error("[%0t] Mismatch at Addr 0x%h: Expected 0x%h, Got 0x%h", $time, wrap_addr, write_data[i], zero_ext_halfword);
      	error_count++;
      end
    end
  end
endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// BONUS TEST!!!
task automatic test_incr4_word_busy(input bit DEBUG);
  logic [HDATA_SIZE-1:0] write_data[0:3];
    bit [HDATA_SIZE-1:0] read_data;
  logic [HADDR_SIZE-1:0] base_addr = 32'h0000_0100;
  int beat_idx = 0;

  if (DEBUG) $display("[%0t] Starting AHB-Lite INCR4 word burst test with BUSY", $time);

  write_data = '{32'h1111_1111, 32'h2222_2222, 32'h3333_3333, 32'h4444_4444};

  // Write burst with BUSY after beat 1
  for (int i = 0; i < 5; i++) begin
    if (i == 2) begin // for BUSY cycle
      bus.ahb_write(
        .addr(32'h0000_0008),
        .data(32'h00000000),
        .hsize(3'b010),
        .hburst(3'b011), // INCR4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(2'b01)
      );
      if (DEBUG) $display("[%0t] BUSY cycle inserted (write)", $time);
    end else begin
      bus.ahb_write(
        .addr(base_addr + beat_idx * 4),
        .data(write_data[beat_idx]),
        .hsize(3'b010),
        .hburst(3'b011), // INCR4
        .hprot(4'b0011),
        .hsel(1'b1),
        .htrans(i == 0 ? 2'b10 : 2'b11)
      );
      if (DEBUG) $display("[%0t] Write Addr 0x%h = 0x%h", $time, base_addr + beat_idx * 4, write_data[beat_idx]);
      beat_idx++;
    end
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
      if (DEBUG) begin
       $display("[%0t] Read Addr 0x%h = Read = 0x%h", $time, base_addr + i * 4, read_data);
      if (read_data !== write_data[i]) begin
      	$error("[%0t] Mismatch at Addr 0x%h: Expected 0x%h, Got 0x%h", $time, base_addr + i * 4, write_data[i], read_data);
      	error_count++;
      end
      end
    end
endtask
////////////////////////////////////////////////////////////////////////////////////////////////////////////
  initial begin
    bus.reset();
    repeat(2) @(posedge HCLK);
    
  // UNCOMMENT THE RELEVANT TEST

    test_word_rw(DEBUG);
    test_byte_rw(DEBUG);
    test_halfword_rw(DEBUG);
    test_incr4_word(DEBUG);
    test_wrap4_word(DEBUG);
    test_incr8_byte(DEBUG);
    test_wrap8_byte(DEBUG);
    test_incr16_halfword(DEBUG);
    test_wrap16_halfword(DEBUG);
    test_incr4_word_busy(DEBUG);
    
    if (DEBUG) begin
  	if (error_count == 0)
    		$display("[%0t] All tests PASSED with 0 errors", $time);
  	else
    		$display("[%0t] Tests FAILED with %0d errors", $time, error_count);
    end
    $finish;
  end

// function to calculate wrap addresses for all wrap types and transfer sizes
function automatic [31:0] calc_wrap_addr(
  input [31:0] start_addr,
  input [2:0]  hsize,
  input [2:0]  hburst,
  input int beat_index
);
  int beat_size_bytes;
  int total_beats;
  int wrap_boundary;
  int offset;
begin
  beat_size_bytes = 1 << hsize;

  case (hburst)
    3'b010: total_beats = 4;
    3'b100: total_beats = 8;
    3'b110: total_beats = 16;
    default: total_beats = 1;
  endcase

  wrap_boundary = beat_size_bytes * total_beats;
  offset = ((start_addr % wrap_boundary) + beat_index * beat_size_bytes) % wrap_boundary;

  return (start_addr & ~(wrap_boundary - 1)) + offset;
end
endfunction

endmodule
