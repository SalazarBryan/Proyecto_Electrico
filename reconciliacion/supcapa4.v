module carrier_indication(
    input clk,
    input crs,
    output reg pls_carrier_indication
);
//Empezamos  con la lógica
always @(posedge clk) begin
    if (crs) begin
        pls_carrier_indication = 1;
    end
    else
    pls_carrier_indication = 0;
end// fin del always
endmodule
