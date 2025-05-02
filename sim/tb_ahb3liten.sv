///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2025 VeriFi-LUMS-AHB-Project. All Rights Reserved.
//
// File name : tb_ahb3liten.sv
// Title : tb_ahb3liten
// Description : Top module
// Notes :
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module tb_ahb3liten;
timeunit 1ns;
timeprecision 1ns;

  parameter HADDR_SIZE = 32;
  parameter HDATA_SIZE = 32;
  parameter DEBUG = 1;

  logic HCLK;
  logic HRESETn;

  always #5 HCLK = ~HCLK;

  initial begin
    HCLK = 0;
    HRESETn = 0;
    #20;
    HRESETn = 1;

    // Global timout
    #25000;
    $error("[TIMEOUT] Simulation timed out");
    $finish;
  end

  // interface
  ahb3lite_if #(HADDR_SIZE, HDATA_SIZE) bus(HCLK, HRESETn);

  // DUT -- no modport for this because we cant change design's port names
  ahb3liten #(
    .MEM_SIZE(32),
    .MEM_DEPTH(256),
    .HADDR_SIZE(HADDR_SIZE),
    .HDATA_SIZE(HDATA_SIZE)
  ) dut (
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),
    .HSEL       (bus.HSEL),
    .HADDR      (bus.HADDR),
    .HWDATA     (bus.HWDATA),
    .HRDATA     (bus.HRDATA),
    .HWRITE     (bus.HWRITE),
    .HSIZE      (bus.HSIZE),
    .HBURST     (bus.HBURST),
    .HPROT      (bus.HPROT),
    .HTRANS     (bus.HTRANS),
    .HREADY     (bus.HREADY),
    .HREADYOUT  (bus.HREADYOUT),
    .HRESP      (bus.HRESP)
  );

   assign bus.HREADY = bus.HREADYOUT;	

  // UNCOMMENT THE RELEVANT TEST
  // 1). write and read test --> word transfer, single burst, NONSEQ
 // test_word_rw #(HADDR_SIZE, HDATA_SIZE, DEBUG) test (.HCLK(HCLK), .HRESETn(HRESETn), .bus(bus));

   // 2). write and read test --> byte transfer, single burst, NONSEQ
 // test_byte_rw #(HADDR_SIZE, HDATA_SIZE, DEBUG) test (.HCLK(HCLK), .HRESETn(HRESETn), .bus(bus));

  // 3). write and read test --> halfword transfer, single burst, NONSEQ
 // test_halfword_rw #(HADDR_SIZE, HDATA_SIZE, DEBUG) test (.HCLK(HCLK), .HRESETn(HRESETn), .bus(bus));

  // 4). write and read test --> word transer, incr4 burst, NONSEQ -> SEQ
  test_incr4_word #(HADDR_SIZE, HDATA_SIZE, DEBUG) test (.HCLK(HCLK), .HRESETn(HRESETn), .bus(bus));

endmodule
