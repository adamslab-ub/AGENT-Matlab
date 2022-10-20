function [num_win_tor,num_enter_tor]=find_good_tournomant_size(CHANGE_D,num_win_tor0,num_enter_tor0,K_DCHANGE_SP,alpha_chang_tour,min_max_R_touramneent,Acceptabe_tol_in_Tor_ratio,max_try_find_a_good_ratio,num_genomes_X,run_step,sample_id)

CHANGE_D = min(CHANGE_D, 0.1);

r1=num_win_tor0/num_enter_tor0;

r2=exp(CHANGE_D*K_DCHANGE_SP/alpha_chang_tour)*r1;

if r2<min_max_R_touramneent(1)
    r2=min_max_R_touramneent(1);
elseif r2>min_max_R_touramneent(2)
    r2=min_max_R_touramneent(2);
end


min_dif = 10^8;
for i=1:num_genomes_X
    for j=1:i-1
        if abs((j/i)-r2)<min_dif
            min_dif = abs((j/i)-r2);
            num_enter_tor = i;
            num_win_tor = j;
        end
    end
end

tournament0.num_win_tor=num_win_tor;
tournament0.num_enter_tor=num_enter_tor;
save(['Tournament Size of ' num2str(sample_id) ' on generataion '  num2str(run_step) '.mat'],'tournament0');

end


