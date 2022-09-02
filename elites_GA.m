function [niches_x]=elites_GA(niches_x,N_niche_x)
global niches num_niches  perc_elited_to_mute_elite num_genomes try_found_elite_GA;

num_elited_to_mate=ceil(perc_elited_to_mute_elite*niches_x.size_niches);

for i_n=1:num_niches
    l_l(i_n)=0;
    for i_g=1:niches(i_n).size_niches
        if ceil(niches(i_n).list_num_genomes(i_g).rank_global)==1
            l_l(i_n)=l_l(i_n)+1;
        end
    end
end

niches_first=niches;
for i=1:num_elited_to_mate
    niches_OLD=niches;
    r1=randi(num_niches);
    r2=randi(max(ceil(niches(r1).size_niches*perc_elited_to_mute_elite),1));
    
    niches_x=niches(N_niche_x);
    parent_1=niches_x.list_num_genomes(i);%i changed it this wat to be safe when the niche changes
    parent_2=niches(r1).list_num_genomes(r2);

    child=cross_over(parent_1,parent_2);

    child=find_its_niches(child);

    if length(l_l)<num_niches
        sdasdasdasdasd
        l_l(num_niches)=niches(num_niches).size_niches;
    end
    
    r_to_decrese=randi(num_niches);
    
    enough_tried=1;

    while ((niches(r_to_decrese).size_niches<=l_l(r_to_decrese)+1) || (r_to_decrese==child.niche_of_genome) || (r_to_decrese==N_niche_x))
        r_to_decrese=randi(num_niches);
        enough_tried=enough_tried+1;
        if enough_tried>try_found_elite_GA
            break;
        end
    end

    if enough_tried>try_found_elite_GA
        niches=niches_OLD;
        continue;
    end

    r=randi(niches(r_to_decrese).size_niches-l_l(r_to_decrese))+l_l(r_to_decrese);
    

    niches(r_to_decrese).list_num_genomes(r)=niches(r_to_decrese).list_num_genomes(niches(r_to_decrese).size_niches);
    niches(r_to_decrese).size_niches=niches(r_to_decrese).size_niches-1;%
    if niches(r_to_decrese).size_niches==0
        r_to_decrese
        N_niche_x
        l_l(r_to_decrese)
        dsdsa
    end

end


num_genomes_temp=0;
for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        num_genomes_temp=num_genomes_temp+1;
    end
end


for i=1:num_genomes_temp-num_genomes
    jnl
    r1=randi(num_niches);
    while(niches(r1).size_niches<=l_l(r1))
        r1=randi(num_niches);
    end
    r2=randi(niches(r1).size_niches-l_l(r1))+l_l(r1);
    niches(r1).list_num_genomes(r2)=niches(r1).list_num_genomes(niches(r1).size_niches);
    niches(r1).size_niches=niches(r1).size_niches-1;
end


end

