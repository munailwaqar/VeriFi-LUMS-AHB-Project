module tb_ahb3liten;
timeunit 1ns;
timeprecision 1ns;

  parameter HADDR_SIZE = 16;
  parameter HDATA_SIZE = 32;

  logic HCLK = 0;
  logic HRESETn = 0;

  always #5 HCLK = ~HCLK;

  initial begin
    HRESETn = 0;
    #20;
    HRESETn = 1;
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

  // Test
  ahb3lite_test #(HADDR_SIZE, HDATA_SIZE) test (
    .HCLK(HCLK),
    .HRESETn(HRESETn),
    .bus(bus)
  );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_ahb3liten);
  end

endmodule