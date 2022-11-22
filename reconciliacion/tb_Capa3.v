`include "supcapa3.v"

module tb_capa3;
reg [7:0]rxd;
reg rx_er;
reg rx_clk;
reg rx_dv;
wire data_valid;
wire [2:0]data_indication;

data_indication dut(
  .rxd (rxd),
  .rx_clk (rx_clk),
  .rx_dv (rx_dv),
  .rx_er (rx_er),
  .data_valid (data_valid),
  .data_indication (data_indication)
);

initial begin
  $dumpfile("tb_capa3.vcd");
	$dumpvars(-1, dut);
end

always begin
 #5 rx_clk = ~rx_clk;
end

initial begin
  //inicializacion de las variables
  rx_clk =1;
  rxd = 0;
  rx_er =0;
  rx_dv =0;
  //empezamos ya con algunas pruebas
  #20 rx_dv = 0; rx_er = 1; rxd =8'h0F ;
  #20 rx_dv = 0; rx_er = 1; rxd =8'h1F ;
  #20 rx_dv = 1; rx_er = 0; rxd =8'h4F ;
  #20 rx_dv = 1; rx_er = 1; rxd =8'h5F ;

end
initial #200 $finish;
endmodule



