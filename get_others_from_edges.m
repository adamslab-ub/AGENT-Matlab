function [is_possible_based_on_node_size,genome_x]=get_others_from_edges(genome_x,n_edge_x,parent_1,parent_2)

global num_input num_output global_geneom_num global_node_num max_node_for_one_genome;

%c_t = tic; 

genome_x.n_edge=n_edge_x;
global_geneom_num=global_geneom_num+1;

genome_x.num_genome=global_geneom_num;

genome_x.go_on=1;

if parent_1.rank_global>parent_2.rank_global
    best_parent=parent_1;
    worst_parent=parent_2;
else
    best_parent=parent_2;
    worst_parent=parent_1;
end

mark=zeros(global_node_num,1);

flag_list_node=0;
for jjj=1:num_input+num_output
    flag_list_node=flag_list_node+1;
    list_node_x(flag_list_node)=best_parent.list_node(jjj);
    mark(jjj)=1;
end

n_node_x=flag_list_node;

for i=1:n_edge_x
    if mark(genome_x.edge_gene(i).start)==0
        mark(genome_x.edge_gene(i).start)=1;
        got_it_from_best_parent=0;
        for jjj=1:best_parent.n_node
            if genome_x.edge_gene(i).start==best_parent.list_node(jjj).list_node_ID
                flag_list_node=flag_list_node+1;
                list_node_x(flag_list_node)=best_parent.list_node(jjj);
                got_it_from_best_parent=1;
                break;
            end
        end
        if got_it_from_best_parent==0
            for jjj=1:worst_parent.n_node
                if genome_x.edge_gene(i).start==worst_parent.list_node(jjj).list_node_ID
                    flag_list_node=flag_list_node+1;
                    list_node_x(flag_list_node)=worst_parent.list_node(jjj);
                    break;
                end
            end
        end
        n_node_x=n_node_x+1;
    end
    
    if mark(genome_x.edge_gene(i).end)==0
        mark(genome_x.edge_gene(i).end)=1;
        got_it_from_best_parent=0;
        for jjj=1:best_parent.n_node
            if genome_x.edge_gene(i).end==best_parent.list_node(jjj).list_node_ID
                flag_list_node=flag_list_node+1;
                list_node_x(flag_list_node)=best_parent.list_node(jjj);
                got_it_from_best_parent=1;
                break;
            end
        end
        if got_it_from_best_parent==0
            for jjj=1:worst_parent.n_node
                if genome_x.edge_gene(i).end==worst_parent.list_node(jjj).list_node_ID
                    flag_list_node=flag_list_node+1;
                    list_node_x(flag_list_node)=worst_parent.list_node(jjj);
                    break;
                end
            end
        end
        
        n_node_x=n_node_x+1;
    end
    
end

matrix_weights_x=zeros(n_node_x,n_node_x);
enable_weights_x=zeros(n_node_x,n_node_x);
%if n_node_x>max_node_for_one_genome: % this was the answer but it seems so wrong
if n_node_x<=max_node_for_one_genome
    
    is_possible_based_on_node_size = 1 ; % check if the total genome does not pass total node limit
    
    for i=1:n_node_x
        st=list_node_x(i).list_node_ID;
        for j=1:n_node_x
            en=list_node_x(j).list_node_ID;
            for k=1:n_edge_x
                if (genome_x.edge_gene(k).start==st)&&(genome_x.edge_gene(k).end==en)
                    matrix_weights_x(i,j)=genome_x.edge_gene(k).weight;
                    enable_weights_x(i,j)=genome_x.edge_gene(k).enable;
                    break;
                end
            end
        end
    end
    genome_x.list_node=list_node_x;
    genome_x.n_node=n_node_x;
    genome_x.matrix_weights=matrix_weights_x;
    genome_x.enable_weights=enable_weights_x;
    
else
    is_possible_based_on_node_size = 0 ; % check if the total genome does not pass total node limit    
end

end
