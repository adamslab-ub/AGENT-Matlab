function run_AGENT(sample_id)

global niches num_niches  num_objectives total_counter_Amir total_totalStepCounter;
global apply_simulate MIN_OBJ;
global n_second_part total_eval max_hist_node perc_bests;
global list_to_FUNC D_init;
global min_run_step max_run_step stalled_iteration tolerance_f Total_AGENT_CPU_time F_best_till_now;

total_counter_Amir =0;
total_totalStepCounter = 0;

D_init=getdiversity;
total_eval = 0;
F_best_till_now = MIN_OBJ;

not_ended=1;
flag_step=0;
run_step=1;
fff=figure('units','normalized','outerposition',[0 0 1 1]);

Num_sim_done=0;
SAVE_TOCHECK_MAT.data = [];

while(not_ended)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(0) '.mat'],'SAVE_TOCHECK_MAT');
        
    end   
    
    cpu_start=tic;
    display(['Iteration ' num2str(run_step) ]);
    display('XXXXXXXXXXXX1')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(1) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    [input_for_FUNC]=find_fit_func(run_step,sample_id);
    
    display('XXXXXXXXXXXX2')
    display(rand)
        
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(2) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    
    
    flag_step=flag_step+1;
    
    T=0;
    flag_all_genomes =0;
    for i_n=1:num_niches
        niches_info_size(run_step,2*(i_n-1)+1)=niches(i_n).size_niches;
        T=T+niches(i_n).size_niches;
        niches_info_size(run_step,2*(i_n-1)+2)=niches(i_n).number_niches;
        for i_g=1:niches(i_n).size_niches
            flag_all_genomes = flag_all_genomes+1;
            niches_info(run_step,flag_all_genomes)=niches(i_n).list_num_genomes(i_g);% anyway unuseful
        end
        
    end
    display('XXXXXXXXXXXX3')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(3) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    apply_simulate=0;
    for i_n=1:num_niches
        niches(i_n)=sort_by_ff3(niches(i_n));
    end
    display('XXXXXXXXXXXX4')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(4) '.mat'],'SAVE_TOCHECK_MAT');
        
    end

    find_global_rank;
    
    list_to_FUNC=[];
    
    display('XXXXXXXXXXXX5')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(5) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
        
    grow_or_shrink;
    display('XXXXXXXXXXXX6')
    display(rand)

    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(6) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    flag_step=flag_step+1;
    display('XXXXXXXXXXXX7')
    display(rand)
   if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(7) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    
    if isempty(list_to_FUNC)==0
        make_FUN(list_to_FUNC,run_step,sample_id);
    end
    for i_n=1:num_niches
        niches(i_n)=sort_by_ff3(niches(i_n));
    end
    
    display('XXXXXXXXXXXX8')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(8) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    list_to_FUNC=[];
    find_global_rank;
    display('XXXXXXXXXXXX9')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(9) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    for i_n=1:num_niches
        [niches(i_n)]=my_GA(niches(i_n));
    end
    display('XXXXXXXXXXXX10')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(10) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    flag_step=flag_step+1;
    if isempty(list_to_FUNC)==0
        make_FUN(list_to_FUNC,run_step,sample_id);
    end
    display('XXXXXXXXXXXX11')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(11) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    list_to_FUNC=[];
    for i_n=1:num_niches
        niches(i_n)=sort_by_ff3(niches(i_n));
    end
    display('XXXXXXXXXXXX12')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(12) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    find_global_rank;
    display('XXXXXXXXXXXX13')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(13) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    display('XXXXXXXXXXXX14')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(14) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    for i_n=1:num_niches
        elites_GA(niches(i_n),i_n);
    end
    display('XXXXXXXXXXXX15')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(15) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    flag_step=flag_step+1;
    
    if isempty(list_to_FUNC)==0
        make_FUN(list_to_FUNC,run_step,sample_id);
    end
    display('XXXXXXXXXXXX16')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(16) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    list_to_FUNC=[];
    for i_n=1:num_niches
        niches(i_n)=sort_by_ff3(niches(i_n));
    end
    
    display('XXXXXXXXXXXX17')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(17) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    find_global_rank;
    
    display('XXXXXXXXXXXX18')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(18) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    display('XXXXXXXXXXXX19')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(19) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    if num_objectives==1
        
        if run_step>1
            copy_it=1;
            for i_n=1:num_niches
                for kk=1:niches(i_n).size_niches
                    if niches(i_n).list_num_genomes(kk).fit_fun(1)>=best
                        copy_it=0;
                    end
                end
            end
            if copy_it
                niches(1).list_num_genomes(1)=best_genome;
            end
        end
        
        aver=0;
        best=niches(1).list_num_genomes(1).fit_fun(1)-10;
        Com_aver=0;
        flag=0;
        
        for i_n=1:num_niches
            for kk=1:niches(i_n).size_niches
                flag=flag+1;
                if niches(i_n).list_num_genomes(kk).constraints<=0
                    aver=aver+niches(i_n).list_num_genomes(kk).fit_fun(1);
                    if niches(i_n).list_num_genomes(kk).fit_fun(1)>=best
                        best=niches(i_n).list_num_genomes(kk).fit_fun(1);
                        best_genome=niches(i_n).list_num_genomes(kk);
                    end
                end
            end
        end
        
        best
        
        if run_step>1
            if  best>best_old
                best_old=best;
                best_genome_old=best_genome;
            else
                best=best_old;
                best_genome=best_genome_old;
            end
        else
            
            best_old=best;
            best_genome_old=best_genome;
        end
        
        Num_sim_done=Num_sim_done+n_second_part;
        
        N_x(run_step)=total_eval;
        
        Best_it(run_step)=best;
        ave_it(run_step)=aver/flag;
        
        
    end
    [num_win_tor_num_enter_tor,D_now] = change_based_on_diversit_and_improvment(run_step,max_run_step,Best_it,ave_it,sample_id);
    D_now
    num_win_tor_num_enter_tor
    display('XXXXXXXXXXXX20')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(20) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    div_it(run_step)=D_now;
    select_it(run_step)=num_win_tor_num_enter_tor;
    func_it(run_step)=num_win_tor_num_enter_tor;
    total_counter_Amir_it(run_step) = total_counter_Amir;
    total_totalStepCounter_it(run_step) = total_totalStepCounter;
    
    run_step=run_step+1;
    display('XXXXXXXXXXXX21')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(21) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    if num_objectives==1
        
        subplot(2,5,1);
        plot(N_x,Best_it);
        title( '  Best Solution');
        xlabel('Number of Simulations')
        ylabel('Best Function Value')
        grid on
        hold on
        
        subplot(2,5,6)
        plot(N_x,ave_it)
        title( '  Average Solution');
        xlabel('Number of Simulations')
        ylabel('Average Function Value')
        grid on
        hold on
        
        subplot(2,5,2);
        plot(Best_it);
        title( '  Best Solution');
        xlabel('Number of Iterations')
        ylabel('Best Function Value')
        grid on
        hold on
        
        subplot(2,5,7)
        plot(ave_it)
        title( '  Average Solution');
        xlabel('Number of Iterations')
        ylabel('Average Function Value')
        grid on
        hold on
        
        
        subplot(2,5,3);
        plot(div_it);
        title( '  Diversity of Population');
        xlabel('Number of Iterations')
        ylabel('Diversity')
        grid on
        hold on
        
        subplot(2,5,8)
        plot(select_it)
        title( '  tournament Ratio');
        xlabel('Number of Iterations')
        ylabel('Tour nament ratio')
        grid on
        hold on
        
        subplot(2,5,4)
        plot(N_x)
        title( '  Function Evaluations');
        xlabel('Number of Iterations')
        ylabel('Number of function Evaluation')
        grid on
        hold on
        
        subplot(2,5,9)
        plot(total_counter_Amir_it)
        title( '  Simulation Episodes');
        xlabel('Number of Iterations')
        ylabel('Number of Episodes in simulation')
        grid on
        hold on
        
        subplot(2,5,5)
        plot(total_totalStepCounter_it)
        title( '  Simulation step');
        xlabel('Number of Iterations')
        ylabel('Number of Step in simulation')
        grid on
        hold on
        
        pause(0.1)
        
        plot_data.N_x=N_x;
        plot_data.Best_it=Best_it;
        plot_data.ave_it=ave_it;
        
        plot_data.div_it=div_it;
        plot_data.select_it=select_it;
        
        plot_data.total_counter_Amir_it=total_counter_Amir_it;
        plot_data.total_totalStepCounter_it=total_totalStepCounter_it;
        
        saveas(fff,['SAVE_DATA' num2str(sample_id)  'Concvs' num2str(run_step-1) '.fig'])
        saveas(fff,['SAVE_DATA' num2str(sample_id)  'Concvs' num2str(run_step-1) '.png'])
        save(['SAVE_DATA' num2str(sample_id)  'plot_data' num2str(run_step-1) '.mat'],'plot_data');
        
    end
    
    % Save the Best genome
    best_fun_val=MIN_OBJ;
    for i_n=1:num_niches
        for kk=1:niches(i_n).size_niches
            if niches(i_n).list_num_genomes(kk).constraints<=0
                if niches(i_n).list_num_genomes(kk).fit_fun(1)>best_fun_val
                    best_fun_val=niches(i_n).list_num_genomes(kk).fit_fun(1);
                    best_genome=niches(i_n).list_num_genomes(kk);
                end
            end
        end
    end
    
    display('XXXXXXXXXXXX22')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(22) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(22) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    display('XXXXXXXXXXXX23')
    display(rand)
    
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(23) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    filename=['SAVE_DATA' num2str(sample_id)  'BEST GENOME Intermediate on Iteration ' num2str(run_step-1) '.mat'];
    save(filename,'best_genome');
    
    % Save all genomes
    filename=['SAVE_DATA' num2str(sample_id)  'NICHES Intermediate on Iteration ' num2str(run_step-1) '.mat'];
    save(filename,'niches');
    
    save(['SAVE_DATA' num2str(sample_id)  'niches_info.mat'],'niches_info');
    save(['SAVE_DATA' num2str(sample_id)  'niches_info_size.mat'],'niches_info_size');
    
    % FIND NICHES AGAIN
    init_niches(run_step);
    display('XXXXXXXXXXXX235')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(23.5) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    Time_for_this_iteration=toc(cpu_start);
    display(['Iteration ' num2str(run_step-1) ' took ' num2str(Time_for_this_iteration) ' seconds.']);
    
    if run_step>min_run_step
        
        if (Best_it(run_step-1)-Best_it(run_step-1-stalled_iteration))/Best_it(run_step-1)<=tolerance_f
            not_ended=0;
        end
        if run_step>max_run_step
            not_ended=0;
        end
    end
    
    
    display('XXXXXXXXXXXX24')
    display(rand)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            for i_g=1:niches(i_n).size_niches
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(24) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
end

save(['SAVE_DATA' num2str(sample_id)  'niches_info.mat'],'niches_info');
save(['SAVE_DATA' num2str(sample_id)  'niches_info_size.mat'],'niches_info_size');

% Save the Best genome
best_fun_val=MIN_OBJ;
for i_n=1:num_niches
    for kk=1:niches(i_n).size_niches
        if niches(i_n).list_num_genomes(kk).constraints<=0
            if niches(i_n).list_num_genomes(kk).fit_fun(1)>best_fun_val
                best_fun_val=niches(i_n).list_num_genomes(kk).fit_fun(1);
                best_genome=niches(i_n).list_num_genomes(kk);
            end
        end
    end
end
filename=['SAVE_DATA' num2str(sample_id)  'BEST GENOME Intermediate on Iteration ' num2str(run_step-1) '.mat'];
save(filename,'best_genome');

% Save all genomes
filename=['SAVE_DATA' num2str(sample_id)  'NICHES Intermediate on Iteration ' num2str(run_step-1) '.mat'];
save(filename,'niches');

formatOut = 'MM-HH dd mmm yyyy';
timer=datestr(datenum(now),formatOut);

add=['FINAL convergence ' num2str(sample_id)  ' ontime' timer '.fig'];
saveas(fff,add);
add=['FINAL convergence ' num2str(sample_id)  ' ontime' timer '.png'];
saveas(fff,add);

f22=figure;
optimized = best_genome;
st_Gr=[];
Ed=[666];
Ed=[];
for gg=1:optimized.n_edge
    GE=[optimized.edge_gene(gg).start,optimized.edge_gene(gg).end,optimized.edge_gene(gg).weight,optimized.edge_gene(gg).enable,optimized.edge_gene(gg).inn_number];
    Ed=[Ed,GE];
    st_Gr=[st_Gr;optimized.edge_gene(gg).start,optimized.edge_gene(gg).end];
end
[st,idx]=sort(union(st_Gr(:,1),st_Gr(:,2)));

for j=1:max(idx)
    id(st(j))=idx(j);
end
for i=1:size(st_Gr,1)
    st_Gr(i,1)=id(st_Gr(i,1));
    st_Gr(i,2)=id(st_Gr(i,2));
end

mark_GR=zeros(max(max(st_Gr)));

gg=[];
for i=1:size(st_Gr,1)
    if mark_GR(st_Gr(i,1),st_Gr(i,2))==0
        mark_GR(st_Gr(i,1),st_Gr(i,2))=1;
        gg=[gg;st_Gr(i,1),st_Gr(i,2)];
    end
end
G=digraph(gg(:,1),gg(:,2));
plot(G);
formatOut = 'MM-HH dd mmm yyyy';
timer=datestr(datenum(now),formatOut);

add=['SAVE_DATA' num2str(sample_id)  'optimized ontime' timer '.fig'];
saveas(f22,add);
add=['SAVE_DATA' num2str(sample_id)  'optimized ontime' timer '.png'];
saveas(f22,add);

end