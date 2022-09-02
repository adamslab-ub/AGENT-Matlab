function grow_or_shrink
% 
% 'oooo1'
% rand
    
global genome niches num_niches num_genomes turn;

% maxo=-100000000000000000000;

% for i_n=1:num_niches
%     for i_g=1:niches(i_n).size_niches
%         if niches(i_n).list_num_genomes(i_g).fit_fun(1)>maxo
%             maxo=niches(i_n).list_num_genomes(i_g).fit_fun(1);
%         end
%     end
% end

for i_n=1:num_niches
    niches(i_n)=sort_by_ff3(niches(i_n));
end

% 'oooo2'
% rand

for i_n=1:num_niches
    l_l(i_n)=0;
%     l=[];% unused
    for i_g=1:niches(i_n).size_niches
%         niches(i_n).list_num_genomes(i_g).rank_global
        if ceil(niches(i_n).list_num_genomes(i_g).rank_global)==1
%             l=[l niches(i_n).list_num_genomes(i_g)];
            l_l(i_n)=l_l(i_n)+1;
        end
    end
end

% l_l
% l
% 'oooo3'
% rand

flag=0;
ff=[];

for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        flag=flag+1;
        ff(flag)=niches(i_n).list_num_genomes(i_g).fit_fun(1);
    end
end
% 'oooo4'
% rand
sh_dis=get_sh_dis(flag);
% save('just_the_sh_MAT.mat','sh_dis')
% sh_dis
% dsadsad
flag=0;
% 'oooo5'
% rand
for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        flag=flag+1;
        nc(flag)=sum(sh_dis(flag,:));
%         nc(flag)
        ff_x(flag)=ff(flag)/nc(flag);
%         ff_x(flag)
        
%         genome(niches(i_n).list_num_genomes(i_g).num_genome).fit_fun4=ff_x(flag);%
%         % this is possible to add here, but it may cause issues in
%         python, let's see what happens there

        niches(i_n).list_num_genomes(i_g).fit_fun4=ff_x(flag);
    end
end
% 'oooo6'
% rand
% sad
ff_x_mean=mean(ff_x);

num_genomes_temp=0;

for i_n=1:num_niches

    sum_this=0;
    for i_g=1:niches(i_n).size_niches
        sum_this=sum_this+(niches(i_n).list_num_genomes(i_g).fit_fun4);
    end
    needed_population_of_niche_obj=ceil(sum_this/ff_x_mean);
%     needed_population_of_niche_obj
    needed_population_of_niche=(needed_population_of_niche_obj);
%     'FFFFFFFFFFFFFFFFFFFFFFFFFF'
%     needed_population_of_niche-niches(i_n).size_niches
%     'FFFFFFFFFFFFFFFFFFFFFFFFFF'
    niches(i_n)=make_break(needed_population_of_niche-niches(i_n).size_niches,niches(i_n),l_l(i_n));
    num_genomes_temp=num_genomes_temp+needed_population_of_niche;
end
% rand
% 'oooo7'
% rand
i_n=1;
while i_n<=num_niches
    niches(i_n).size_niches;
    if niches(i_n).size_niches==0
        for i_g=1:niches(num_niches).size_niches
            niches(num_niches).list_num_genomes(i_g).niche_of_genome=i_n;
        end
        niches(i_n)=niches(num_niches);
        num_niches=num_niches-1;
        i_n=i_n-1;
    end
    i_n=i_n+1;
end
% 'oooo8'
% rand
flag=0;

for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        flag=flag+1;
    end
end
num_genomes_temp=flag;
% 'oooo85'
% rand
% reduce more to reach num_niches
for i=1:num_genomes_temp-num_genomes
    r1=randi(num_niches);
    while(niches(r1).size_niches<=l_l(r1))
        r1=randi(num_niches);
    end
    r2=randi(niches(r1).size_niches-l_l(r1))+1;
    niches(r1).list_num_genomes(r2)=niches(r1).list_num_genomes(niches(r1).size_niches);
    niches(r1).size_niches=niches(r1).size_niches-1;
%     'CCCCCCCCCCCCCCCCCCCCCCCC'
%     r1
%     r2
%     'CCCCCCCCCCCCCCCCCCCCCCCC'
end
% 'oooo9'
% rand
i_n=1;
while i_n<=num_niches
    
    if niches(i_n).size_niches==0
        
        for i_g=1:niches(num_niches).size_niches
            niches(num_niches).list_num_genomes(i_g).niche_of_genome=i_n;
        end
        niches(i_n)=niches(num_niches);
        num_niches=num_niches-1;
        i_n=i_n-1;
    end
    i_n=i_n+1;
end
% 'oooo10'
% rand
%create more to reach num_niches
for i=1:num_genomes-num_genomes_temp
    r1=randi(num_niches);
    r2=randi(niches(r1).size_niches);
    mutated=mutate_it(niches(r1).list_num_genomes(r2));
    %if testing_distance(niches(r1),mutated)
    if 1 % Right now I klet them all in, because later, we must re nich them, so it is almost safe
        niches(r1).list_num_genomes=[niches(r1).list_num_genomes  mutated];
        niches(r1).size_niches=niches(r1).size_niches+1;   
%         'CCCCCCCCCCCCCCCCCCCCCCCC'
%         r1
%         r2
%         'CCCCCCCCCCCCCCCCCCCCCCCC'
    end
end

for i_n=1:num_niches
    niches(i_n)=sort_by_ff3(niches(i_n));
end
            

end

