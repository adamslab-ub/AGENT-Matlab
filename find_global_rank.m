function find_global_rank

global num_niches niches RANK_0;

super_niches.list_num_genomes=[];
super_niches.size_niches=0;

for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        niches(i_n).list_num_genomes(i_g).rank_global=RANK_0;
        super_niches.list_num_genomes=[super_niches.list_num_genomes niches(i_n).list_num_genomes(i_g)];
    end
    super_niches.size_niches=super_niches.size_niches+niches(i_n).size_niches;
end

super_niches=sort_by_ff3(super_niches);

mark_all = zeros(num_niches,super_niches.size_niches);
for i_s=1:super_niches.size_niches
    not_found=1;
    i_n=1;
    
    while(not_found)&&(i_n<=num_niches)
        i_g=1;
        while(not_found)&&(i_g<=niches(i_n).size_niches)
            if super_niches.list_num_genomes(i_s).n_node==niches(i_n).list_num_genomes(i_g).n_node
                c1=super_niches.list_num_genomes(i_s).matrix_weights.*super_niches.list_num_genomes(i_s).enable_weights;
                c2=niches(i_n).list_num_genomes(i_g).matrix_weights.*niches(i_n).list_num_genomes(i_g).enable_weights;
                
                if ((size(c1,1)==size(c2,1)) && (mark_all(i_n,i_g)==0))% to be sure they are atleast the same size, probably ok without it but it was bad in python
                    if  (min(min(c1==c2))==1) && (niches(i_n).list_num_genomes(i_g).rank_global==RANK_0)
                        not_found=0;
                        mark_all(i_n,i_g)=1;
                        niches(i_n).list_num_genomes(i_g).rank_global=super_niches.list_num_genomes(i_s).rank;
                    else
                        i_g=i_g+1;
                    end
                else
                    i_g=i_g+1;
                end
            else
                i_g=i_g+1;
            end
        end
        i_n=i_n+1;
    end
end
% 
% for i_n=1:num_niches
%     display(['Niches = ' , num2str(i_n)])
%     for i_g=1:niches(i_n).size_niches
%         display(['Genome = ' , num2str(i_g)])
%         display(niches(i_n).list_num_genomes(i_g).rank_global)
%         display(niches(i_n).list_num_genomes(i_g).matrix_weights)      
%     end   
% end


end

