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
% all_best=[];
SAVE_TOCHECK_MAT.data = [];

while(not_ended)
    %     update_mute_coeffs(run_step,max_run_step);
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(1) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    %     niches(1).list_num_genomes(1).matrix_weights
    
    
    
    [input_for_FUNC]=find_fit_func(run_step,sample_id);
    
    %     niches(3).list_num_genomes(3).matrix_weights
    
    
    
    display('XXXXXXXXXXXX2')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    
        
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
        %         niches_info(run_step,:)=[0];
        for i_g=1:niches(i_n).size_niches
            flag_all_genomes = flag_all_genomes+1;
            niches_info(run_step,flag_all_genomes)=niches(i_n).list_num_genomes(i_g);% anyway unuseful
            %             niches_info(run_step,:)=[niches_info(run_step,:);niches(i_n).list_num_genomes(i_g).fit_fun(1)];% anyway unuseful
        end
        
    end
    display('XXXXXXXXXXXX3')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    %     niches(1).list_num_genomes(1).matrix_weights
    %     niches_info(1,25).matrix_weights
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(3) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    apply_simulate=0;
    for i_n=1:num_niches
        niches(i_n)=sort_by_ff3(niches(i_n));
        %          niches(i_n).size_niches
    end
    display('XXXXXXXXXXXX4')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(4) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    % niches(1).list_num_genomes(7).matrix_weights
    %     display(niches(1).list_num_genomes(2).matrix_weights)
    
    find_global_rank;
    
    
    %     display(niches(1).list_num_genomes(2).matrix_weights)
    
    list_to_FUNC=[];
    
    display('XXXXXXXXXXXX5')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(5) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
        
    grow_or_shrink;
    display('XXXXXXXXXXXX6')
    display(rand)

    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(6) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    flag_step=flag_step+1;
    display('XXXXXXXXXXXX7')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
   if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(7) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    
    
    
    %     for i_n=1:num_niches
    %         ['niches ' , num2str(i_n)]
    %         for i_g=1:niches(i_n).size_niches
    %             ['genome ' , num2str(i_g)]
    % %             niches(i_n).list_num_genomes(i_g).matrix_weights
    %             niches(i_n).list_num_genomes(i_g).fit_fun
    %             niches(i_n).list_num_genomes(i_g).rank
    %             niches(i_n).list_num_genomes(i_g).rank_global
    %         end
    %     end
    %     if run_step==1
    %         sdsadsadsadsadsadsad
    %     end
    
    if isempty(list_to_FUNC)==0
        make_FUN(list_to_FUNC,run_step,sample_id);
    end
    for i_n=1:num_niches
        niches(i_n)=sort_by_ff3(niches(i_n));
    end
    
    % niches(2).list_num_genomes(3).matrix_weights
    
    display('XXXXXXXXXXXX8')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(9) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    %     clc
    
    for i_n=1:num_niches
        [niches(i_n)]=my_GA(niches(i_n));
    end
    display('XXXXXXXXXXXX10')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(10) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    
    
    %     niches(3).list_num_genomes(5).matrix_weights
    
    
    flag_step=flag_step+1;
    if isempty(list_to_FUNC)==0
        make_FUN(list_to_FUNC,run_step,sample_id);
    end
    display('XXXXXXXXXXXX11')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(12) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    find_global_rank;
    display('XXXXXXXXXXXX13')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(13) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    display('XXXXXXXXXXXX14')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(14) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    
    for i_n=1:num_niches
        %         niches(:).size_niches
        elites_GA(niches(i_n),i_n);
    end
    display('XXXXXXXXXXXX15')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %     DSADSA
    display('XXXXXXXXXXXX16')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(17) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    find_global_rank;
    
    display('XXXXXXXXXXXX18')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(18) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    display('XXXXXXXXXXXX19')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
        
        '$$$$$$$$$$$$$$$$$$$$'
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
    %     D_now =0;
    %     num_win_tor_num_enter_tor =0;
    [num_win_tor_num_enter_tor,D_now] = change_based_on_diversit_and_improvment(run_step,max_run_step,Best_it,ave_it,sample_id);
    D_now
    num_win_tor_num_enter_tor
    display('XXXXXXXXXXXX20')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(22) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(22) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
    
    display('XXXXXXXXXXXX23')
    display(rand)
    
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
    
    % FIND NICHES EGAIN
    init_niches(run_step);
    display('XXXXXXXXXXXX235')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
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
        % oBviously so wrong
        %         if (Total_AGENT_CPU_time)<=Total_AGENT_CPU_time
        %             not_ended=0;
        %         end
    end
    
    
    display('XXXXXXXXXXXX24')
    display(rand)
    %display(niches(3).list_num_genomes(3).matrix_weights)
    %display(niches(3).list_num_genomes(3).fit_fun)
    %display(niches(3).list_num_genomes(3).rank)
    %display(niches(3).list_num_genomes(3).rank_global)
    if 1
        flag_mat_save = 0;
        for i_n=1:num_niches
            %             ['niches ' , num2str(i_n)]
            for i_g=1:niches(i_n).size_niches
                %                 ['genome ' , num2str(i_g)]
                %                 if niches(i_n).list_num_genomes(i_g).fit_fun<-10
                %                     niches(i_n).list_num_genomes(i_g).matrix_weights.
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = [i_n,i_g];
                
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).matrix_weights;
                %                 end
                %                 niches(i_n).list_num_genomes(i_g).fit_fun
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).fit_fun;
                %                 niches(i_n).list_num_genomes(i_g).rank
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank;
                %                 niches(i_n).list_num_genomes(i_g).rank_global
                flag_mat_save = flag_mat_save+1;
                SAVE_TOCHECK_MAT(flag_mat_save).data = niches(i_n).list_num_genomes(i_g).rank_global;
            end
        end
        save(['SAVE_TOCHECK_MAT' num2str(run_step-1) ' on ' num2str(24) '.mat'],'SAVE_TOCHECK_MAT');
        
    end
end

save(['SAVE_DATA' num2str(sample_id)  'niches_info.mat'],'niches_info');
save(['SAVE_DATA' num2str(sample_id)  'niches_info_size.mat'],'niches_info_size');


% % for i=1:s_all_best
% %     optimal_ANN(i)
% % end
%
% for i=1:s_all_best
%     [optimal_ANN(i),~,~]=FUNC(optimal_ANN(i),input_for_FUNC,i,run_step,sample_id);
%     We=optimal_ANN(i).matrix_weights;
%     En=optimal_ANN(i).enable_weights;
%     Ln=optimal_ANN(i).list_node;
%     Fv=optimal_ANN(i).fit_fun;
%     Ex=optimal_ANN(i).experience;
%     Fa=[optimal_ANN(i).fathers(:,1);.01;optimal_ANN(i).fathers(:,2)];
%     Co=optimal_ANN(i).constraints;
%     Gr=optimal_ANN(i).rank_global;
%     Cp=optimal_ANN(i).complexity;
%
%     Ed=[666];
%     for gg=1:optimal_ANN(i).n_edge
%         GE=[optimal_ANN(i).edge_gene(gg).start,optimal_ANN(i).edge_gene(gg).end,optimal_ANN(i).edge_gene(gg).weight,optimal_ANN(i).edge_gene(gg).enable,optimal_ANN(i).edge_gene(gg).inn_number];
%         Ed=[Ed,777,GE];
%     end
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'We'  num2str(i) '.mat'];
%     save(filename,'We');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'En' num2str(i) '.mat'];
%     save(filename,'En');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Ln' num2str(i) '.mat'];
%     save(filename,'Ln');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Fv' num2str(i) '.mat'];
%     save(filename,'Fv');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Ex' num2str(i) '.mat'];
%     save(filename,'Ex');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Fa' num2str(i) '.mat'];
%     save(filename,'Fa');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Gr' num2str(i) '.mat'];
%     save(filename,'Gr');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Ed' num2str(i) '.mat'];
%     save(filename,'Ed');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Co' num2str(i) '.mat'];
%     save(filename,'Co');
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'Cp' num2str(i) '.mat'];
%     save(filename,'Cp');
% end
%
% for i=1:s_all_best
%     filename=['SAVE_DATA' num2str(sample_id) ' BEST_ Intermediate on Iteration ' num2str(run_step-1) 'DD'  num2str(i) '.csv'];
%
%     Ln_ID=zeros(length(Ln),1);
%     Ln_TY=zeros(length(Ln),1);
%     Ln_TI=zeros(length(Ln),1);
%     Ln_HW=zeros(length(Ln),max_hist_node+1);
%     for i=1:length(Ln)
%         Ln_ID(i)=Ln(i).list_node_ID;
%         Ln_TY(i)=Ln(i).list_node_type;
%         Ln_TI(i)=Ln(i).list_node_time;
%         Ln(i).list_node_history_W
%         Ln_HW(i,:)=Ln(i).list_node_history_W;
%     end
% end

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
%
% for i=1:s_all_best
%
%     filename=['optimal_ANN ' num2str(sample_id) ' optimal_ANN ' num2str(i) '.csv'];
%     Ln_ID=zeros(length(Ln),1);
%     Ln_TY=zeros(length(Ln),1);
%     Ln_TI=zeros(length(Ln),1);
%     Ln_HW=zeros(length(Ln),max_hist_node+1);
%     for i=1:length(Ln)
%         Ln_ID(i)=Ln(i).list_node_ID;
%         Ln_TY(i)=Ln(i).list_node_type;
%         Ln_TI(i)=Ln(i).list_node_time;
%         Ln_HW(i,:)=Ln(i).list_node_history_W;
%     end
%
% end
% flag=0;
% best_of_best=niches(1).list_num_genomes(1).fit_fun(1)-10;
% flag=0;
% Complexiy_experience_performance=[];
% for i_n=1:num_niches
%     for kk=1:niches(i_n).size_niches
%
%         flag=flag+1;
%         ab(flag).We=niches(i_n).list_num_genomes(kk).matrix_weights;
%         ab(flag).En=niches(i_n).list_num_genomes(kk).enable_weights;
%         ab(flag).Ln=niches(i_n).list_num_genomes(kk).list_node;
%         ab(flag).Fv=niches(i_n).list_num_genomes(kk).fit_fun;
%         ab(flag).Ex=niches(i_n).list_num_genomes(kk).experience;
%         ab(flag).Cp=niches(i_n).list_num_genomes(kk).complexity;
%         ab(flag).Fa=[niches(i_n).list_num_genomes(kk).fathers(:,1);.01;niches(i_n).list_num_genomes(kk).fathers(:,2)];
%         ab(flag).Gr=niches(i_n).list_num_genomes(kk).list_node;
%         Edi=[666];
%         for gg=1:niches(i_n).list_num_genomes(kk).n_edge
%             GE=[niches(i_n).list_num_genomes(kk).edge_gene(gg).start,niches(i_n).list_num_genomes(kk).edge_gene(gg).end,niches(i_n).list_num_genomes(kk).edge_gene(gg).weight,niches(i_n).list_num_genomes(kk).edge_gene(gg).enable,niches(i_n).list_num_genomes(kk).edge_gene(gg).inn_number];
%             Edi=[Edi,777,GE];
%         end
%         ab(flag).Ed=Edi;
%         ab(flag).Co=niches(i_n).list_num_genomes(kk).constraints;
%         if niches(i_n).list_num_genomes(kk).fit_fun(1)>=best_of_best
%             best_of_best=niches(i_n).list_num_genomes(kk).fit_fun(1);
%             optimized=niches(i_n).list_num_genomes(kk);
%         end
%     end
% end
%
% filename=['SAVE_DATA' num2str(sample_id) ' finalpop.mat'];
% save(filename,'ab');

% We=optimized.matrix_weights;
% En=optimized.enable_weights;
% Ln=optimized.list_node;
% Fv=optimized.fit_fun;
% Ex=optimized.experience;
% Fa=[optimized.fathers(:,1);.01;optimized.fathers(:,2)];
% Cp=optimized.complexity;

% Ed=[666];

% Co=optimized.constraints;
% filename=['SAVE_DATA' num2str(sample_id) ' optimized.csv'];
%
% Ln_ID=zeros(length(Ln),1);
% Ln_TY=zeros(length(Ln),1);
% Ln_TI=zeros(length(Ln),1);
% Ln_HW=zeros(length(Ln),max_hist_node+1);
% for i=1:length(Ln)
%     Ln_ID(i)=Ln(i).list_node_ID;
%     Ln_TY(i)=Ln(i).list_node_type;
%     Ln_TI(i)=Ln(i).list_node_time;
%     Ln_HW(i,:)=Ln(i).list_node_history_W;
% end
% genome_x_n_node=optimized.n_node;% num nodes
% genome_x_n_layer=optimized.n_layer;%num layers
% genome_x_list_layers=optimized.list_layers;% layers
% genome_x_matrix_weights=optimized.matrix_weights; % Adjacency Matrix
% genome_x_enable_weights=optimized.enable_weights; % Enable Matrix

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
%
% df=max(Best_it)-min(Best_it);
%
% min_acceptable_f_bests=perc_bests*df+min(Best_it);
%
% flag=0;
% for i_n=1:num_niches
%     for kk=1:niches(i_n).size_niches
%         if niches(i_n).list_num_genomes(kk).fit_fun(1)>=min_acceptable_f_bests
%             flag=flag+1;
%             list_heroes_T(flag)=niches(i_n).list_num_genomes(kk);
%         end
%     end
% end
%
% filename=['SAVE_DATA' num2str(sample_id)  ' List of heroes_T .mat'];
% save(filename,'list_heroes_T');
%
%
% list_heroes=chooseonly_some_frome_pareto(list_heroes_T);
%
%
% optimed=list_heroes;
% filename=['SAVE_DATA' num2str(sample_id)  ' Optimed .mat'];
% save(filename,'optimed');
%
%
% best_f_optimed=optimed(1).fit_fun(1);
%
% flag=0;
% for kk=1:size(optimed,1)
%     if optimed(kk).fit_fun(1)>=best_f_optimed
%         fbest_f_optimed=optimed(kk).fit_fun(1);
%         best_of_best_optimed=optimed(kk);
%     end
% end
% filename=['SAVE_DATA' num2str(sample_id)  ' best_of_best_optimed .mat'];
% save(filename,'best_of_best_optimed');
%
%
% filename=['SAVE_DATA' num2str(sample_id)  ' _sRESULT_OF_RUN_AGENT.mat'];
% save(filename,'fbest_f_optimed');
% ff=fbest_f_optimed;
%
% st_Gr=[];
% for gg=1:best_of_best_optimed.n_edge
%     st_Gr=[st_Gr;best_of_best_optimed.edge_gene(gg).start,best_of_best_optimed.edge_gene(gg).end];
% end
%
% f22=figure;
% [st,idx]=sort(union(st_Gr(:,1),st_Gr(:,2)));
%
% for j=1:max(idx)
%     id(st(j))=idx(j);
% end
% for i=1:size(st_Gr,1)
%     st_Gr(i,1)=id(st_Gr(i,1));
%     st_Gr(i,2)=id(st_Gr(i,2));
% end
%
% mark_GR=zeros(max(max(st_Gr)));
%
% gg=[];
% for i=1:size(st_Gr,1)
%     if mark_GR(st_Gr(i,1),st_Gr(i,2))==0
%         mark_GR(st_Gr(i,1),st_Gr(i,2))=1;
%         gg=[gg;st_Gr(i,1),st_Gr(i,2)];
%     end
% end
% G=digraph(gg(:,1),gg(:,2));
% plot(G);
% formatOut = 'MM-HH dd mmm yyyy';
% timer=datestr(datenum(now),formatOut);
%
% add=['Best net '  num2str(sample_id) ' ontime' timer '.fig'];
% saveas(f22,add);
% add=['Best net '  num2str(sample_id) ' ontime' timer '.png'];
% saveas(f22,add);

end