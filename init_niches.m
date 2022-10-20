function init_niches(iter)

global genome num_genomes niches num_niches num_niches_fixed;

if iter>1
    flag=0;
    for i_n=1:num_niches
        for i_g=1:niches(i_n).size_niches
            flag=flag+1;
            genome(flag)=niches(i_n).list_num_genomes(i_g);
        end
    end
end
mat_dis=zeros(num_genomes,num_genomes);
for i_g1=1:num_genomes-1
    for i_g2=i_g1+1:num_genomes
        mat_dis(i_g1,i_g2)=new_nicheing_dis(genome(i_g1),genome(i_g2));
    end
end

mat_dis=mat_dis+mat_dis';
least_dis=zeros(num_genomes,1);

for i_g=1:num_genomes
    least_dis(i_g)=sum(mat_dis(i_g,:))+ 1/(num_genomes*10+i_g);
end


[~,idx]=sort(least_dis,'ascend');
idx = flipud(idx) ;

for i_n=1:num_niches_fixed
    niches(i_n).size_niches=1;
    niches(i_n).list_num_genomes=genome(idx(i_n));
end

for i_g=num_niches_fixed+1:num_genomes
    
    capt_dis=mat_dis(idx(i_g),idx(1));
    best_team=1;
    for i_n=2:num_niches_fixed
        guess_dis=mat_dis(idx(i_g),idx(i_n));
        if guess_dis<capt_dis
            capt_dis=guess_dis;
            best_team=i_n;
        elseif guess_dis==capt_dis
            r=rand;
            if r<0.5
                capt_dis=guess_dis;
                best_team=i_n;
            end
        end
    end
    niches(best_team).size_niches=niches(best_team).size_niches+1;
    niches(best_team).list_num_genomes=[niches(best_team).list_num_genomes genome(idx(i_g))];
    
end

for i_n=1:num_niches_fixed
    niches(i_n).best_ff_niches=0;
    niches(i_n).stall_time=0;
    niches(i_n).number_niches=i_n;
end

num_niches=num_niches_fixed;

end
