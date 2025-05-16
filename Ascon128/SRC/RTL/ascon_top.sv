//Gardes
//1 mai 2025
//module top level d'Ascon

 `timescale 1ns/1ps

module ascon_top import ascon_pack::*;(  
	input logic clock_i,
	input logic resetb_i,
	input logic start_i,
	input logic data_valid_i, 
	input logic [127:0] data_i,
	input logic [127:0] key_i,
	input logic [127:0] nonce_i,
	output logic end_o,
	output logic cipher_valid_o,
	output logic [127:0] cipher_o,
	output logic [127:0] tag_o,
	output logic end_cipher_o,
	output logic end_init_o,
	output logic end_associate_o
);
//Déclaration des signaux internes
	logic input_mode_s;
	logic [3:0] round_s;
	logic en_reg_cipher_s;
	logic en_reg_tag_s;
	logic en_reg_state_s;
	type_state permutation_o;
	logic [1:0] bypass_xor_end_s;
	logic [1:0] bypass_xor_begin_s;
	logic en_cpt_double_s;
	logic init_a_s;
	logic init_b_s;

	machine_etat_ascon FSM(
		.data_valid_i(data_valid_i),
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.round_i(round_s),
		.start_i(start_i),
		.cipher_valid_o(cipher_valid_o),
		.input_mode_o(input_mode_s),
		.en_reg_tag_o(en_reg_tag_s),
		.en_reg_cipher_o(en_reg_cipher_s),
		.end_o(end_o),
		.end_init_o(end_init_o),
		.end_associate_o(end_associate_o),
		.end_cipher_o(end_cipher_o),
		.bypass_xor_end(bypass_xor_end_s),
		.bypass_xor_begin(bypass_xor_begin_s),
		.en_cpt_double_o(en_cpt_double_s),
		.en_reg_state_o(en_reg_state_s),
		.init_a_o(init_a_s),
		.init_b_o(init_b_s)
);

	permutation_full perm_full(
		.key_i(key_i),
		.data_i(data_i),
		.nonce_i(nonce_i),
		.bypass_xor_end_i(bypass_xor_end_s),
		.bypass_xor_begin_i(bypass_xor_begin_s),
		.tag_o(tag_o),
		.cipher_o(cipher_o),
		.permutation_o(permutation_o),
		.en_reg_tag_i(en_reg_tag_s),
		.en_reg_cipher_i(en_reg_cipher_s),
		.enable_i(en_reg_state_s),
		.resetb_i(resetb_i),
		.clock_i(clock_i),
		.round_i(round_s),
		.input_mode_i(input_mode_s)

		
);
// compteur de rondes 
	compteur_double_init compteur_round(
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.en_i(en_cpt_double_s),
		.init_a_i(init_a_s),
		.init_b_i(init_b_s),
		.cpt_o(round_s)
);

endmodule : ascon_top
