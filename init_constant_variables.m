function  init_constant_variables(sample_id)
% These paarmeters should not change by user 

global num_objectives;
global num_input num_output num_genomes num_genomes_start num_try_find_edge_in_mute_edge;
global global_node_num global_geneom_num global_inn_num perc_random_check_for_add_to_niches;
global min_inp min_outp max_outp min_output max_output;
global max_try_cross_over;
global N_fathers;
global global_num_niches;
global try_found_elite_GA;
global N_nodetypes max_hist_node  W_dis_node W_dis_edge;
global max_edge_for_one_genome max_node_for_one_genome;
global perc_bests;
global MIN_OBJ RANK_0;
global dt_dynamic_simulate;

MIN_OBJ=-10^10;
RANK_0 =10^6;
perc_bests=0.1;
max_try_cross_over=5;

N_nodetypes=3;% simgmoid, lineartrrucn, tanhyper,
if sample_id<=50 && sample_id>45
	max_hist_node=0;% second derivitive
else
	max_hist_node=2;% second derivitive
	end
num_objectives=1;% Single Objective

W_dis_node=0.5;
W_dis_edge=0.5;
num_genomes_start=1*num_genomes;% for growing num of genomes

try_found_elite_GA=4; % number of tries to fins something in global GA
num_try_find_edge_in_mute_edge=1;
global_node_num=num_input+num_output;
global_geneom_num=num_genomes_start;
global_inn_num=num_input*num_output;
perc_random_check_for_add_to_niches=0.1;
dt_dynamic_simulate = 1;

min_outp = min_output;
max_outp = max_output;
num_input=length(min_inp);
num_output=length(min_outp);
max_node_for_one_genome=5*(num_input+num_output)*2;
max_edge_for_one_genome=5*max_node_for_one_genome^2/2;

N_fathers=0;
global_num_niches=1;

end



