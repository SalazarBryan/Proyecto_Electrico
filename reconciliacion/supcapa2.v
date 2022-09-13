module signal_indication(
    input clk,
    input col,
    output reg pls_signal_indication 
);
always @(posedge clk) begin
    if (!col)
    pls_signal_indication = 0;
    else
    pls_signal_indication = 1;
end

endmodule