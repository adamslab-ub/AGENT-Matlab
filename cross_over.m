function child=cross_over(parent_1,parent_2)

global def_genome_struct;
global max_try_cross_over;
global max_edge_for_one_genome;

it_isnot_loopless=1;
try_enough=0;

while (try_enough<max_try_cross_over)&& (it_isnot_loopless)
    try_enough=try_enough+1;
    n_1=parent_1.n_edge;
    e_1=parent_1.edge_gene;
    
    sorted_e_1=sort_by_innov_num(n_1,e_1);
    
    n_2=parent_2.n_edge;
    e_2=parent_2.edge_gene;
    
    sorted_e_2=sort_by_innov_num(n_2,e_2);
    flag_1=1;
    flag_2=1;

    child=def_genome_struct;
    
    flag_child=1;
    while(flag_1<=n_1)&&(flag_2<=n_2)
        
        if sorted_e_1(flag_1).inn_number==sorted_e_2(flag_2).inn_number%common
            
            r=rand;
            if r<=0.5
                child.edge_gene(flag_child)=sorted_e_1(flag_1);
            else
                child.edge_gene(flag_child)=sorted_e_2(flag_2);
            end
            flag_1=flag_1+1;
            flag_2=flag_2+1;
            flag_child=flag_child+1;
            
        else% disjoint
            if sorted_e_1(flag_1).inn_number<sorted_e_2(flag_2).inn_number
                if (parent_1.rank_global<=parent_2.rank_global)
                    child.edge_gene(flag_child)=sorted_e_1(flag_1);
                    flag_child=flag_child+1;
                end
                flag_1=flag_1+1;
            else
                if (parent_2.rank_global<=parent_1.rank_global)
                    child.edge_gene(flag_child)=sorted_e_2(flag_2);
                    flag_child=flag_child+1;
                end
                flag_2=flag_2+1;
            end
        end
    end
    
    if(flag_1<=n_1)
        if (parent_1.rank_global<=parent_2.rank_global)
            while (flag_1<=n_1) && (flag_child<max_edge_for_one_genome)
                child.edge_gene(flag_child)=sorted_e_1(flag_1);
                flag_1=flag_1+1;
                flag_child=flag_child+1;
            end
        end
    else
        if (parent_2.rank_global<=parent_1.rank_global)
            while (flag_2<=n_2)&& (flag_child<max_edge_for_one_genome)
                child.edge_gene(flag_child)=sorted_e_2(flag_2);
                flag_2=flag_2+1;
                flag_child=flag_child+1;
            end
        end
    end
    
    child.niche_of_genome=parent_1.niche_of_genome;
    child.n_edge=flag_child-1;
    
    [is_possible_based_on_node_size,child]=get_others_from_edges(child,child.n_edge,parent_1,parent_2);
    
    if is_possible_based_on_node_size
        it_isnot_loopless=check_loop_imidietly(child);
    else
        it_isnot_loopless = 0;
    end

end

if(try_enough>=max_try_cross_over) || (it_isnot_loopless==0)
    r=rand;

    if r<0.5
        child=parent_1;
        child.fathers=parent_1.fathers;
    else
        child=parent_2;
        child.fathers=parent_2.fathers;
    end

else
    t_fathers=parent_1.fathers;
    for i_father2=1:size(parent_2.fathers,1)
        not_repeat=1;
        for i_father1=1:size(parent_1.fathers,1)
            if parent_1.fathers(i_father1,1)==parent_2.fathers(i_father2,1)
                t_fathers(i_father1,2)=t_fathers(i_father1,2)+parent_2.fathers(i_father2,2);
                not_repeat=0;
                break;
            end
        end
        if not_repeat
            t_fathers=[t_fathers;parent_2.fathers(i_father2,:)];
        end
    end

    child.fathers=t_fathers;
end

end

