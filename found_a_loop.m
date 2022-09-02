function m_r_s=found_a_loop(geneome_x,r1,r2)
%If there is a path from r_e(r2) to r_s(r1) there will be a loop in mutated one;
mark=zeros(geneome_x.n_node,1);
mark(r2)=1;
marked=r2;
size_marked=1;
changeged_something=1;

while(mark(r1)==0)&&(changeged_something==1)
    changeged_something=0;
    for i=size_marked:-1:1 %it is realy useful cause new node are more possible to mark a new node
        for j=1:geneome_x.n_node
            if (geneome_x.matrix_weights(marked(i),j)*geneome_x.enable_weights(marked(i),j)~=0)&&(mark(j)==0)
                mark(j)=1;
                size_marked=size_marked+1;
                marked(size_marked)=j;
                changeged_something=1;
            end
        end
    end
end


m_r_s=mark(r1);
% display('ZZZZZ')
% display(m_r_s)
% display('ZZZZZ')

end

