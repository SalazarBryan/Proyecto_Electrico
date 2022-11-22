
//aqui iran todos los modulos puestos junto con testbench
`include "supcapa1v2.v"
`include "supcapa2.v"
`include "supcapa3.v"
`include "supcapa4.v"
module recon_final;
//tb_Capa1
reg reset;
reg clk;
reg [4:0]pls_data_request;
wire gtx_clk;
wire [7:0]txd;
wire tx_en;
wire tx_er;
//tbcapa2
reg col;
wire pls_signal_indication;
//tb_Capa3
reg [7:0]rxd;
reg rx_er;
reg rx_clk;
reg rx_dv;
wire data_valid;
wire [2:0]data_indication;
//tb_capa4
reg crs;
wire pls_carrier_indication;

//empezamos a intanciar los modulos

capa1v2 dut(
  .clk (clk),
  .reset (reset),
  .txd (txd),
  .tx_en (tx_en),
  .tx_er (tx_er),
  .gtx_clk (gtx_clk),
  .pls_data_request (pls_data_request)
);

supcapa2 dut1(
    .clk (clk),
    .col (col),
    .pls_signal_indication (pls_signal_indication)
);

data_indication dut2(
  .rxd (rxd),
  .rx_clk (rx_clk),
  .rx_dv (rx_dv),
  .rx_er (rx_er),
  .data_valid (data_valid),
  .data_indication (data_indication)
);

carrier_indication dut3(
    .clk (clk),
    .crs (crs),
    .pls_carrier_indication (pls_carrier_indication)
);

initial begin
  $dumpfile("tb_recon.vcd");
	$dumpvars(-1, dut);
    $dumpvars(-1, dut1);
    $dumpvars(-1, dut2);
    $dumpvars(-1, dut3);
end

always begin
 #5 clk = ~clk; 
end

always begin
 #10 rx_clk = ~rx_clk; 
end

initial begin
  //inicial capa de todos
  
  clk =1;
  col = 0;
  reset =1;
  rx_clk =0;
  rxd = 0;
  rx_er =0;
  rx_dv =0;
   crs = 1;
  #10 reset =0;
  //supcapa1
  #20 pls_data_request = 5'b00001;//cero
  #20 pls_data_request = 5'b00010;//uno
  #20 pls_data_request = 5'b00100;//extend error
  #20 pls_data_request = 5'b01000;//extend
  //supcapa2
  #20 col = 1;
  #20 col = 0;
  #20 col = 1;
  //supcapa3
  #20 rx_dv = 0; rx_er = 1; rxd =8'h0F ;
  #20 rx_dv = 0; rx_er = 1; rxd =8'h1F ;
  #20 rx_dv = 1; rx_er = 0; rxd =8'h4F ;
  #20 rx_dv = 1; rx_er = 1; rxd =8'h5F ;
  //supcapa4
  #20 crs = 1;  
  #20 crs = 0;
  #20 crs = 1;
end

initial #600 $finish;
endmodule 