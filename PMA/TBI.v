/*
******************************************************************************
*
*  Filename     :   TBI.v
*i
*  Description  :   The ten-bit interface (TBI) is defined to provide compatibility among 
                    devices designed by different manufacturers.
*
*  Author       :   Jhon Gaitan Aguilar
*                   <JHON.GAITAN@ucr.ac.cr>
*
*  License      :   This program is free software: you can redistribute it and/or modify
*                   it under the terms of the GNU General Public License as published by
*                   the Free Software Foundation, either version 3 of the License, or
*                   (at your option) any later version.
*
*                   This program is distributed in the hope that it will be useful,
*                   but WITHOUT ANY WARRANTY; without even the implied warranty of
*                   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*                   GNU General Public License for more details.
*
*                   You should have received a copy of the GNU General Public License
*                   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*  
*  Created      :   11/18/2022
*
******************************************************************************
*/
`include "piso.v"
`include "sipo.v"
`include "mux_sipo.v"
`include "mux_piso.v"

module TBI;
    //Global params
    reg clk;
    reg reset;
    //PISO variables
    reg s_start;
    reg [9:0]parallel_in;
    reg [9:0]temp;
    wire s_out;
    //SIPO variables
    reg s_in;
    reg [9:0]temp_2;
    wire [9:0]parallel_out;
    //MUX_piso
    reg serial;
    reg zeros;
    wire PMD_UNITDATA_request;
    //MUX global
    reg EWRAP;
    //MUX SIPO
    wire PMD_UNITDATA_indication;
    wire mux_sipo_out;
    reg serial_piso;
    piso uut1(
        .clk (clk),
        .reset (reset),
        .s_start (s_start),
        .parallel_in (parallel_in),
        .s_out (s_out)
    );
    sipo uut2(
        .clk (clk),
        .reset (reset),
        .parallel_out (parallel_out),
        .s_in (mux_sipo_out)
    );
    mux_piso uut3(
        .serial (s_out),
        .zeros (zeros),
        .EWRAP (EWRAP),
        .PMD_UNITDATA_request (PMD_UNITDATA_request)
    );
    mux_sipo uut4(
        .serial_sipo (s_out),
        .PMD_UNITDATA_indication (PMD_UNITDATA_indication),
        .EWRAP (EWRAP),
        .mux_sipo_out (mux_sipo_out)
    );
initial  begin
    $dumpfile("TBI.vcd");
	$dumpvars(-1, uut1);
    $dumpvars(-1, uut2);
    $dumpvars(-1, uut3);
    $dumpvars(-1, uut4);
    
end

always begin
 #5 clk = ~clk;
end
initial begin
    s_start = 0;
    clk = 1;
    s_in =1;
    zeros =0;
    EWRAP =0;
    #10 parallel_in = 10'b1010101111;
    #10 EWRAP = 1;
    reset = 1;
    #10 reset =0; s_start =1;
    //#2 S_START =1;
    //hasta aqui piso
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 1;
    #20 s_in = 0;
    #20 s_in = 0;
    //#20 ewrap = 1;
    #20 s_in = 1;
    #20 s_in = 0;
    #20 s_in = 1;
    #20 s_in = 0;
    #20 s_in = 1;
end
initial #1000 $finish;
endmodule