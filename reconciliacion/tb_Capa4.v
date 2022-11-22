`include "supcapa4.v"
module tb_capa4;
reg clk;
reg crs;
wire pls_carrier_indication;

carrier_indication dut(
    .clk (clk),
    .crs (crs),
    .pls_carrier_indication (pls_carrier_indication)
);


initial begin
  $dumpfile("tb_capa4.vcd");
	$dumpvars(-1, dut);
end


always begin
 #1 clk = ~clk;
end

initial begin
  clk = 1;
  crs = 0;
  #10 crs = 1;  
  #20 crs = 0;
  #20 crs = 1;
end
initial #100 $finish;
endmodule

