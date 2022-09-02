function DIV_now=getdiversity

global num_niches  niches;
flag_genomes=0;
for i_n=1:num_niches
    % niches(i_n).size_niches
    for i_g=1:niches(i_n).size_niches
        flag_genomes=flag_genomes+1;
        genome_DIVERSTITY(flag_genomes)=niches(i_n).list_num_genomes(i_g);
        
    end
end

flag_edges=0;
mat_dis=zeros(flag_genomes,flag_genomes);
% 'XXXXXXXXXXXXXXXXXXX'
% genome_DIVERSTITY(1).matrix_weights
% 'XXXXXXXXXXXXXXXXXXX'
% genome_DIVERSTITY(2).matrix_weights
% 'XXXXXXXXXXXXXXXXXXX'
% 
% genome_DIVERSTITY(50).matrix_weights
% 
% SDAS

for i_f1=1:flag_genomes-1
    for i_f2=i_f1+1:flag_genomes
        mat_dis(i_f1,i_f2)=new_nicheing_dis(genome_DIVERSTITY(i_f1),genome_DIVERSTITY(i_f2));
        
%         mat_dis(i_f1,i_f2)
        
        flag_edges=flag_edges+1;
        E(flag_edges,:)=[i_f1,i_f2,mat_dis(i_f1,i_f2)];
        flag_edges=flag_edges+1;
        E(flag_edges,:)=[i_f2,i_f1,mat_dis(i_f1,i_f2)];
    end
end
V=1:1:flag_genomes;
% E(34,:)
% V

T_m_s_T=kroksal_AMIR(V,E);
DIV_now=T_m_s_T;
%DIV_now
end

