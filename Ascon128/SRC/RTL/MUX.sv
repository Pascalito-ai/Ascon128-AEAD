//Gardes
//28 mars 2025
//MUX ASCON
module MUX import ascon_pack::*;(
	input type_state b_i,
	input logic sel_i,
	input type_state a_i,
	output type_state s_o
);
always @(a_i or b_i or sel_i) 
	begin : p_mux
		if (sel_i == 1'b0) 
			s_o = a_i;
		else 
			s_o = b_i;
	end
endmodule : MUX
