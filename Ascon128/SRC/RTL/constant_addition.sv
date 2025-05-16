//Gardes
//10 mars 2025
//addition de constante

`timescale 1ns / 1ps

module constant_addition 
	import ascon_pack::*;
( 
	input type_state state_i,
	input logic [3:0] round_i,
	output type_state state_o 
);

// On modifie les 8 derniers bits de S2 avec XOR et le tableau round_constant
	assign state_o[2][63:8] = state_i[2][63:8];
	assign state_o[2][7:0] = state_i[2][7:0]^round_constant[round_i];


// On ne modifie pas les registres 0,1,3 et 4 
	assign state_o[0] = state_i[0];
	assign state_o[1] = state_i[1];
	assign state_o[3] = state_i[3];
	assign state_o[4] = state_i[4];
endmodule : constant_addition
