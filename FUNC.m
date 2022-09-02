function [genome_x,counter_Amir,totalStepCounter]=FUNC(genome_x,input_for_FUNC,genomeNumber,generationNumber,sample_id)


func_name_to_run = input_for_FUNC.func_name_to_run;
simul_para=input_for_FUNC.simul_para;
MIN_OBJ=input_for_FUNC.MIN_OBJ;
F_best_till_now=input_for_FUNC.F_best_till_now;

step_for_CUTOFF=1;

apply_simulate=input_for_FUNC.apply_simulate;
max_hist_node=input_for_FUNC.max_hist_node;

%GLOBAL_VARS=input_for_FUNC.GLOBAL_VARS;
out_needed_local=input_for_FUNC.out_needed_local;

genome_x_n_node=genome_x.n_node;% num nodes
% clear history
for i=1:genome_x_n_node  
    genome_x_list_node(i).list_node_history=zeros(1,max_hist_node);
end
genome_x_n_layer=genome_x.n_layer;%num layers
genome_x_list_layers=genome_x.list_layers;% layers
genome_x_matrix_weights=genome_x.matrix_weights; % Adjacency Matrix
genome_x_enable_weights=genome_x.enable_weights; % Enable Matrix
genome_x_list_node=genome_x.list_node; % Enable Matrix

out_needed_local.n_n_local=genome_x_n_node;% num nodes
out_needed_local.n_l_local=genome_x_n_layer;%num layers
out_needed_local.l_local=genome_x_list_layers;% layers
out_needed_local.list_node=genome_x_list_node;

if strcmp(func_name_to_run,'Simulate')
    % ADD  zero row and column
    genome_x_matrix_weights(2:size(genome_x_matrix_weights,1)+1, 2:size(genome_x_matrix_weights,2)+1) = genome_x_matrix_weights;
    genome_x_matrix_weights(1,:) = 0;
    genome_x_matrix_weights(:,1) = 0;
end
out_needed_local.w_local=genome_x_matrix_weights; % Adjacency Matrix
if strcmp(func_name_to_run,'Simulate')
    % ADD  zero row and column
    genome_x_enable_weights(2:size(genome_x_enable_weights,1)+1, 2:size(genome_x_enable_weights,2)+1) = genome_x_enable_weights;
    genome_x_enable_weights(1,:) = 0;
    genome_x_enable_weights(:,1) = 0;
end
out_needed_local.e_local=genome_x_enable_weights; % Enable Matrix

if strcmp(func_name_to_run,'Simulate')
    % ADD  zero row and column
    out_needed_local.min_inp_local = [0, out_needed_local.min_inp_local]; %0 is for indexing later
    out_needed_local.max_inp_local = [0, out_needed_local.max_inp_local]; %0 is for indexing later
    out_needed_local.min_output_local = [0, out_needed_local.min_output_local]; %0 is for indexing later
    out_needed_local.max_output_local = [0, out_needed_local.max_output_local]; %0 is for indexing later
end

out_needed_local.step_for_CUTOFF=step_for_CUTOFF;
out_needed_local.simul_para=simul_para;
out_needed_local.MIN_OBJ=MIN_OBJ;
out_needed_local.F_best_till_now=F_best_till_now;
% out_needed_local
% sdsa



if (max(genome_x.fit_fun) == MIN_OBJ) || (apply_simulate)
    [F_Total,cons_overall,additional_outputs] = feval (func_name_to_run,out_needed_local,genomeNumber,generationNumber);
else
    F_Total=genome_x.fit_fun;
    cons_overall=genome_x.constraints;
    additional_outputs.counter_Amir = 0;
    additional_outputs.totalStepCounter = 0;
end

genome_x.fit_fun=F_Total;
genome_x.constraints=cons_overall;

counter_Amir = additional_outputs.counter_Amir;
totalStepCounter = additional_outputs.totalStepCounter;
end