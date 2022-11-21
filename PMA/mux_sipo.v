/*
******************************************************************************
*
*  Filename     :   mux_sipo.v
*i
*  Description  :   This module describes the multiplexer which passes dat to the input
                    of the sipo module. This mux is governed by EWRAP control signal and passes
                    data from two inputs: PMD_UNITDATA_indication and s_out which is the output of piso module
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
module mux_sipo(

    //Declare Inputs here
    input serial_sipo,
    input PMD_UNITDATA_indication,
    input EWRAP,
    //Declare Outputs here
    output reg mux_sipo_out);

//Declare registers here

//Declare wires here


always @(serial_sipo,PMD_UNITDATA_indication,EWRAP) begin
    if (EWRAP == 1) begin
     mux_sipo_out = serial_sipo;
    end
else
     mux_sipo_out = PMD_UNITDATA_indication;
end
endmodule