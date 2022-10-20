function genome_x=find_its_niches(genome_x)

global  niches genome num_niches;

MIN_DiS=new_nicheing_dis(genome_x,niches(1).list_num_genomes(1));
best_niches=1;
for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        dis_this=new_nicheing_dis(genome_x,niches(i_n).list_num_genomes(i_g));
        if dis_this<MIN_DiS
            MIN_DiS=dis_this;
            best_niches=i_n;
        end
    end
end
genome_x.niche_of_genome=best_niches;
niches(best_niches).size_niches=niches(best_niches).size_niches+1;

niches(best_niches).list_num_genomes(niches(best_niches).size_niches)=genome_x;
genome(genome_x.num_genome)=genome_x;
end

