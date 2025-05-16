// Mickaël Gardes
// 06/05/2025
// Testbench pour la permutation complète 

`timescale 1ns / 1ps

module permutation_full_tb
    import ascon_pack::*;
();

logic clock_s;
logic resetb_s;
logic enable_s;
type_state state_i_s;
logic [127:0] data_s;
logic [127:0] key_s;
logic [127:0] nonce_s;
logic [3:0] round_s;
logic input_mode_s;
logic [1:0] bypass_xor_begin_s;
logic [1:0] bypass_xor_end_s;
logic en_reg_cipher_s;
logic en_reg_tag_s;

type_state state_o_s;
logic [127:0] cipher_s;
logic [127:0] tag_s;

permutation_full DUT (
    .input_mode_i(input_mode_s),
    .round_i(round_s),
    .clock_i(clock_s),
    .resetb_i(resetb_s),
    .enable_i(enable_s),
    .en_reg_cipher_i(en_reg_cipher_s),
    .en_reg_tag_i(en_reg_tag_s),
    .permutation_o(state_o_s),
    .cipher_o(cipher_s),
    .tag_o(tag_s),
    .bypass_xor_end_i(bypass_xor_end_s),
    .bypass_xor_begin_i(bypass_xor_begin_s),
    .key_i(key_s),
    .data_i(data_s),
    .nonce_i(nonce_s)
);

initial begin
    clock_s = 1'b0;
    forever #10 clock_s = ~clock_s;
end

initial begin
    resetb_s = 1'b0;
    input_mode_s = 1'b1;
    enable_s = 1'b1;
    en_reg_cipher_s = 1'b0;
    en_reg_tag_s = 1'b0;
    round_s = 3'b0;
    bypass_xor_begin_s = 2'b00;
    bypass_xor_end_s = 2'b00;
    state_i_s = {64'h00001000808c0001, 64'h6cb10ad9ca912f80, 64'h691aed630e81901f, 64'h0c4c36a20853217c, 64'h46487b3e06d9d7a8};
    key_s = 128'h691AED630E81901F6CB10AD9CA912F80;
    data_s = 128'h00000001626F4220_6F74206563696C41;
    nonce_s = 128'h46487B3E06D9D7A80C4C36A20853217C;

    #35;
    resetb_s = 1'b1;
    #20;
    input_mode_s = 1'b0;
    for(int i = 1; i < 12; i++) begin
        round_s = i;
        #20;
        if(round_s == 10)
            bypass_xor_end_s = 2'b01;
    end
    bypass_xor_end_s = 2'b00;
    bypass_xor_begin_s = 2'b01;
    for(int i = 4; i < 12; i++) begin
        round_s = i;
        #20;
        if(round_s == 4) begin
            bypass_xor_begin_s = 2'b00;
    data_s = 128'h704F206572696420_7475657620657551;
        end            
        if(round_s == 10)
            bypass_xor_end_s = 2'b10;
    end
    bypass_xor_end_s = 2'b00;
    bypass_xor_begin_s = 2'b01;
    for(int i = 4; i < 12; i++) begin
        round_s = i;
        #20;
        if(round_s == 4) begin
            bypass_xor_begin_s = 2'b00;
    data_s = 128'h766E492065617275_74614E2061747265;
        end
    end
    bypass_xor_begin_s = 2'b01;
    for(int i = 4; i < 12; i++) begin
        round_s = i;
        #20;
        if(round_s == 4) begin
            bypass_xor_begin_s = 2'b00;
            data_s = 128'h013f206172656e754d20746e75696e65;
        end   
	if(round_s == 10) begin
	    bypass_xor_begin_s = 2'b11;
	end
    end
    bypass_xor_begin_s = 2'b10;
    for(int i = 0; i < 12; i++) begin
        round_s = i;
        #20;
        if(round_s == 0) begin
            bypass_xor_begin_s = 2'b00;
        end
        if(round_s == 10)
	    begin 
            bypass_xor_end_s = 2'b11;
	    en_reg_tag_s = 1'b1;
	    end
    end
    en_reg_tag_s = 1'b0;
    bypass_xor_end_s = 2'b00;
    enable_s = 1'b0;
    input_mode_s = 1'b0;
end




    
   
endmodule : permutation_full_tb

