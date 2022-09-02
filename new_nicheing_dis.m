function dis_this=new_nicheing_dis(genome_1,genome_2)
global N_nodetypes W_dis_node W_dis_edge;

n1= genome_1.n_node;
which_idx_for_node_number1=zeros(n1,1);

for i=1:n1% to return 1,2,3,4,5,6,8 to 1,2,3,4,5,6,7,
    which_idx_for_node_number1(genome_1.list_node(i).list_node_ID)=i;
end

n_type_1=zeros(N_nodetypes,1);
for i=1:n1
    n_type_1(genome_1.list_node(i).list_node_type)=n_type_1(genome_1.list_node(i).list_node_type)+1;
end
% genome_1.matrix_weights

n2= genome_2.n_node;
which_idx_for_node_number2=zeros(n2,1);

for i=1:n2% to return 1,2,3,4,5,6,8 to 1,2,3,4,5,6,7,
    which_idx_for_node_number2(genome_2.list_node(i).list_node_ID)=i;
end

n_type_2=zeros(N_nodetypes,1);
for i=1:n2
    n_type_2(genome_2.list_node(i).list_node_type)=n_type_2(genome_2.list_node(i).list_node_type)+1;
end

nTT1=zeros(N_nodetypes,N_nodetypes);
for i=1:genome_1.n_edge

    k_st=which_idx_for_node_number1(genome_1.edge_gene(i).start);
    %     k_st
    st_type=genome_1.list_node(k_st).list_node_type;
    k_en=which_idx_for_node_number1(genome_1.edge_gene(i).end);
    %     k_en
    
    en_type=genome_1.list_node(k_en).list_node_type;
    
    nTT1(st_type,en_type)=nTT1(st_type,en_type)+1;
end
nTT2=zeros(N_nodetypes,N_nodetypes);
for i=1:genome_2.n_edge
    k_st=which_idx_for_node_number2(genome_2.edge_gene(i).start);
    st_type=genome_2.list_node(k_st).list_node_type;
    k_en=which_idx_for_node_number2(genome_2.edge_gene(i).end);
    en_type=genome_2.list_node(k_en).list_node_type;
    nTT2(st_type,en_type)=nTT2(st_type,en_type)+1;
end


dis_this_nodes=sum(abs(n_type_1-n_type_2));
dis_this_edges=sum(sum(abs(nTT1-nTT2)));
dis_this=W_dis_node*dis_this_nodes+W_dis_edge*dis_this_edges;
% n_type_1
% n_type_2
% dis_this_nodes
% dis_this_edges
% dis_this


end

