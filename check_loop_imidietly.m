function m_r_s=check_loop_imidietly(child)
m_r_s=0;

l_n_x=zeros(child.n_node,1);
for i=1:child.n_node
    l_n_x(i)=child.list_node(i).list_node_ID;
end

list_in_nodes=zeros(max(l_n_x),1);

for i=1:child.n_node
    list_in_nodes(child.list_node(i).list_node_ID)=i;
end

for i=1:child.n_edge
    r1=child.edge_gene(i).start;
    r2=child.edge_gene(i).end;
    m_r_s=found_a_loop(child,list_in_nodes(r1),list_in_nodes(r2));
    if m_r_s==1
        break;
    end
end
end

