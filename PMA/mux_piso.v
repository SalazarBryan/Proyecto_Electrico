/*
******************************************************************************
*
*  Filename     :   mux_piso.v
*i
*  Description  :   This module describes a multiplexer which passes data to 
                    PMD_UNITDATA_request. This mux is governed by EWRAP control signal and passes
                    data from two inputs: s_out which is the output of piso module and which is the output of piso module
                    and zeros which is 0's vector when EWRAP is diabled.
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
module mux_piso(
    //Declare Inputs here
    input serial,
    input zeros,
    input  EWRAP,
    //Declare Outputs here
    output reg PMD_UNITDATA_request);
//Declare registers here

//Declare wires here

always @(serial,zeros,EWRAP) begin
    if (EWRAP == 1) begin
     PMD_UNITDATA_request = serial;
    end
else
     PMD_UNITDATA_request = zeros;
end
endmodule