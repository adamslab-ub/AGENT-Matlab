function s_nT=ranker(u_n,N)

global num_objectives;

u_n_x=u_n.list_num_genomes;
s_nT=u_n;
s_n=[];

flag_rank=1;
u_n.list_num_genomes.fit_fun;

if num_objectives>1
    
    while(N>=1)
        % Sort by first OBJECTIVE
        [u_n_x]=merge_sorter_B(u_n_x,N);
        
        [n_d,dom]=fronter_2(u_n_x,N);

        for i=1:size(n_d,2)
            for j=1:num_objectives
                f_for_disi(i,j)=n_d(i).fit_fun(j);
            end
        end
        
        dis_inpareto=min(find_dis_in_pareto_new(size(n_d,2),f_for_disi),1);
        for i=1:size(n_d,2)
            n_d(i).rank=flag_rank-0.1*dis_inpareto(i);
        end
        s_n=[s_n n_d];
        
        flag_rank=flag_rank+1;
        u_n_x=dom;
        N=size(dom,2);
        
    end
else
    
    u_n_x=u_n.list_num_genomes;
    s_nT=u_n;
    
    if(N>=1)
        s_n=merge_sorter_B(u_n_x,N);
    end
    flag_rank =1;
    s_n(1).rank = flag_rank;
    
    for i = 2: N
        if s_n(i).fit_fun(1)<s_n(i-1).fit_fun(1)
            flag_rank = flag_rank+1;
        end
        s_n(i).rank =flag_rank;
    end
    
    s_nT.list_num_genomes=s_n;
    
    
end

s_nT.list_num_genomes=s_n;
end

