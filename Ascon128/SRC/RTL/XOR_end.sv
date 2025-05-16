//Gardes
//12 avril 2025
//XOR_end

`timescale 1ns / 1ps
module XOR_end import ascon_pack::*;(
		input logic [1:0] bypass_xor_end_i,
		input type_state state_i,
		input logic [127:0] key_i,
		output type_state state_o
		);

always@(*) begin 
	case(bypass_xor_end_i)
	        //inisialisation
		2'b01 : begin
			 state_o[0] = state_i[0];
			 state_o[1] = state_i[1];	
			 state_o[2] = state_i[2];	
			 state_o[3] = state_i[3]^key_i[63:0];	
			 state_o[4] = state_i[4]^key_i[127:64];
		end
		
                //XOR lsb de S4  
		2'b10 : begin
			 state_o[0] = state_i[0];
			 state_o[1] = state_i[1];	
			 state_o[2] = state_i[2];	
			 state_o[3] = state_i[3];	
			 state_o[4] = state_i[4]^{1'b1, 63'h0};
		end
	
		//finalisation
		2'b11 : begin
			 state_o[0] = state_i[0];
			 state_o[1] = state_i[1];		
			 state_o[2] = state_i[2];	
			 state_o[3] = state_i[3]^key_i[63:0];	
			 state_o[4] = state_i[4]^key_i[127:64];
		end
		default : state_o = state_i;
			
	endcase
end

endmodule

	
