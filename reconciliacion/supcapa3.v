module data_indication(
    input [7:0]rxd,
    input rx_er,
    input rx_clk,
    input rx_dv,
    output reg data_valid,
    output reg data_one,
    output reg data_zero,
    output reg data_extend
);
always @(posedge rx_clk) begin
    //carrier extend
    if (rx_dv == 0 && rx_er == 1 && rxd == 8'h0F) begin
        data_extend = 1;
    end
    //Carrier extend error
    else if (rx_dv == 0 && rx_er == 1 && rxd == 8'h1F)begin
      data_zero = 1;
      data_one = 1;
    end
    //normal data reception
     else if (rx_dv == 1 && rx_er == 0 && rxd != 8'h0F)begin
      data_zero = 1;
      data_one = 1;
    end
    //data reception error
    else if (rx_dv == 1 && rx_er == 1 && rxd != 8'h0F)begin
      data_zero = 1;
      data_one = 1;
    end
end

endmodule