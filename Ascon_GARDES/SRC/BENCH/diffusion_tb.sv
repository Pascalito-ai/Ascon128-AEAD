//GARDES mickaël
//17/03/2025
//test bench du bloc de diffusion

`timescale 1ns / 1ps
module diffusion_tb import ascon_pack::*; ();
//déclaration des signaux
type_state state_i_s;
type_state diffusion_o_s;
//instance du module
diffusion DUT(
	.state_i(state_i_s),
	.diffusion_o(diffusion_o_s)
			);
//stimuli 
	initial begin 
		state_i_s[0] = 64'h25f7c341c45f9912 ;
		state_i_s[1] = 64'h23b794c540876856 ;
		state_i_s[2] = 64'hb85451593d679610 ;
		state_i_s[3] = 64'h4fafba264a9e49ba ;
		state_i_s[4] = 64'h62b54d5d460aded4 ;
		

		
		
	
	end 
endmodule :diffusion_tb
