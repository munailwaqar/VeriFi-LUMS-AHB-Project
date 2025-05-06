`define HREADYOUT 
module tb_ahb3liten;
timeunit 1ns;
timeprecision 1ns;



  parameter HADDR_SIZE = 32;
  parameter HDATA_SIZE = 32;

  logic HCLK ;
  logic HRESETn;

  wire HREADYOUT;
`ifdef include_clk

 always #5 HCLK = ~HCLK;
`endif

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

   assign bus.HREADY = bus.HREADYOUT;	

  // 1). basic write and read test --> word transer, single burst, NONSEQ
  ahb3lite_test #(HADDR_SIZE, HDATA_SIZE) test (.HCLK(HCLK), .HRESETn(HRESETn), .bus(bus));


///use the binding 
// bind dut_mod prop_mod (
// .PROP_PORT(DUT_PORT)
// )

bind ahb3liten:dut ahb3liten_prop #(
    .MEM_SIZE(32),
    .MEM_DEPTH(256),
    .HADDR_SIZE(HADDR_SIZE),
    .HDATA_SIZE(HDATA_SIZE)
  ) BIND_UUT(
                .HCLK       (HCLK),
                .HRESETn    (HRESETn),
                .HSEL       (HSEL),
                .HADDR      (HADDR),
                .HWDATA     (HWDATA),
                .HRDATA     (HRDATA),
                .HWRITE     (HWRITE),
                .HSIZE      (HSIZE),
                .HBURST     (HBURST),
                .HPROT      (HPROT),
                .HTRANS     (HTRANS),
                .HREADY     (HREADY),
                .HREADYOUT  (HREADYOUT),
                .HRESP      (HRESP)
  );
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_ahb3liten);
  end

endmodule
