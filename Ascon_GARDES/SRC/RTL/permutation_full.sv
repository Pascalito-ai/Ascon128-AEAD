//Gardes Mickaël
//12 avril 2025
//boucle de permutation complète

`timescale 1ns / 1ps
module permutation_full import ascon_pack::*;(
	input logic input_mode_i,
	input logic [3:0] round_i,
	input logic clock_i,
	input logic resetb_i,
	input logic enable_i,
	input logic en_reg_cipher_i,
	input logic en_reg_tag_i,
	output type_state permutation_o,
	output logic [127:0] cipher_o,
	output logic [127:0] tag_o,
	input logic [1:0] bypass_xor_end_i,
	input logic [1:0] bypass_xor_begin_i,
	input logic [127:0] key_i,
	input logic [127:0] data_i,
	input logic [127:0] nonce_i
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
	.b_i({64'h00001000808C0001,key_i[63:0],key_i[127:64],nonce_i[63:0],nonce_i[127:64]}),// valeur initial du state
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
// registre pour le cipher 
register_w_en reg_cipher(
	.data_i({xor_to_add_s[1],xor_to_add_s[0]}),
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_reg_cipher_i),
	.data_o(cipher_o)
);
//Bloc élémentaire
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
// registre pour le tag 
register_w_en reg_tag(
	.data_i({xor_to_reg_s[4],xor_to_reg_s[3]}),
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_reg_tag_i),
	.data_o(tag_o)
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















