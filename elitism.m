    function niches_x_temp=elitism(niches_x,e_s)

niches_x_temp=niches_x;

niches_x_temp.list_num_genomes=[niches_x.list_num_genomes(1)];
for i=1:e_s
    niches_x_temp.list_num_genomes(i)=niches_x.list_num_genomes(i);
end
niches_x_temp.size_niches=e_s;
niches_x_temp.best_ff_niches=niches_x.best_ff_niches;
niches_x_temp.stall_time=niches_x.stall_time;

end

