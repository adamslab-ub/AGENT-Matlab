function [num_win_tor_num_enter_tor,D_now] = change_based_on_diversit_and_improvment(run_step,max_run_step,Best_it,ave_it,sample_id)

global D_init k_diversity;
global num_enter_tor num_win_tor;
global K_DCHANGE_SP alpha_chang_tour min_max_R_touramneent Acceptabe_tol_in_Tor_ratio max_try_find_a_good_ratio;
global K_ICHANGE_MUTATION  min_mute max_mute;

global num_genomes;

D_now=getdiversity;
D_now

I_Best=get_improvment(Best_it);
I_Aver=get_improvment(ave_it);

CHANGE_D=D_now-D_init*(max_run_step-run_step)/(k_diversity*max_run_step);
CHANGE_D=-CHANGE_D;

if run_step>1% will be dvi0 for runstep==1
    CHANGE_I=(I_Best-I_Aver)/abs(I_Best);% simpler
    CHANGE_I=-CHANGE_I;
end
num_win_tor0=num_win_tor;
num_enter_tor0=num_enter_tor;
K_DCHANGE_SP0=K_DCHANGE_SP;
num_win_tor_num_enter_tor=num_win_tor/num_enter_tor;
[num_win_tor,num_enter_tor]=find_good_tournomant_size(CHANGE_D,num_win_tor0,num_enter_tor0,K_DCHANGE_SP,alpha_chang_tour,min_max_R_touramneent,Acceptabe_tol_in_Tor_ratio,max_try_find_a_good_ratio,num_genomes,run_step,sample_id);
if run_step>1
    find_good_Mutations(CHANGE_I,K_ICHANGE_MUTATION,min_mute,max_mute,run_step,sample_id);
end

end

