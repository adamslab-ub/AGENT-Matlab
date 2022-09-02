function niches_x=sort_by_ff3(niches_x)
global RANK_0;
% for i_g=1:niches_x.size_niches
%     'XXXXXXXXXXXXXXXXXXXXXXX'
%     niches_x.list_num_genomes(i_g).rank
%     niches_x.list_num_genomes(i_g).fit_fun(1)
%     niches_x.list_num_genomes(i_g).matrix_weights
% end


if niches_x.size_niches>0
    
    niche_ranker.list_num_genomes=[];
    niche_ranker.size_niches=0;
    
    niche_conser.list_num_genomes=[];
    niche_conser.size_niches=0;
    
    for i_g=1:niches_x.size_niches
        if niches_x.list_num_genomes(i_g).constraints<=0
            niche_ranker.list_num_genomes=[niche_ranker.list_num_genomes niches_x.list_num_genomes(i_g)];
            niche_ranker.size_niches=niche_ranker.size_niches+1;
        else
            niche_conser.list_num_genomes=[niche_conser.list_num_genomes niches_x.list_num_genomes(i_g)];
            niche_conser.size_niches=niche_conser.size_niches+1;
        end
        niches_x.list_num_genomes(i_g).rank=RANK_0;
    end
    
    if niche_ranker.size_niches>0
        niche_ranker=ranker(niche_ranker,niche_ranker.size_niches);
    end
    if  niche_conser.size_niches>0
        niche_conser=conser(niche_conser,niche_conser.size_niches);
    end
    
    M=0;
    for i_g=1:niche_ranker.size_niches
        if niche_ranker.list_num_genomes(i_g).rank>M
            M=niche_ranker.list_num_genomes(i_g).rank;
        end
    end
    mark_conser = zeros(niche_conser.size_niches,1);
    mark_ranker = zeros(niche_ranker.size_niches,1);
    for i_s=1:niches_x.size_niches
        not_found=1;
        i_g=1;

        while(not_found)&&(i_g<=niche_conser.size_niches)
            if niches_x.list_num_genomes(i_s).n_node==niche_conser.list_num_genomes(i_g).n_node
                c1=niches_x.list_num_genomes(i_s).matrix_weights.*niches_x.list_num_genomes(i_s).enable_weights;
                c2=niche_conser.list_num_genomes(i_g).matrix_weights.*niche_conser.list_num_genomes(i_g).enable_weights;
                if (size(c1,1)==size(c2,1)) && (mark_conser(i_g)==0) % to be sure they are atleast the same size, probably ok without it but it was bad in python
                    if  (min(min(c1==c2))==1) && (niches_x.list_num_genomes(i_s).rank==RANK_0)
                        not_found=0;
                        mark_conser(i_g) = 1;
                        niches_x.list_num_genomes(i_s).rank=niche_conser.list_num_genomes(i_g).constraints+M;
                        break;
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
        i_g=1;
        while(not_found)&&(i_g<=niche_ranker.size_niches)
            
            if niches_x.list_num_genomes(i_s).n_node==niche_ranker.list_num_genomes(i_g).n_node                
                c1=niches_x.list_num_genomes(i_s).matrix_weights.*niches_x.list_num_genomes(i_s).enable_weights;
                c2=niche_ranker.list_num_genomes(i_g).matrix_weights.*niche_ranker.list_num_genomes(i_g).enable_weights;
                if (size(c1,1)==size(c2,1))  && (mark_ranker(i_g)==0)% to be sure they are atleast the same size, probably ok without it but it was bad in python
                    if  (min(min(c1==c2))==1) && (niches_x.list_num_genomes(i_s).rank==RANK_0)                              
                        not_found=0;
                        mark_ranker(i_g) = 1 ;                       
                        niches_x.list_num_genomes(i_s).rank=niche_ranker.list_num_genomes(i_g).rank;
                        break;
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
    end
end

for i_g1=1:niches_x.size_niches-1
    for i_g2=i_g1+1:niches_x.size_niches
        
        if niches_x.list_num_genomes(i_g1).rank>niches_x.list_num_genomes(i_g2).rank
            
            temp_genom=niches_x.list_num_genomes(i_g1);
            niches_x.list_num_genomes(i_g1)=niches_x.list_num_genomes(i_g2);
            niches_x.list_num_genomes(i_g2)=temp_genom;
        end
    end
end

% for i_g=1:niches_x.size_niches
%     'XXXXXXXXXXXXXXXXXXXXXXX'
%     niches_x.list_num_genomes(i_g).rank
%     niches_x.list_num_genomes(i_g).fit_fun(1)
%     niches_x.list_num_genomes(i_g).matrix_weights
% end


end

