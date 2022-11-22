//testbench de la capa1 version 2 usando one hot
//entradas como reg
//salidas como wire
`include "supcapa1v2.v"
module tb_capa1v2;

reg reset;
reg clk;
reg [4:0]pls_data_request;
wire gtx_clk;
wire [7:0]txd;
wire tx_en;
wire tx_er;

// ponemos el dut de supcapa1v2.sv

capa1v2 dut(
  .clk (clk),
  .reset (reset),
  .txd (txd),
  .tx_en (tx_en),
  .tx_er (tx_er),
  .gtx_clk (gtx_clk),
  .pls_data_request (pls_data_request));

//el relog que marcara los procesos
always begin
 #5 clk = ~clk;
end

//para crear el archivo
initial begin
	$dumpfile("tb_Capa1.vcd");
	$dumpvars(-1, dut);
end

//empezamos pruebas
initial begin
  clk =1;
  reset =1;
  #10 reset =0;
  #20 pls_data_request = 5'b00001;//cero
  #20 pls_data_request = 5'b00010;//uno
  #20 pls_data_request = 5'b00100;//extend error
  #20 pls_data_request = 5'b01000;//extend
  
end
initial #200 $finish;


endmodule
