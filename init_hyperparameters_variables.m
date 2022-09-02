function  init_hyperparameters_variables(sample_id)
% This is the function user can modify, but it is optional to change it.

global num_input num_output num_genomes  min_w max_w  coeff_dis dis_limit;
global perc_elited_saves elite_perce_to_reproduce r_crosover r_mute_w0 r_unif unif_perc r_mute_enable0;
global r_mute_remove_node0 r_mute_add_edge0 r_mute_add_node0 perc_elited_to_mute_elite num_enter_tor;
global num_win_tor  perc_stall_from_mute perc_keep_all_stall perc_new_all_stall;
global min_num_niches max_num_niches;
global r_mute_change_node_change_type0 r_mute_change_node_change_time0 num_niches_fixed;
global max_edge_for_one_genome max_node_for_one_genome;
global min_mute max_mute;
global k_diversity alpha_imp K_DCHANGE_SP alpha_chang_tour min_max_R_touramneent Acceptabe_tol_in_Tor_ratio max_try_find_a_good_ratio;
global K_ICHANGE_MUTATION
global K_niche_neighborhood alpha_niche_neighborhood max_appearance_in_mating_pool;
global r_mute_w r_mute_remove_node r_mute_add_edge r_mute_add_node r_mute_change_node_change_type r_mute_change_node_change_time r_mute_enable

% These paarmeters can be chosen by user or use the default values

k_from_sample_MUTATION = 0.1;
k_from_sample_DIVERSITY = 0.1;

% sample_id_20_LEFT = mod(sample_id-1,20)+1;
% if sample_id_20_LEFT<=5
%     k_from_sample_MUTATION = 0.00;
%     k_from_sample_DIVERSITY = 0.00;
% elseif sample_id<=10
%     k_from_sample_MUTATION = 0.10;
%     k_from_sample_DIVERSITY = 0.00;
% elseif sample_id<=15
%     k_from_sample_MUTATION = 0.00;
%     k_from_sample_DIVERSITY = 0.10;
% elseif sample_id<=20
%     k_from_sample_MUTATION = 0.10;
%     k_from_sample_DIVERSITY = 0.10;
% end



% % % % % % % % % % % % % % % % if sample_id>= 25
% % % % % % % % % % % % % % % %     k_from_sample_MUTATION = 0.1;
% % % % % % % % % % % % % % % %     k_from_sample_DIVERSITY = 0.1;
% % % % % % % % % % % % % % % % else
% % % % % % % % % % % % % % % %    if sample_id<=5
% % % % % % % % % % % % % % % %        k_from_sample_MUTATION = 0.0;
% % % % % % % % % % % % % % % %    elseif sample_id<=10
% % % % % % % % % % % % % % % %        k_from_sample_MUTATION = 0.01;
% % % % % % % % % % % % % % % %    elseif sample_id<=15
% % % % % % % % % % % % % % % %        k_from_sample_MUTATION = 0.03;
% % % % % % % % % % % % % % % %    elseif sample_id<=20
% % % % % % % % % % % % % % % %        k_from_sample_MUTATION = 0.10;
% % % % % % % % % % % % % % % %    elseif sample_id<=25
% % % % % % % % % % % % % % % %        k_from_sample_MUTATION = 0.30;
% % % % % % % % % % % % % % % %    end
% % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % %    m_sample = mod(sample_id-1,5)+1;
% % % % % % % % % % % % % % % %    if m_sample<=1
% % % % % % % % % % % % % % % %        k_from_sample_DIVERSITY = 0.00;
% % % % % % % % % % % % % % % %    elseif m_sample<=2
% % % % % % % % % % % % % % % %        k_from_sample_DIVERSITY = 0.01;
% % % % % % % % % % % % % % % %    elseif m_sample<=3
% % % % % % % % % % % % % % % %        k_from_sample_DIVERSITY = 0.03;
% % % % % % % % % % % % % % % %    elseif m_sample<=4
% % % % % % % % % % % % % % % %        k_from_sample_DIVERSITY = 0.10;
% % % % % % % % % % % % % % % %    elseif m_sample<=5
% % % % % % % % % % % % % % % %        k_from_sample_DIVERSITY = 0.30;
% % % % % % % % % % % % % % % %    end
% % % % % % % % % % % % % % % %    
% % % % % % % % % % % % % % % % end

K_ICHANGE_MUTATION=1*[1.0,1.0,1.0,1.0,1.0,1.0,1.0]*k_from_sample_MUTATION;

k_diversity=1;% 1 or above
alpha_imp=1.1;
K_DCHANGE_SP=1.0*k_from_sample_DIVERSITY;
alpha_chang_tour=1;% keep it 1
min_max_R_touramneent=[0.1,.6];
Acceptabe_tol_in_Tor_ratio=0.25;
max_try_find_a_good_ratio=8;

min_mute=[0.01,0.005,0.002,0.01,0.01];
max_mute=[0.2 ,0.1  ,0.05 ,0.15,0.15];


% High vals and it works
% r_mute_w0=8*0.1;%.1;
% r_mute_add_edge0=20*0.007;%0.007;
% r_mute_add_node0=40*0.003;%0.003;
% r_mute_change_node_change_type0=50*0.01;%0.01;
% r_mute_change_node_change_time0=50*0.01;%0.01;


r_mute_w0=0.1;%.1;
r_mute_add_edge0=0.007;%0.007;
r_mute_add_node0=0.003;%0.003;
r_mute_change_node_change_type0=0.01;%0.01;
r_mute_change_node_change_time0=0.01;%0.01;

r_mute_enable0=0.8*r_mute_add_edge0;
r_mute_remove_node0=  0.8*r_mute_add_node0;

% r_mute_enable0=0*r_mute_add_edge0;
% r_mute_remove_node0=0*r_mute_add_node0;


r_mute_w=r_mute_w0;
r_mute_add_edge=r_mute_add_edge0;
r_mute_add_node=r_mute_add_node0;
r_mute_change_node_change_type=r_mute_change_node_change_type0;
r_mute_change_node_change_time=r_mute_change_node_change_time0;

r_mute_enable=r_mute_enable0;
r_mute_remove_node=r_mute_remove_node0;
% r_mute_enable=r_mute_enable0;
% r_mute_remove_node=r_mute_remove_node0;


num_niches_fixed=min(ceil(num_genomes/10),8);

min_w=-1;
max_w=+1;

coeff_dis=[1 1 .4];
dis_limit=.8;%Niching dis
min_num_niches=5;
max_num_niches=20;

perc_elited_saves=0.05;%0.02
elite_perce_to_reproduce=1.0;%0.7
r_crosover=0.85;
r_unif=0.9;
unif_perc=0.1;

max_node_for_one_genome=3*(num_input+num_output)*2;
max_edge_for_one_genome=3*max_node_for_one_genome^2/2;

perc_elited_to_mute_elite=0.001;%0.001
num_enter_tor=5;%5
num_win_tor=2;%2
perc_stall_from_mute=1;
perc_keep_all_stall=0.5;
perc_new_all_stall=0.25;

K_niche_neighborhood = 1;% definetly can be tubned
alpha_niche_neighborhood = 1;% definetly can be tubned

max_appearance_in_mating_pool = 2*2*num_win_tor;
end



