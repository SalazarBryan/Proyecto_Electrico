`include "supcapa2.v"
module tb_capa2;
reg clk;
reg col;
wire pls_signal_indication;

supcapa2 dut(
    .clk (clk),
    .col (col),
    .pls_signal_indication (pls_signal_indication)
);

always begin
 #5 clk = ~clk;
end

initial begin
	$dumpfile("tb_Capa2.vcd");
	$dumpvars(-1, dut);
end

initial begin
  clk = 1;
  col = 0;
  #10 col = 1;
  #20 col = 0;
  #30 col = 1;  
end
initial #100 $finish;
endmodule
