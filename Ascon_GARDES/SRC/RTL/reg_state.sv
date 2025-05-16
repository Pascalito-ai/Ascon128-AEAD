//Gardes
//28 mars 2025
//bascule D ASCON
`timescale 1ns / 1ps
module reg_state import ascon_pack::*;(
	input type_state d_i,
	input logic clock_i,
	input logic resetb_i,
	input logic enable_i,
	output type_state q_o
	
);

	type_state q_s;
	//sequential process
	always_ff @(posedge clock_i or negedge resetb_i) begin : seq_0
		if (resetb_i == 1'b0)
		//nonblocking assignment <=
			q_s <= {'0,'0,'0,'0,'0};
		else begin
			if( enable_i == 1'b1)
				q_s <= d_i;
			else
				q_s <= q_s; //memorisation
			end
	end : seq_0
	assign q_o = q_s;
endmodule : reg_state
