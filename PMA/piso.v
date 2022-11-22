

/*
******************************************************************************
*
*  Filename     :   piso.v
*i
*  Description  :   This module takes a parallel input and generates serial output.
                    For this module I adjoin a testbench together with its stimulations 
                    referenced as "piso_tb.v" to output a vvp file and check its functionality.
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
module piso(
    //Declare Inputs here
    input clk, //A global variable that works in the whole circuit.
    input reset,//A control signal of this module
    input [9:0]parallel_in, //This is the parallel bitstream coming from tx_code-group
    input s_start,
    //Desclare Outputs here
    output reg s_out);//This is the serial output chain towards pmd_unitdata.request

//Declare parameters here
localparam length = 10;//Length of the vector. in this case is 10-bit vector from PCS sublayer
//Declare Regsiters here
reg [9:0] temp;// A shift register that stores the bits to output as serial bistream.
//Declare Wires here 

//sesibility list
always @(posedge clk) begin
    //Set input to LOW
    if (reset==1)begin
        s_out = 0;
        temp = parallel_in;
    end
    else if(s_start == 1)begin
        s_out = temp[9];
        temp = {temp[9:0], 1'b0};
    end
end
endmodule 