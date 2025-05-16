//Gardes
//12 avril 2025
//test bench pour la boucle de permutation avec XOR_end 

`timescale 1ns / 1ps
module permutation_xor_tb import ascon_pack::*; 
();
//déclaration des signaux

type_state permutation_s;
type_state permutation_o_s;
logic input_mode_s;
logic [3:0] round_s;
logic clock_s;
logic resetb_s;
logic enable_s;
logic [1:0] bypass_xor_end_s;
logic [1:0] bypass_xor_begin_s;
logic [127:0] key_s;
logic [127:0] data_s;

//design under test
permutation_xor DUT
(		
	.permutation_i(permutation_s),
	.round_i(round_s),
	.resetb_i(resetb_s),
	.enable_i(enable_s),
	.clock_i(clock_s),
	.input_mode_i(input_mode_s),
	.permutation_o(permutation_o_s),
	.bypass_xor_end_i(bypass_xor_end_s),
	.bypass_xor_begin_i(bypass_xor_begin_s),
	.key_i(key_s),
	.data_i(data_s)
	
);
//Horloge 
always begin
	#10 clock_s=~clock_s;
	end

	initial 
	begin
		//initialisation
		permutation_s[0] = 64'h00001000808C0001 ;
		permutation_s[1] = 64'h6CB10AD9CA912F80 ;
		permutation_s[2] = 64'h691AED630E81901F ;
		permutation_s[3] = 64'h0C4C36A20853217C ;
		permutation_s[4] = 64'h46487B3E06D9D7A8 ;
		round_s = 0;
		resetb_s = 0;
		enable_s = 0;
		clock_s = 0;
		input_mode_s=1;
		bypass_xor_end_s = 2'b00;
		bypass_xor_begin_s = 2'b00;
		key_s= 128'h691AED630E81901F6CB10AD9CA912F80;
		data_s = 128'h0;
		//execution des 12 permutations
		
		#5;
		resetb_s=1;
		#15;
		enable_s = 1;
		#10;
		input_mode_s = 1'b0;
		round_s = 4'h1;
		#20;		
		round_s = 4'h2;
		#20;
		round_s = 4'h3;
		#20;
		round_s = 4'h4;
		#20;
		round_s = 4'h5;
		#20;
		round_s = 4'h6;
		#20;
		round_s = 4'h7;
		#20;
		round_s = 4'h8;
		#20;
		round_s = 4'h9;
		#20;
		round_s = 4'ha;
		#20;
		round_s = 4'hb;
		bypass_xor_end_s = 2'b01;// activation du XOR end
		#30;
		enable_s = 0;
		

	
	end

endmodule : permutation_xor_tb









	
