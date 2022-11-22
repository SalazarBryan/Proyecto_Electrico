module supcapa2(
    input clk,
    input col,
    output reg pls_signal_indication 
);

//empezamos con la lógica
always @(posedge clk) begin
    if (!col)
    pls_signal_indication = 0;
    else
    pls_signal_indication = 1;
end//fin del always

endmodule
