 
`timescale 1ns / 1ps


module XOR_end_tb import ascon_pack::*;();


//signaux internes
logic[1:0] bypass_xor_end_s;
type_state state_i_s;
logic[127:0] key_s;
type_state state_o_s;

XOR_end dut ( 
	.bypass_xor_end_i(bypass_xor_end_s),
	.state_i(state_i_s),
	.key_i(key_s),
	.state_o(state_o_s)
);
initial begin 
key_s= 128'h691AED630E81901F6CB10AD9CA912F80;
bypass_xor_end_s = 2'b00;
state_i_s[0] = 64'h00001000808C0001 ;
state_i_s[1] = 64'h6CB10AD9CA912F80 ;
state_i_s[2] = 64'h691AED630E81901F ;
state_i_s[3] = 64'h0C4C36A20853217C ;
state_i_s[4] = 64'h46487B3E06D9D7A8 ;

#10

bypass_xor_end_s = 2'b00;
state_i_s[0] = 64'h00001000808C0001 ;
state_i_s[1] = 64'h6CB10AD9CA912F80 ;
state_i_s[2] = 64'h691AED630E81901F ;
state_i_s[3] = 64'h0C4C36A20853217C ;
state_i_s[4] = 64'h46487B3E06D9D7A8 ;
end
endmodule
