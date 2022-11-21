`timescale 1ps/1ps
`include "piso.v"
module piso_tb;
localparam length = 10;//Length of the vector. in this case is 10-bit vector from PCS sublayer
    //declare wires here
    //wire s_out;
    //declare registers here
    reg clk;
    reg reset;
    reg s_start;
    reg [9:0]parallel_in;
    reg [9:0] temp;
    
initial begin
	$dumpfile("PISO.vcd");
	$dumpvars(-1, uut);
end


//instantiate
piso uut(
    .clk (clk),
    .reset (reset),
    .s_start (s_start),
    .parallel_in (parallel_in)
    //.s_out (s_out)
    );


//clock toggle
always begin
    #1 clk = ~clk;
end
initial begin
    s_start = 0;
    clk = 0;
    #2 parallel_in = 10'b1010101111;
    reset = 1;
    #2 reset = 0;
    s_start =1;
end 
initial #50 $finish;
endmodule