//Mickaël Gardes
//11 mai 2025
//test bench pour la machine d'état d'ascon


`timescale 1ns/1ps

module machine_etat_ascon_tb import ascon_pack::*;
();



    logic clock_s;
    logic resetb_s;
    logic start_s;
    logic [3:0] round_s;
    logic data_valid_s;

    logic init_a_o_s;
    logic init_b_o_s;
    logic en_reg_state_s;
    logic en_cpt_double_s;
    logic [1:0] bypass_xor_begin_s;
    logic [1:0] bypass_xor_end_s;
    logic end_init_o_s;
    logic end_associate_o_s;
    logic end_cipher_o_s;
    logic end_o_s;
    logic en_reg_cipher_o_s;
    logic en_reg_tag_o_s;
    logic input_mode_o_s;
    logic cipher_valid_o_s;

//design under test
    machine_etat_ascon dut (
        .init_a_o(init_a_o_s),
        .init_b_o(init_b_o_s),
        .en_reg_state_o(en_reg_state_s),
        .en_cpt_double_o(en_cpt_double_s),
        .bypass_xor_begin(bypass_xor_begin_s),
        .bypass_xor_end(bypass_xor_end_s),
        .end_init_o(end_init_o_s),
        .end_associate_o(end_associate_o_s),
        .end_cipher_o(end_cipher_o_s),
        .end_o(end_o_s),
        .en_reg_cipher_o(en_reg_cipher_o_s),
        .en_reg_tag_o(en_reg_tag_o_s),
        .input_mode_o(input_mode_o_s),
        .cipher_valid_o(cipher_valid_o_s),
        .start_i(start_s),
        .round_i(round_s),
        .resetb_i(resetb_s),
        .clock_i(clock_s),
        .data_valid_i(data_valid_s)
    );


    always #10 clock_s = ~clock_s;

    initial begin

        clock_s = 0;
        resetb_s = 0;
        start_s = 0;
        round_s = 4'h0;
        data_valid_s = 0;


        #20;
        resetb_s = 1;


        #20;
        start_s = 1;
        #20;
        start_s = 0;

        // Laisser avancer quelques cycles
        #50;

        // Simuler progression de round_i dans 'init'
        repeat (11) begin
            round_s = round_s + 1;
            #20;
        end

        // Après init -> idle_da, on active data_valid pour passer à conf_da
        data_valid_s = 1;
        #20;
        data_valid_s = 0;
	round_s = 4'h4;
        // Simuler passage du bloc DA
        repeat (10) begin
            #20;
            round_s = round_s + 1;
        end

        // Passer à TC1 avec data_valid_i à 1
        data_valid_s = 1;
        #40;
        data_valid_s = 0;

        // Fin de simulation
        #100;
    end

endmodule : machine_etat_ascon_tb

