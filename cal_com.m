function Compl=cal_com(genome_x_n_node,genome_x_enable_weights)

genome_x_enable_weights=sign(genome_x_enable_weights.*genome_x_enable_weights);
n=genome_x_n_node;


for i=1:size(genome_x_enable_weights,1)
    d_ou(i)=sum(genome_x_enable_weights(i,:));
    d_in(i)=sum(genome_x_enable_weights(:,i));
end
E=[];
for i=1:size(genome_x_enable_weights,1)
    for j=1:size(genome_x_enable_weights,1)
        if genome_x_enable_weights(i,j)==1
            E=[E;i,j];
        end
    end
end

Compl=1-1/n;
for i=1:size(E,1)    
    Compl=Compl-((1/n)^2)*(1/(d_ou(E(i,1))*d_in(E(i,2))));
end

end

