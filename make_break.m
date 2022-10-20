function  niches_x=make_break(needed_population_of_niche,niches_x,l_l_X)

niches_x=sort_by_ff3(niches_x);

if (needed_population_of_niche<=-1)
    removed=0;
    while(abs(needed_population_of_niche)>removed)&&(1<niches_x.size_niches)&&(l_l_X<niches_x.size_niches)
        r=randi(niches_x.size_niches-l_l_X)+l_l_X;
        
        niches_x.list_num_genomes(r)=niches_x.list_num_genomes(niches_x.size_niches);
        
        niches_x.size_niches=niches_x.size_niches-1;
        removed=removed+1;
    end
end

if (needed_population_of_niche>=+1)
    created=0;
    flag=1;
    while(needed_population_of_niche>created)
        created=created+1;
        mutated=mutate_it(niches_x.list_num_genomes(flag));
        niches_x.size_niches=niches_x.size_niches+1;
        niches_x.list_num_genomes=[niches_x.list_num_genomes  mutated];
        flag=flag+1;
        if (flag>niches_x.size_niches)
            flag=1;
        end
    end
end

end

