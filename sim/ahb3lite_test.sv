module ahb3lite_test #(parameter HADDR_SIZE = 16, HDATA_SIZE = 32) (
  input logic HCLK,
  input logic HRESETn,
  ahb3lite_if.master bus
);
timeunit 1ns;
timeprecision 1ns;

  initial begin
   // bus.HADDR  <= '0;
   // bus.HWRITE <= '0;
    bus.HREADY = 1'b1;
    bus.HSEL   <= 1'b1;
    bus.HTRANS <= 2'b00; // Start in IDLE
   // bus.HWDATA <= '0;
    bus.HSIZE  <= 3'b010; // 32-bit
    bus.HBURST <= 3'b000; // Single
    bus.HPROT  <= 4'b0011;
  end

  task automatic ahb_write(input logic [HADDR_SIZE-1:0] addr, input logic [HDATA_SIZE-1:0] data);
    // Address phase
    @(posedge HCLK);
    bus.HADDR  <= addr;
    bus.HWRITE <= 1'b1;
    bus.HTRANS <= 2'b10; // NONSEQ
    
    // Data Phase
    @(posedge HCLK);
    bus.HWDATA <= data;
    repeat(2) @(posedge HCLK);
  endtask

  task automatic ahb_read(input logic [HADDR_SIZE-1:0] addr, output logic [HDATA_SIZE-1:0] data);
    // Address phase
    @(posedge HCLK);
    bus.HADDR  <= addr;
    bus.HWRITE <= 1'b0;
    @(posedge HCLK);
    @(negedge HCLK);
    data = bus.HRDATA;
    
  endtask

  initial begin
    logic [HDATA_SIZE-1:0] read_data;
    wait(HRESETn);
    repeat(2) @(posedge HCLK);
    
    $display("[%0t] Starting AHB-Lite test", $time);
    
    // simple write at mem location 0
    ahb_write(16'h0000, 32'hA5A5A5A5);    
    ahb_read(16'h0000, read_data);
    $display("[%0t] Addr 0x0000: Read 0x%h", $time, read_data);
    
    // simple write at mem location 1
    ahb_write(16'h0001, 32'h12345678);
    ahb_read(16'h0001, read_data);
    $display("[%0t] Addr 0x0001: Read 0x%h", $time, read_data);

    $finish;
  end

endmodule