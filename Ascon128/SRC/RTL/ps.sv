//GARDES mickaël
//17/03/2025
//Bloc élémentaire de substitution d'Ascon

`timescale 1ns / 1ps
module ps import ascon_pack::*;(
	input type_state state_i,
	output type_state substitution_o);
	genvar i; // Déclaration de la variable de génération utilisée pour la boucle generate


	generate 
	for(i=0; i<64; i++) 
		begin : g_sbox//label obligatoire
		//
		sbox sbox_inst(
			.sbox_i({state_i[0][i],state_i[1][i],state_i[2][i],state_i[3][i],state_i[4][i]}),
			// Assignation des sorties de la S-box aux bits correspondants dans substitution_o
			.sbox_o({substitution_o[0][i],substitution_o[1][i],substitution_o[2][i],substitution_o[3][i],substitution_o[4][i]})
				);

		end :g_sbox
	endgenerate 
endmodule :ps
