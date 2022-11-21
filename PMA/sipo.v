/*
******************************************************************************
*
*  Filename     :   sipo.v
*i
*  Description  :   This module takes a serial input and generates parallel output.
                    For this module I adjoin a testbench together with its stimulations 
                    referenced as "sipo_tb.v" to output a vvp file and checking its functionality.
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
module sipo(
//Declare Inputs here
    input clk, //A global variable that works in the whole circuit.
    input reset,//A control signal of this module
    input s_in,
    //Desclare Outputs here
    output reg[9:0]parallel_out); //This is the parallel bitstream coming from rx_code-group
//Declare parameters here

//Declare Regsiters here
reg [9:0] temp_2;// A  shift register that stores the bits to output as parallel bistream.
//Declare Wires here 
//sesisbility list
always @(posedge clk) begin
    if (reset == 1)
    //Write to output
    parallel_out <= 10'b0;

    else if(reset == 0)begin
      temp_2 <= temp_2>>1;
      temp_2[9] <= s_in;//From [9] fill out with serialIinput inpit (s_in)||||tx_bit
    end
    if (temp_2[0] == 1'b0 || temp_2[0] == 1'b1) begin
        parallel_out = temp_2; 
    end
end
endmodule 