//Gardes
//12 avril 2025
//boucle de permutation avec les XOR sans les tag et cipher

`timescale 1ns / 1ps
module permutation_xor import ascon_pack::*;(
	input type_state permutation_i,
	input logic input_mode_i,
	input logic [3:0] round_i,
	input logic clock_i,
	input logic resetb_i,
	input logic enable_i,
	output type_state permutation_o,
	input logic [1:0] bypass_xor_end_i,
	input logic [1:0] bypass_xor_begin_i,
	input logic [127:0] key_i,
	input logic [127:0] data_i
);

//Déclaration des signaux internes
type_state add_to_sub_s;
type_state sub_to_diff_s;
type_state diff_to_xor_s;
type_state xor_to_reg_s;
type_state permutation_loop_s;
type_state mux_to_xor_s;
type_state xor_to_add_s;


// Sélection entre l’entrée externe ou la sortie de la boucle
MUX mux1(
	.a_i(permutation_loop_s),
	.b_i(permutation_i),
	.sel_i(input_mode_i),
	.s_o(mux_to_xor_s)
);


XOR_begin xor_begin1(
	.bypass_xor_begin_i(bypass_xor_begin_i),
	.key_i(key_i),
	.data_i(data_i),
	.state_i(mux_to_xor_s),
	.state_o(xor_to_add_s)
);
//Blocs élémentaires
constant_addition addition1(
	.state_i(xor_to_add_s),
	.round_i(round_i),
	.state_o(add_to_sub_s)
);

ps substitution1(
	.state_i(add_to_sub_s),
	.substitution_o(sub_to_diff_s)
);

diffusion diffusion1(
	.state_i(sub_to_diff_s),
	.diffusion_o(diff_to_xor_s)
);


XOR_end xor_end1(
	.bypass_xor_end_i(bypass_xor_end_i),
	.key_i(key_i),
	.state_i(diff_to_xor_s),
	.state_o(xor_to_reg_s)
);
// registre pour le state
reg_state reg_state1(
	.d_i(xor_to_reg_s),
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_i(enable_i),
	.q_o(permutation_loop_s)
);


	assign permutation_o = permutation_loop_s;


endmodule 















