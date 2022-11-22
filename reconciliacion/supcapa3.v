//capa del receptor
module data_indication(
    input [7:0]rxd,
    input rx_er,
    input rx_clk,
    input rx_dv,
    output reg [2:0]data_indication,// one,zero,extend en ese orden
    output reg data_valid
);
//inicio de la lógica
always @(posedge rx_clk) begin
    //Carrier extend
    if (rx_dv == 0 && rx_er == 1 && rxd == 8'h0F) begin
        data_indication = 3'b001;
        data_valid =1;
    end//fin del if
    //Carrier extend error
    else if (rx_dv == 0 && rx_er == 1 && rxd == 8'h1F)begin
      data_indication = 3'b110;//zero y one activados
      data_valid = 1;
    end//fin del else if
    //normal data reception
    else if (rx_dv == 1 && rx_er == 0 && rxd != 8'h0F)begin
        data_indication = 3'b110;
        data_valid = 1;
    end//fin del else if
    //data reception error
    else if (rx_dv == 1 && rx_er == 1 && rxd != 8'h0F)begin
      data_indication = 3'b110;
      data_valid = 0;
    end//fin del else if
end//fin del always

endmodule //fin del modulo



