function add_to_mating_pool=tournament(niches_x,n_out,ff)

global num_enter_tor num_win_tor max_appearance_in_mating_pool;
add_to_mating_pool=[];

appeared = zeros(niches_x.size_niches,1);

if (niches_x.size_niches>=num_enter_tor)
    for i=1:ceil(n_out/num_win_tor)
        
        for j=1:num_enter_tor
            r(j)=randi(niches_x.size_niches);
            ff_r(j)=ff(r(j));
            list(j)=r(j);
        end
        for k=1:num_win_tor
            best=min(ff_r)-1;
            for j=1:num_enter_tor
                if (ff_r(j)>=best) && ((appeared(list(j))<max_appearance_in_mating_pool) || (min(appeared)>=max_appearance_in_mating_pool))% besides being the best it must be less repeated
                    best=ff_r(j);
                    candid=j;
                end
            end
            ff_r(candid)=min(ff)-2; % to stop reselecting
            appeared(list(candid)) = appeared(list(candid))+1;
            add_to_mating_pool=[add_to_mating_pool niches_x.list_num_genomes(list(candid))];
        end
    end
else
    if (niches_x.size_niches>=num_win_tor)
        for i=1:ceil(n_out/num_win_tor)
            for j=1:niches_x.size_niches
                ff_r(j)=ff(j);
                list_r(j)=j;
            end
            for k=1:num_win_tor
                best=min(ff_r)-1;
                for j=1:niches_x.size_niches
                    if (ff_r(j)>=best) && ((appeared(list_r(j))<max_appearance_in_mating_pool) || (min(appeared)>=max_appearance_in_mating_pool))% besides being the best it must be less repeated
                        best=ff_r(j);
                        candid=j;
                    end
                end
                ff_r(candid)=min(ff)-2;%to stop reselecting
                appeared(list_r(candid)) = appeared(list_r(candid))+1;                
                add_to_mating_pool=[add_to_mating_pool niches_x.list_num_genomes(list_r(candid))];
            end
        end
    else      
        for j=1:niches_x.size_niches
            appeared(j) = appeared(j)+1;            
            add_to_mating_pool=[add_to_mating_pool niches_x.list_num_genomes(j)];
        end
        for k=1:n_out-niches_x.size_niches
            rr_x = randi(niches_x.size_niches);
            while ((appeared(rr_x)>=max_appearance_in_mating_pool) && (min(appeared)<max_appearance_in_mating_pool))% besides being the best it must be less repeated
                rr_x = randi(niches_x.size_niches);
            end
            appeared(rr_x) = appeared(rr_x)+1;                        
            add_to_mating_pool=[add_to_mating_pool niches_x.list_num_genomes(rr_x)];
        end
    end
end

end

