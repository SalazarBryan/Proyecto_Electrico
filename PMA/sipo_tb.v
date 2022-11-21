`timescale 1ps/1ps
`include "sipo.v"

module sipo_tb;
    //declare wires here
    wire [9:0]parallel_out;
    //declare registers here
    reg clk;
    reg reset;
    reg s_in;
    reg [9:0] temp_2;
    //reg [9:0] parallel_out;

    //clock toggle
always begin
    #1 clk = ~clk;
end

sipo uut(
    .clk (clk),
    .reset (reset),
    .s_in (s_in),
    .parallel_out (parallel_out));

initial begin
    reset =1;
    clk = 0;
    s_in =1;
    #20 reset =0;
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 0;
    #20 s_in = 0;
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 1;

end
initial  begin
    $dumpfile("SIPO.vcd");
	$dumpvars(-1, uut);
end

initial #250 $finish;
endmodule