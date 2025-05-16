//Gardes
//14 avril 2025
//XOR_end

`timescale 1ns / 1ps

module XOR_begin import ascon_pack::*;(
		input logic [1:0] bypass_xor_begin_i,
		input type_state state_i,
		input logic [127:0] key_i,
		input logic [127:0] data_i,
		output type_state state_o
		);

always@(*) begin 
	case(bypass_xor_begin_i)
	//XOR pour les données associées
		2'b01 : begin
			 state_o[0] = state_i[0]^data_i[63:0];
			 state_o[1] = state_i[1]^data_i[127:64];	
			 state_o[2] = state_i[2];	
			 state_o[3] = state_i[3];	
			 state_o[4] = state_i[4];
		end



	// XOR pour le dernier padding et le XOR begin de la dernière permutation
	2'b10 : begin
			 state_o[0] = state_i[0]^data_i[63:0];
			 state_o[1] = state_i[1]^data_i[127:64];	
			 state_o[2] = state_i[2]^key_i[63:0];	
			 state_o[3] = state_i[3]^key_i[127:64];		
			 state_o[4] = state_i[4];
		end
		default : state_o = state_i;	
	endcase
end

endmodule
