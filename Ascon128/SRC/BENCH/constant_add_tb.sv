//Gardes
//10 mars 2025
//test bench d'addition de constante

`timescale 1ns / 1ps
module constant_add_tb import ascon_pack::*;( 
//empty declarative part
);
	// déclaration des signaux internes
 type_state state_s;
 logic [3:0] round_s;
 type_state state_o_s;

	
	//DUT : instanciation des composants
	constant_addition DUT 
(
		.state_i(state_s),
		.round_i(round_s),
		.state_o(state_o_s)
	);
//stimuler test
initial begin
	state_s[0] = 64'h00001000808C0001 ;
	state_s[1] = 64'h6CB10AD9CA912F80 ;
	state_s[2] = 64'h691AED630E81901F ;
	state_s[3] = 64'h0C4C36A20853217C ;
	state_s[4] = 64'h46487B3E06D9D7A8 ;
	round_s = 4'h0;

	#50	

	state_s[0] = 64'h932c16dd634b9585 ;
	state_s[1] = 64'hb48a3c3fe8fb45ce ;
	state_s[2] = 64'ha69f28b0c721c340 ;
	state_s[3] = 64'h05e1761f1e1fcb67 ;
	state_s[4] = 64'h64d322a896b791cf ;
	round_s = 4'h1;
	
end 
endmodule : constant_add_tb 
