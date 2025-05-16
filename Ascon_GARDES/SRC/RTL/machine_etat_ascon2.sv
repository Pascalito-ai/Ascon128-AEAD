//Gardes
//15 avril 2025
//machine de moore pilotant les signaux de controles d'Ascon
//tentative de l'ajout du compteur bloc

 `timescale 1ns/1ps

module machine_etat_ascon2 import ascon_pack::*;(

output logic init_a_double_o,
output logic init_b_double_o,
output logic en_reg_state_o,
output logic en_cpt_double_o,
output logic en_cpt_simple_o,
output logic init_a_simple_o,
output logic [1:0] bypass_xor_begin,
output logic [1:0] bypass_xor_end,
output logic end_init_o,
output logic end_associate_o,
output logic end_cipher_o,
output logic end_o,
output logic en_reg_cipher_o,
output logic en_reg_tag_o,
output logic input_mode_o,
output logic cipher_valid_o,
input logic start_i,
input logic [3:0] round_i,
input logic [2:0] bloc_i,
input logic resetb_i,
input logic clock_i,
input logic data_valid_i
);

//definir type enuméré

typedef enum { //initialisation
		idle, conf_init, end_conf_init, init, end_init, idle_da, 
		//Données Associés 
		conf_da,end_conf_da, da, end_da, idle_TC,
		//Texte clair
		conf_TC,end_conf_TC, TC,end_TC, idle_finalisation,
		//Finalisation
		conf_finalisation,end_conf_finalisation, finalisation, end_finalisation
		}state_t;

//déclaration de 2 variables Pour l'état

	state_t current_state;
	state_t next_state;

//modélisation du registre des états

	always_ff @(posedge clock_i, negedge resetb_i)
		begin : seq_0
			if( resetb_i == 1'b0)
				current_state <= idle; 
			else current_state <= next_state; 
		end : seq_0

//modélisation des transitions

	always_comb 
		begin : comb_0
			case(current_state)
			idle : if(start_i == 1'b1)
			       	next_state = conf_init;
			       else next_state = idle;

			conf_init : next_state = end_conf_init;

			end_conf_init : next_state = init;

			init : if(round_i == 4'hA)
				next_state = end_init;
			       else next_state = init;	

			end_init : next_state = idle_da;

			idle_da : if (data_valid_i == 0)
				   next_state = idle_da;
				  else next_state = conf_da;
			conf_da:  next_state = end_conf_da;
			
			end_conf_da : next_state = da;

			da: if(round_i == 4'hA)
				next_state= end_da;
			    else next_state = da;

			end_da: next_state = idle_TC;
			

			idle_TC: if (data_valid_i == 0)
				   next_state = idle_TC;
				  else next_state = conf_TC;

			conf_TC:  next_state = end_conf_TC;
	
			end_conf_TC: next_state = TC;

			TC: if(round_i == 4'hA && bloc_i == 3'h4)
				next_state= end_TC;
			    else if (round_i == 4'hA)
				next_state = idle_TC;
			    else next_state = TC;

			end_TC : next_state = idle_finalisation; 

			idle_finalisation : next_state = conf_finalisation;
		
			conf_finalisation : next_state = end_conf_finalisation;
		
			end_conf_finalisation : next_state = finalisation;

			finalisation : if(round_i == 4'hA)
						next_state = end_finalisation;
					else next_state = finalisation;
			end_finalisation : next_state = idle;
			
			default : next_state = idle;

			endcase
		end : comb_0

//modélisation des sorties 

	always_comb 
		begin : comb_1
				en_cpt_double_o = 1'b0;
				init_a_double_o = 1'b0;
				init_b_double_o = 1'b0;
				en_reg_state_o = 1'b0;
				bypass_xor_begin = 2'b00;
				bypass_xor_end = 2'b00;
				end_init_o =1'b0;
				end_associate_o = 1'b0;
				end_cipher_o = 1'b0;
				end_o = 1'b0;
				input_mode_o = 1'b0;
				en_reg_cipher_o = 1'b0;
				en_reg_tag_o = 1'b0;
				cipher_valid_o = 1'b0;
				init_a_simple_o = 1'b0;
				en_cpt_simple_o = 1'b0;

			case(current_state)
			idle : begin 
					en_cpt_double_o = 1'b0;
					init_a_double_o = 1'b0;
					init_b_double_o = 1'b0;
					en_reg_state_o = 1'b0;
					bypass_xor_begin = 2'b00;
					bypass_xor_end = 2'b00;
					end_init_o =1'b0;
					end_associate_o = 1'b0;
					end_cipher_o = 1'b0;
					end_o = 1'b0;
					input_mode_o = 1'b0;
					en_reg_cipher_o = 1'b0;
					en_reg_tag_o = 1'b0;
					cipher_valid_o = 1'b0;
				end

			conf_init : begin
					init_a_double_o = 1'b1;
					init_a_simple_o = 1'b1;
					input_mode_o = 1'b1;
				    end  

			end_conf_init : begin
					  en_reg_state_o = 1'b1;
					  en_cpt_double_o = 1'b1;
					  input_mode_o = 1'b1;
					  en_cpt_simple_o = 1'b1;
				        end

			init : begin 
					en_reg_state_o =  1'b1;
					en_cpt_double_o = 1'b1;


			       end

			end_init : begin
					bypass_xor_end = 2'b01;
					en_reg_state_o =  1'b1;
				   end

			idle_da : begin

					end_init_o = 1'b1;
					
				  end
			conf_da: begin
					init_b_double_o = 1'b1;
					en_cpt_double_o = 1'b1;
					end_init_o = 1'b1;

				 end
			end_conf_da : begin
					en_cpt_double_o = 1'b1;
					en_reg_state_o = 1'b1;
					bypass_xor_begin = 2'b01;
					end_init_o = 1'b1;
					en_cpt_simple_o = 1'b1;

					end
			da: begin 
					en_cpt_double_o = 1'b1;
					en_reg_state_o = 1'b1;

			    end
				

			end_da: begin
					bypass_xor_end = 2'b10;
					en_reg_state_o =  1'b1;

				 end



			idle_TC: begin
					end_associate_o = 1'b1;
					end_cipher_o = 1'b1;

				 end

			conf_TC:  begin
					en_cpt_double_o = 1'b1;
					init_b_double_o = 1'b1;
					end_associate_o = 1'b1;
					end_cipher_o = 1'b1;


				   end
			end_conf_TC: begin 
					en_cpt_double_o = 1'b1;
					en_reg_state_o = 1'b1;
					bypass_xor_begin = 2'b01;
					end_associate_o = 1'b1;
					en_reg_cipher_o = 1'b1;
					cipher_valid_o = 1'b1;
					en_cpt_simple_o = 1'b1;


				      end

			TC: begin
					en_cpt_double_o = 1'b1;
					en_reg_state_o = 1'b1;


			     end
			end_TC : begin 
					en_reg_state_o = 1'b1;
				end
		
			idle_finalisation : begin
					   end_cipher_o = 1'b1;
					    end
		
			conf_finalisation : begin
						en_cpt_double_o = 1'b1;
						init_a_double_o = 1'b1;
						end_cipher_o = 1'b1;
 					    end
			end_conf_finalisation: begin 
						en_reg_state_o = 1'b1;
						en_cpt_double_o = 1'b1;
						bypass_xor_begin = 2'b10;
						en_reg_cipher_o = 1'b1;
						cipher_valid_o = 1'b1;
						end_cipher_o = 1'b1;
					        en_cpt_simple_o = 1'b1;
					       end

			finalisation : begin
					en_cpt_double_o = 1'b1;
					en_reg_state_o = 1'b1;

	 			       end

			end_finalisation : begin
						bypass_xor_end = 2'b11;
						en_reg_state_o =  1'b1;
						en_reg_tag_o = 1'b1;
					        end_o = 1'b1;
					   end
     			

			default : begin 
					en_cpt_double_o = 1'b0;
					init_a_double_o = 1'b0;
					init_b_double_o = 1'b0;
					en_reg_state_o = 1'b0;
					en_cpt_double_o = 1'b0;
					bypass_xor_begin = 2'b00;
					bypass_xor_end = 2'b00;
					end_init_o =1'b0;
					end_associate_o = 1'b0;
					end_cipher_o = 1'b0;
					end_o = 1'b0;
					input_mode_o = 1'b0;
					en_reg_cipher_o = 1'b0;
					en_reg_tag_o = 1'b0;
				end

			endcase


		end : comb_1

endmodule : machine_etat_ascon2
