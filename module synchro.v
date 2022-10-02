module synchronization(
					   input 			clk,
					   input 			rst,
					   input [9:0] 		rx_code_group,
					   output reg [9:0] rx_code_group_sync
					   );

  always @(posedge clk) begin
  	if (power_on == 1 || mr_main_reset == 1) begin
    	state  <= 13'b0000000000001; 
  	end else begin
    	state  <= nxt_state;
  	end
  end  					   

   always @(*)begin

	  nxt_state = state;
	  rx_code_group_sync = rx_code_group;
	
	case(state)
		13'b0000000000001: begin //PUDI=rx_code-group <9:0>
							if ((signal_detected == 0 && mr_loopback ==0)|| (rx_code_group != 7'b1100000)) nxt_state = 13'0000000000001;
							else if (signal_detected == 1 || mr_loopback ==1 && rx_code_group == 7'b1100000) nxt_state = 13'0000000000010;
		end
		
		//Segundo estado, COMMA_DETECT_1
		13'b0000000000010: begin
							if (rx_code_group[9:0] != 7'b1100000) nxt_state = 13'b000000000001;
							else nxt_state = 13'b0000000000100;
		end
		
		//Tercer estado, ACQUIRE_SYNC_1
		13'b0000000000100: begin
							if (((rx_code_group [9:0] != VALID) || (rx_code_group [9:0] == 7'b1100000 && rx_even ==1))&&rx_code_group[9:0]) nxt_state = 13'b000000000001; //VALID, lista de datos elegidos en la tabla 36-1a-e validos
							else if (rx_even == 0 && rx_code_group == 7'b1100000) nxt_state = 13'b0000000001000;
							else if (rx_code_group == VALID) nxt_state = 13'b0000000000100;
		end
		
		//Cuarto estado, COMMA_DETECT_2
		13'b0000000001000: begin
							if (rx_code_group[9:0] != 7'b1100000) nxt_state = 13'b000000000001;
							else nxt_state = 13'b0000000010000;
		end

	endcase
   end
endmodule // synchronization xdxdxdxdxprobando
