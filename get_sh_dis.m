function sh_dis=get_sh_dis(N)

global dis_limit K_niche_neighborhood alpha_niche_neighborhood;
global niches num_niches;

sh_dis=zeros(N,N);
flag1=0;
for i_n1=1:num_niches
    for i_g1=1:niches(i_n1).size_niches
        flag1=flag1+1;
        flag2=0;
        for i_n2=1:num_niches
            for i_g2=1:niches(i_n2).size_niches
            	flag2=flag2+1;

                d=new_nicheing_dis(niches(i_n1).list_num_genomes(i_g1),niches(i_n2).list_num_genomes(i_g2));
                if d<(K_niche_neighborhood*dis_limit)
                    sh_dis(flag1,flag2)=1-(d/(K_niche_neighborhood*dis_limit))^alpha_niche_neighborhood;
                else
                    sh_dis(flag1,flag2)=0;
                end
                 % sh_dis(flag1,flag2)
            end
        end
    end
end

end

