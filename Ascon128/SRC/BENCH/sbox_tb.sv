//GARDES mickaël
//17/03/2025
//sbox test bench

`timescale 1ns / 1ps
module sbox_tb import ascon_pack::*; ();
//déclaration des signaux
logic[4:0] sbox_i_s;
logic[4:0] sbox_o_s;
//instance du module sbox
sbox DUT(
	.sbox_i(sbox_i_s),
	.sbox_o(sbox_o_s)
			);
//stimuli 

	initial begin 
		sbox_i_s = 5'h00;
		#10;
		sbox_i_s = 5'h01;
		#10;
		sbox_i_s = 5'h02;
		#10;
		sbox_i_s = 5'h03;
		#10;
		sbox_i_s = 5'h04;
		#10;
		sbox_i_s = 5'h05;
		#10;
		sbox_i_s = 5'h06;
		#10;
		sbox_i_s = 5'h07;
		#10;
		sbox_i_s = 5'h08;
		#10;
		sbox_i_s = 5'h09;
		#10;
		sbox_i_s = 5'h0a;
		#10;
		sbox_i_s = 5'h0b;
		#10;
		sbox_i_s = 5'h0c;
		#10;
		sbox_i_s = 5'h0d;
		#10;
		sbox_i_s = 5'h0e;
		#10;
		sbox_i_s = 5'h0f;
		#10;
		sbox_i_s = 5'h10;
		#10;
		sbox_i_s = 5'h11;
		#10;
		sbox_i_s = 5'h12;
		#10;
		sbox_i_s = 5'h13;
		#10;
		sbox_i_s = 5'h14;
		#10;
		sbox_i_s = 5'h15;
		#10;
		sbox_i_s = 5'h16;
		#10;
		sbox_i_s = 5'h17;
		#10;
		sbox_i_s = 5'h18;
		#10;
		sbox_i_s = 5'h19;
		#10;
		sbox_i_s = 5'h1a;
		#10;
		sbox_i_s = 5'h1b;
		#10;
		sbox_i_s = 5'h1c;
		#10;
		sbox_i_s = 5'h1d;
		#10;
		sbox_i_s = 5'h1e;
		#10;
		sbox_i_s = 5'h1f;
		#10;
	end
endmodule : sbox_tb
