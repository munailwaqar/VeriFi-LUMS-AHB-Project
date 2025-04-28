module ahb3lite_test #(parameter HADDR_SIZE = 32, HDATA_SIZE = 32) (
  input logic HCLK,
  input logic HRESETn,
  ahb3lite_if.master bus
);
timeunit 1ns;
timeprecision 1ns;

  initial begin
    bus.HADDR  <= '0;
    bus.HWRITE <= 1'b0;
    bus.HSEL   <= 1'b1;
    bus.HTRANS <= 2'b00; // Start in IDLE
    bus.HWDATA <= '0;
    bus.HSIZE  <= 3'b010; // word
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
    bus.HTRANS <= 2'b00; // back to IDLE
    repeat(2) @(posedge HCLK);
  endtask

  task automatic ahb_read(input logic [HADDR_SIZE-1:0] addr, output logic [HDATA_SIZE-1:0] data);
    // Address phase
    @(posedge HCLK);
    bus.HTRANS <= 2'b10; // NONSEQ
    bus.HADDR  <= addr;
    bus.HWRITE <= 1'b0;
    do @(posedge HCLK); while (bus.HREADY !== 1'b1);
    data = bus.HRDATA;
    bus.HTRANS <= 2'b00; // back to IDLE
  endtask

  task automatic run_test();
    logic [HDATA_SIZE-1:0] write_data, read_data;
    $display("[%0t] Starting AHB-Lite test", $time);
    
    // simple write at mem location 0
    write_data = 32'hA5A5A5A5;
    ahb_write(32'h0000, write_data);    
    ahb_read(32'h0000, read_data);
    $display("[%0t] Addr 0x0000: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
    
    // simple write at mem location 1
    write_data = 32'h12345678;
    ahb_write(32'h0004, write_data);
    ahb_read(32'h0004, read_data);
    $display("[%0t] Addr 0x0004: Wrote 0x%h, Read 0x%h", $time, write_data, read_data);
  endtask

  initial begin
    wait(HRESETn);
    repeat(2) @(posedge HCLK);
    
    run_test();
    
    $finish;
  end

endmodule
