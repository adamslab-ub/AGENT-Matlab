function [outp,out_needed]=fAnn(inp,out_needed)% normal in normal use normal out
  
inp = [inp,1];
%out_needed.list_node

min_output=out_needed.min_output_local;
max_output=out_needed.max_output_local;
min_inp=out_needed.min_inp_local;
max_inp=out_needed.max_inp_local;

n_l=out_needed.n_l_local;%num layers
l=out_needed.l_local;% layers

w=out_needed.w_local; % Adjacency Matrix
e=out_needed.e_local; % Enable Matrix

list_node=out_needed.list_node;

num_input=out_needed.num_input_local;
num_output=out_needed.num_output_local;
size_layer(1)=size(l{1},2);

for j=1:num_input-1
    inp(j)=(inp(j)-min_inp(j))/(max_inp(j)-min_inp(j));
end

max_max_inp = max(max_inp);
min_min_inp = min(min_inp);

inp=2*(inp-0.5);
if size(inp,1)>size(inp,2)% ensure it is row
    inp =inp';
end


%inp

%%%% inp=[inp 1]; % add Bias dEFIENTLY WRONG REDUNDANT, BUT GOOD NEWS IS IT
%%%% IS HARMLESS
for j=1:size_layer(1)
    v{1}(j)=inp(j);
    
    for i_t=1:list_node(l{1}(j)).list_node_time
        v{1}(j)=v{1}(j) + list_node(l{1}(j)).list_node_history_W(i_t) * list_node(l{1}(j)).list_node_history(i_t);
    end
    
    for i_t=list_node(l{1}(j)).list_node_time:-1:2
        list_node(l{1}(j)).list_node_history(i_t)=list_node(l{1}(j)).list_node_history(i_t-1);
        if list_node(l{1}(j)).list_node_history(i_t) > max_max_inp
            list_node(l{1}(j)).list_node_history(i_t) = max_max_inp;
        end
        if list_node(l{1}(j)).list_node_history(i_t) < min_min_inp
            list_node(l{1}(j)).list_node_history(i_t) = min_min_inp;
        end
    end
    if list_node(l{1}(j)).list_node_time>=1
        list_node(l{1}(j)).list_node_history(1)=v{1}(j);
        if list_node(l{1}(j)).list_node_history(1) > max_max_inp
            list_node(l{1}(j)).list_node_history(1) = max_max_inp;
        end
        if list_node(l{1}(j)).list_node_history(1) < min_min_inp
            list_node(l{1}(j)).list_node_history(1) = min_min_inp;
        end
    end
    f{1}(j)=v{1}(j);
    %list_node(l{1}(j)).list_node_history
end


for i_l1=2:n_l-1
    size_layer(i_l1)=size(l{i_l1},2);

    for i_l2=1:i_l1-1
        for j1=1:size_layer(i_l1)
            v{i_l1}(j1)=0;
            for j2=1:size_layer(i_l2)
                v{i_l1}(j1)=v{i_l1}(j1)+e(l{i_l2}(j2),l{i_l1}(j1))*w(l{i_l2}(j2),l{i_l1}(j1))*f{i_l2}(j2);
                %w(l{i_l2}(j2),l{i_l1}(j1))
                %e(l{i_l2}(j2),l{i_l1}(j1))
                %f{i_l2}(j2)
            end
            
%             display(v{i_l1})
            
            %  % so
            % Wrong, it should come after giving val to v
            for i_t=1:list_node(l{i_l1}(j1)).list_node_time
                v{i_l1}(j1)=v{i_l1}(j1) + list_node(l{i_l1}(j1)).list_node_history_W(i_t) * list_node(l{i_l1}(j1)).list_node_history(i_t);
            end
            
            % list_node(l{i_l1}(j1)).list_node_history
            for i_t=list_node(l{i_l1}(j1)).list_node_time:-1:2
                list_node(l{i_l1}(j1)).list_node_history(i_t)=list_node(l{i_l1}(j1)).list_node_history(i_t-1);
                if list_node(l{i_l1}(j1)).list_node_history(i_t) > max_max_inp
                    list_node(l{i_l1}(j1)).list_node_history(i_t) = max_max_inp;
                end
                if list_node(l{i_l1}(j1)).list_node_history(i_t) < min_min_inp
                    list_node(l{i_l1}(j1)).list_node_history(i_t) = min_min_inp;
                end
            end
            if list_node(l{i_l1}(j1)).list_node_time>=1
                list_node(l{i_l1}(j1)).list_node_history(1)=v{i_l1}(j1);
                if list_node(l{i_l1}(j1)).list_node_history(1) > max_max_inp
                    list_node(l{i_l1}(j1)).list_node_history(1) = max_max_inp;
                end
                if list_node(l{i_l1}(j1)).list_node_history(1) < min_min_inp
                    list_node(l{i_l1}(j1)).list_node_history(1) = min_min_inp;
                end
            end
            
            f{i_l1}(j1)=func_ANN(v{i_l1}(j1),list_node(l{i_l1}(j1)).list_node_type);
            
            
           % if (l{i_l1}(j1)>num_input) &&(l{i_l1}(j1)<=num_input+num_output)
               % F_t(l{i_l1}(j1)-num_input)=f{i_l1}(j1);
            %end
            % list_node(l{i_l1}(j1)).list_node_history
            % list_node(l{i_l1}(j1)).list_node_type
        end
        
    end
    
    % v{i_l1}
    % 'XXXXXX'
    % f{i_l1}
    % 'OOOOOO'
    
end

% LAST LAYER fORCED TO BE LINEAR
%n_l

for i_l1=n_l
    size_layer(i_l1)=size(l{i_l1},2);

    for i_l2=1:i_l1-1
        for j1=1:size_layer(i_l1)
            v{i_l1}(j1)=0;
            for j2=1:size_layer(i_l2)
                v{i_l1}(j1)=v{i_l1}(j1)+e(l{i_l2}(j2),l{i_l1}(j1))*w(l{i_l2}(j2),l{i_l1}(j1))*f{i_l2}(j2);
            end
            % list_node(l{i_l1}(j1)).list_node_history(1)=v{i_l1}(j1); % so
            % wrong
            for i_t=1:list_node(l{i_l1}(j1)).list_node_time
                v{i_l1}(j1)=v{i_l1}(j1) + list_node(l{i_l1}(j1)).list_node_history_W(i_t) * list_node(l{i_l1}(j1)).list_node_history(i_t);
            end
            
            for i_t=list_node(l{i_l1}(j1)).list_node_time:-1:2
                list_node(l{i_l1}(j1)).list_node_history(i_t)=list_node(l{i_l1}(j1)).list_node_history(i_t-1);
                if list_node(l{i_l1}(j1)).list_node_history(i_t) > max_max_inp
                    list_node(l{i_l1}(j1)).list_node_history(i_t) = max_max_inp;
                end
                if list_node(l{i_l1}(j1)).list_node_history(i_t) < min_min_inp
                    list_node(l{i_l1}(j1)).list_node_history(i_t) = min_min_inp;
                end
            end
            if list_node(l{i_l1}(j1)).list_node_time>=1
                list_node(l{i_l1}(j1)).list_node_history(1)=v{i_l1}(j1);
                if list_node(l{i_l1}(j1)).list_node_history(1) > max_max_inp
                    list_node(l{i_l1}(j1)).list_node_history(1) = max_max_inp;
                end
                if list_node(l{i_l1}(j1)).list_node_history(1) < min_min_inp
                    list_node(l{i_l1}(j1)).list_node_history(1) = min_min_inp;
                end
            end
            f{i_l1}(j1)=func_ANN(v{i_l1}(j1),0);
            
            if (l{i_l1}(j1)>num_input) &&(l{i_l1}(j1)<=num_input+num_output)
                F_t(l{i_l1}(j1)-num_input)=f{i_l1}(j1);
            end
%             list_node(l{i_l1}(j1)).list_node_history
        end
    end

end

% very large change, DANGER!!!!!!!!!!!
for i=1:num_output
    if F_t(i)>max_output(i)
        F_t(i) = max_output(i);
    end
    if F_t(i)<min_output(i)
        F_t(i) = min_output(i);
    end
    
    %outp(i)=(F_t(i)-0)*(max_output(i)-min_output(i))+min_output(i);
end
outp = F_t;
out_needed.list_node=list_node;


end

