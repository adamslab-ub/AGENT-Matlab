function geneome_x=mutate_it(geneome_x)

% geneome_x.matrix_weights
% rand
% '666666666666666666666'
% geneome_x.matrix_weights

global r_mute_w r_unif unif_perc r_mute_enable min_w max_w global_node_num global_geneom_num
global global_inn_num r_mute_add_edge r_mute_add_node r_mute_remove_node
global num_input num_output;
global apply_simulate MIN_OBJ RANK_0;
global N_fathers;
global N_nodetypes max_hist_node  r_mute_change_node_change_type r_mute_change_node_change_time;
global max_edge_for_one_genome max_node_for_one_genome;
global dt_dynamic_simulate;

global list_to_FUNC;

what_genome_was = geneome_x;

for i_edge=geneome_x.n_edge:-1:1
    
    %mute W
    r1=rand;
%     r1
    if r1<r_mute_w
%         '%yyyy1'
%         rand
%         'X1'
        r=i_edge;
        
        r_u=rand;
%         r_u
        if r_u<r_unif
            
            signer=2*randi(2)-3;
            rand;
            geneome_x.edge_gene(r).weight=geneome_x.edge_gene(r).weight+rand*(signer*unif_perc*(max_w-min_w));
%             rrx = sqrt(2) * erfinv(2 * rand - 1);
            % geneome_x.edge_gene(r).weight=geneome_x.edge_gene(r).weight+rrx*unif_perc*(max_w-min_w);
%             geneome_x.edge_gene(r).weight=geneome_x.edge_gene(r).weight+rrx*unif_perc*(max_w-min_w);
            if geneome_x.edge_gene(r).weight>max_w
                geneome_x.edge_gene(r).weight=max_w;
            end
            if geneome_x.edge_gene(r).weight<min_w
                geneome_x.edge_gene(r).weight=min_w;
            end
        else
            geneome_x.edge_gene(r).weight=min_w+rand*(max_w-min_w);
        end
        for i=1:geneome_x.n_node
            if geneome_x.edge_gene(r).start==geneome_x.list_node(i).list_node_ID
                st=i;
            end
            if geneome_x.edge_gene(r).end==geneome_x.list_node(i).list_node_ID
                en=i;
            end
        end
        geneome_x.matrix_weights(st,en)=geneome_x.edge_gene(r).weight;
    end
    
    %creat node
    if geneome_x.n_node<=max_node_for_one_genome
        
        r1=rand;
        if r1<r_mute_add_node
            %'yyyy2'
%             geneome_x.matrix_weights

%             rand
%             'X2'
            r=i_edge;
            
            geneome_x.n_edge=geneome_x.n_edge+1;
            global_node_num=global_node_num+1;
            geneome_x.n_node=geneome_x.n_node+1;
            
            
            new_list_node_x.list_node_ID=global_node_num;
            new_list_node_x.list_node_type=randi(N_nodetypes);
            rx=rand;
            if rx<0.5 
                new_list_node_x.list_node_time=randi(max_hist_node+1)-1;
            else
                new_list_node_x.list_node_time=0;
            end
            
            new_list_node_x.list_node_history=zeros(1,max_hist_node+1);
            new_list_node_x.list_node_history_W=zeros(1,max_hist_node+1);
    
            if new_list_node_x.list_node_time==0
                new_list_node_x.list_node_history_W=[1,0,0];
            elseif new_list_node_x.list_node_time==1
                new_list_node_x.list_node_history_W=[1,-1,0]/dt_dynamic_simulate;
            elseif new_list_node_x.list_node_time==2
                new_list_node_x.list_node_history_W=[1,-2,1]/(dt_dynamic_simulate^2);
            end
            geneome_x.list_node(geneome_x.n_node)=new_list_node_x;
            
            r_s=geneome_x.edge_gene(r).start;
            r_e=geneome_x.edge_gene(r).end;
            
            for i=1:geneome_x.n_node
                if geneome_x.list_node(i).list_node_ID==r_s
                    r1=i;
                end
                if geneome_x.list_node(i).list_node_ID==r_e
                    r2=i;
                end
            end
            geneome_x.matrix_weights (r1,r2)=0;
            geneome_x.enable_weights (r1,r2)=0;
            
            geneome_x.matrix_weights(:,geneome_x.n_node)=0;
            geneome_x.enable_weights(:,geneome_x.n_node)=0;
            geneome_x.enable_weights(r1,geneome_x.n_node)=1;
            geneome_x.matrix_weights(r1,geneome_x.n_node)=min_w+rand*(max_w-min_w);
            
            geneome_x.edge_gene(r).start=r_s;
            geneome_x.edge_gene(r).end=global_node_num;
            
            geneome_x.edge_gene(r).weight=geneome_x.matrix_weights(r1,geneome_x.n_node);
            geneome_x.edge_gene(r).enable=1;
            global_inn_num=global_inn_num+1;
            geneome_x.edge_gene(r).inn_number=global_inn_num;
            
            
            geneome_x.matrix_weights(geneome_x.n_node,:)=0;
            geneome_x.enable_weights(geneome_x.n_node,:)=0;
            geneome_x.enable_weights(geneome_x.n_node,r2)=1;
            geneome_x.matrix_weights(geneome_x.n_node,r2)=min_w+rand*(max_w-min_w);
            
            geneome_x.edge_gene(geneome_x.n_edge).start=global_node_num;
            geneome_x.edge_gene(geneome_x.n_edge).end=r_e;
            
            geneome_x.edge_gene(geneome_x.n_edge).weight=geneome_x.matrix_weights(geneome_x.n_node,r2);
            geneome_x.edge_gene(geneome_x.n_edge).enable=1;
            
            global_inn_num=global_inn_num+1;
            geneome_x.edge_gene(geneome_x.n_edge).inn_number=global_inn_num;
            geneome_x=relayer(geneome_x);
        end
        
        %mute enable
        r1X=rand;
        if r1X<r_mute_enable
%             'X3'
           % 'yyyy3'
%             rand
            r=i_edge;
            
            for i=1:geneome_x.n_node
                if geneome_x.edge_gene(r).start==geneome_x.list_node(i).list_node_ID
                    st=i;
                end
                if geneome_x.edge_gene(r).end==geneome_x.list_node(i).list_node_ID
                    en=i;
                end
            end
            st_is_safe_to_remove=0;
            en_is_safe_to_remove=0;
            for i_edge_check_some_other_path=1:geneome_x.n_edge
                if (geneome_x.edge_gene(i_edge_check_some_other_path).start == st) &&  (geneome_x.edge_gene(i_edge_check_some_other_path).end ~= en)
                    st_is_safe_to_remove =1;
                elseif (geneome_x.edge_gene(i_edge_check_some_other_path).end == en) &&  (geneome_x.edge_gene(i_edge_check_some_other_path).start ~= st)
                    en_is_safe_to_remove =1;
                end
            end
            
            if (st_is_safe_to_remove) && (en_is_safe_to_remove)
                geneome_x.enable_weights(st,en)=0;
                geneome_x.matrix_weights(st,en)=0;
                for ii_edge=r:geneome_x.n_edge-1
                    geneome_x.edge_gene(ii_edge)=geneome_x.edge_gene(ii_edge+1);
                end
                geneome_x.edge_gene(geneome_x.n_edge)=[];
                geneome_x.n_edge=geneome_x.n_edge-1;
                geneome_x=relayer(geneome_x);
                
            end
            
        end
        
        
    end
    
end

% geneome_x.matrix_weights
%create edge
if geneome_x.n_edge<=max_edge_for_one_genome% added for speed
    for i_nodes1=1:geneome_x.n_node
        for i_nodes2=num_input+1:geneome_x.n_node
            
            r1x=rand;
            if r1x<r_mute_add_edge
%             if r1x<-1
%                 'X4'
                 %'yyyy4'
%                  geneome_x.matrix_weights

%                  geneome_x.matrix_weights
%                 rand
                found_something=0;
                
                r1=i_nodes1;
                r2=i_nodes2;
                
                r_s=geneome_x.list_node(r1).list_node_ID;
                r_e=geneome_x.list_node(r2).list_node_ID;
                
                if (geneome_x.matrix_weights(r1,r2)==0)&&((r1<=num_input)||(r1>num_input+num_output))&&(r1~=r2)
                    found_something=1;
                    if (found_a_loop(geneome_x,r1,r2)==1)
                        found_something=0;
                    end
                end
                if found_something
                    geneome_x.matrix_weights(r1,r2)=min_w+rand*(max_w-min_w);
                    geneome_x.enable_weights(r1,r2)=1;
                    
                    geneome_x.n_edge=geneome_x.n_edge+1;
                    
                    geneome_x.edge_gene(geneome_x.n_edge).start=r_s;
                    geneome_x.edge_gene(geneome_x.n_edge).end=r_e;
                    geneome_x.edge_gene(geneome_x.n_edge).weight=geneome_x.matrix_weights(r1,r2);
                    geneome_x.edge_gene(geneome_x.n_edge).enable=1;
                     
                    global_inn_num=global_inn_num+1;
                    geneome_x.edge_gene(geneome_x.n_edge).inn_number=global_inn_num;
                    geneome_x=relayer(geneome_x);

                end
%                 found_something
%                 geneome_x.matrix_weights
%                 '%yyyy4DONE'
                 
            end
        end
    end
end
% geneome_x.matrix_weights
% on nodes
for i_nodes=geneome_x.n_node:-1:1
    r1x=rand;
    if r1x<r_mute_change_node_change_type
%         'X5'
%          '%yyyy5'
%             rand
        geneome_x.list_node(i_nodes).list_node_type=randi(N_nodetypes);
    end
    r1=rand;
    if r1<r_mute_change_node_change_time
%         'X6'
%          '%yyyy6'
%             rand
        geneome_x.list_node(i_nodes).list_node_type=randi(N_nodetypes);
        r2=rand;
        if r2<0.5
            geneome_x.list_node(i_nodes).list_node_time=randi(max_hist_node+1)-1;
        else
            geneome_x.list_node(i_nodes).list_node_time=0;
        end
        
        if geneome_x.list_node(i_nodes).list_node_time==0
            geneome_x.list_node(i_nodes).list_node_history_W=[1,0,0];
            
        elseif geneome_x.list_node(i_nodes).list_node_time==1
            geneome_x.list_node(i_nodes).list_node_history_W=[1,-1,0]/dt_dynamic_simulate;
        elseif geneome_x.list_node(i_nodes).list_node_time==2
            geneome_x.list_node(i_nodes).list_node_history_W=[1,-2,1]/(dt_dynamic_simulate^2);
            
        end
    end
    r1x=rand;
    if r1x<r_mute_remove_node
%         'X7'
        if i_nodes>num_input+num_output
             %'yyyy7'
%              geneome_x.matrix_weights
    
%             rand
            i_edge=geneome_x.n_edge;
            list_st=[];
            list_en=[];
            while i_edge>=1
                
                if geneome_x.edge_gene(i_edge).start==geneome_x.list_node(i_nodes).list_node_ID
                    list_en=[list_en;geneome_x.edge_gene(i_edge).end];
                    for jj_edge=i_edge:geneome_x.n_edge-1
                        geneome_x.edge_gene(jj_edge)=geneome_x.edge_gene(jj_edge+1);
                    end
                    geneome_x.edge_gene(geneome_x.n_edge) =[];
                    geneome_x.n_edge=geneome_x.n_edge-1;
                    
                elseif geneome_x.edge_gene(i_edge).end==geneome_x.list_node(i_nodes).list_node_ID
                    list_st=[list_st;geneome_x.edge_gene(i_edge).start];
                    for jj_edge=i_edge:geneome_x.n_edge-1
                        geneome_x.edge_gene(jj_edge)=geneome_x.edge_gene(jj_edge+1);
                    end
                    geneome_x.edge_gene(geneome_x.n_edge) =[];
                    geneome_x.n_edge=geneome_x.n_edge-1;
                    
                    %                 else
                    
                end
                i_edge=i_edge-1;
            end
            
            for i_n1=1:length(list_st)
                for jj=1:geneome_x.n_node
                    if geneome_x.list_node(jj).list_node_ID==list_st(i_n1)
                        list_st(i_n1)=jj;
                        break;
                    end
                end
            end
                
            for i_n2=1:length(list_en)
                for jj=1:geneome_x.n_node
                    if geneome_x.list_node(jj).list_node_ID==list_en(i_n2)
                        list_en(i_n2)=jj;
                        break;
                    end
                end
            end
            
            
            
            list_st=union(list_st,[]);
            list_en=union(list_en,[]);
%             list_st
%             list_en
%             'BBBBBBBBBBBBBBBBBBBBBBBBBBB'
%             list_st
%             list_en
%             'BBBBBBBBBBBBBBBBBBBBBBBBBBB'
            
            % add for the removed nodes
            for i_n1=1:length(list_st)
                for i_n2=1:length(list_en)
                    if geneome_x.matrix_weights(list_st(i_n1),list_en(i_n2))==0 || geneome_x.enable_weights(list_st(i_n1),list_en(i_n2))==0
                        geneome_x.matrix_weights(list_st(i_n1),list_en(i_n2))=min_w+rand*(max_w-min_w);
                        %(geneome_x.matrix_weights(list_st(i_n1),list_en(i_n2)))
                        geneome_x.enable_weights(list_st(i_n1),list_en(i_n2))=1;
                        
                        geneome_x.n_edge=geneome_x.n_edge+1;
                        
                        geneome_x.edge_gene(geneome_x.n_edge).start=geneome_x.list_node(list_st(i_n1)).list_node_ID;
                        geneome_x.edge_gene(geneome_x.n_edge).end=geneome_x.list_node(list_en(i_n2)).list_node_ID;
                        geneome_x.edge_gene(geneome_x.n_edge).weight=geneome_x.matrix_weights(list_st(i_n1),list_en(i_n2));
                        geneome_x.edge_gene(geneome_x.n_edge).enable=1;
                        
                        global_inn_num=global_inn_num+1;
                        geneome_x.edge_gene(geneome_x.n_edge).inn_number=global_inn_num;
                        
                    end
                end
            end
%             for i_node_x=i_nodes:length(geneome_x.list_node):geneome_x.n_node-1
            for i_node_x=i_nodes:geneome_x.n_node-1 % Changed because it was strange

                geneome_x.list_node(i_node_x)=geneome_x.list_node(i_node_x+1);
            end
            
            % geneome_x.list_node(i_nodes)=[];% it was like this but I
            % think it is wrong, the last one should be removed
            geneome_x.list_node(geneome_x.n_node)=[];% the updated one
            
            geneome_x.matrix_weights(:,i_nodes)=[];
            geneome_x.matrix_weights(i_nodes,:)=[];
            geneome_x.enable_weights(:,i_nodes)=[];
            geneome_x.enable_weights(i_nodes,:)=[];
            geneome_x.n_node=geneome_x.n_node-1;
            
            geneome_x=relayer(geneome_x);

        end
        
    end
end

% geneome_x.matrix_weights

if check_loop_imidietly(geneome_x)
% if 0
    
    geneome_x = what_genome_was;
    geneome_x.fit_fun(1)=MIN_OBJ;
    geneome_x.rank = RANK_0;
    geneome_x.rank_global = RANK_0;
else
    global_geneom_num=global_geneom_num+1;
    geneome_x.num_genome=global_geneom_num;
    
    geneome_x=relayer(geneome_x);
    geneome_x.fit_fun(1)=MIN_OBJ;
    geneome_x.rank = RANK_0;
    geneome_x.rank_global = RANK_0;
    N_fathers=N_fathers+1;
    geneome_x.fathers=[geneome_x.fathers;N_fathers,1];
    
%     apply_simulate=1;
    
    list_to_FUNC=[list_to_FUNC; geneome_x];
    
%     apply_simulate=0;
    
end

% geneome_x.matrix_weights
% '77777777777777777777777'    

end

