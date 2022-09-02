function [niches_x]=my_GA(niches_x)

% for i_g=1:niches_x.size_niches
%     'XXXXXXXXXXXXXXXXXXXXXXX'
%     niches_x.list_num_genomes(i_g).rank
%     niches_x.list_num_genomes(i_g).fit_fun(1)
%     niches_x.list_num_genomes(i_g).matrix_weights
%     niches_x.list_num_genomes(i_g).enable_weights
% end

global elite_perce_to_reproduce  perc_elited_saves num_niches r_crosover num_objectives;
num_genomes_niches=niches_x.size_niches;

for i=1:niches_x.size_niches
    ff_r(i)=(-1*niches_x.list_num_genomes(i).rank_global);
    ff_r2(i)=niches_x.list_num_genomes(i).fit_fun(1);
    for j=1:num_objectives
        ff(i,j)=niches_x.list_num_genomes(i).fit_fun(j);
    end
end

num_elited_saves_old=ceil(perc_elited_saves*niches_x.size_niches);
l_l=0;
l=[];
% 'XXXXXXXXXXXX'
% num_elited_saves_old
for i_g=1:niches_x.size_niches

    if ceil(niches_x.list_num_genomes(i_g).rank_global)==1
        if i_g>num_elited_saves_old
            l=[l niches_x.list_num_genomes(i_g)];
            l_l=l_l+1;
        end
    end
end

% l_l
% 

niches_x_temp=elitism(niches_x,num_elited_saves_old);
num_elited_saves=l_l+num_elited_saves_old;
niches_x_temp.list_num_genomes=[niches_x_temp.list_num_genomes l];
niches_x_temp.size_niches=num_elited_saves;

% niches_x_temp.size_niches

n_out=2*(niches_x.size_niches-num_elited_saves);


num_elited_reproduce=ceil(elite_perce_to_reproduce*niches_x.size_niches);
niches_x_production=elitism(niches_x,num_elited_reproduce);
niches_x_temp.size_niches=num_elited_saves;

% niches_x_production.list_num_genomes(7).matrix_weights

mateing_pool=tournament(niches_x_production,n_out,ff_r);

% if single_obj==1
%     mateing_pool=tournament(niches_x,n_out,ff_r2);
% end

if n_out>0
    
    for i=1:2:n_out
        
        parents_1=mateing_pool(i);
        parents_2=mateing_pool(i+1);
        
%         parents_1.matrix_weights
%         parents_2.matrix_weights

        r=rand;
        if r<r_crosover
            child=cross_over(parents_1,parents_2);
        
        else
            r=rand;
            if r>0.5
                child=parents_1;
            else
                child=parents_2;
            end
        end
%         child.matrix_weights
        child=mutate_it(child);
%         child.matrix_weights
%         'XXXXXXXXXXXXXXXXXXXXXXXXX'
        
        child.niche_of_genome=niches_x.list_num_genomes(1).niche_of_genome;
        
        niches_x_temp.size_niches=niches_x_temp.size_niches+1;
        niches_x_temp.list_num_genomes(niches_x_temp.size_niches) = child;
    end
end

%niches_x_temp.size_niches=niches_x.size_niches; % probably harmless but it
%was oposite; anyway it will make the same size
niches_x.size_niches=niches_x_temp.size_niches;

niches_x=niches_x_temp;

niches_x=sort_by_ff3(niches_x);
% rand


% niches_x.size_niches=num_genomes_niches;


end

