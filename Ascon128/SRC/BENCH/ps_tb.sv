//GARDES mickaël
//17/03/2025
//test bench pour le bloc de substitution

`timescale 1ns / 1ps
module ps_tb import ascon_pack::*;();
//déclaration des signaux
type_state state_i_s;
type_state substitution_o_s;
//instance du module sbox
ps DUT(
	.state_i(state_i_s),
	.substitution_o(substitution_o_s)
			);
//stimuli 
	initial begin 
		//valeur du state avant ps pour round = 0
		state_i_s[0] = 64'h00001000808C0001 ;
		state_i_s[1] = 64'h6CB10AD9CA912F80 ;
		state_i_s[2] = 64'h691AED630E8190EF ;
		state_i_s[3] = 64'h0C4C36A20853217C ;
		state_i_s[4] = 64'h46487B3E06D9D7A8 ;

	
	end 
endmodule : ps_tb
