function geneome_x=relayer(geneome_x)

global num_input num_output;



mark=zeros(geneome_x.n_node,1);
l{1}=[];
for i=1:num_input
    l{1}=[l{1} i];
    mark(i)=1;
end

flag_l=1;
finished=0;

while (finished==0)

    flag_l=flag_l+1;
    l{flag_l}=[];
    for j=1:geneome_x.n_node
        if (mark(j)==0)
            add_to_level=1;
            for i=1:geneome_x.n_node
                if (geneome_x.matrix_weights(i,j)*geneome_x.enable_weights(i,j)~=0)&&(mark(i)~=1)
                    add_to_level=0;
                    break;
                end
            end
            if add_to_level==1
                mark(j)=0.5;
                l{flag_l}=[l{flag_l} j];
            end
        end
    end
    
    for j=num_input+1:geneome_x.n_node
        if mark(j)==0.5
            mark(j)=1;
        end
    end
    
    finished=1;
    
    for j=num_input+1:1:num_input+num_output
        if (mark(j))==0
            finished=0;
        end
    end
    
end

geneome_x.n_layer=flag_l;
geneome_x.list_layers=l;

end

