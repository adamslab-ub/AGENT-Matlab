function [input_for_FUNC]=find_fit_func(generationNumber,sample_id)

global  niches num_niches mean_ff num_genomes num_objectives total_eval total_counter_Amir total_totalStepCounter; 
global use_parallel_evaluations ;
global def_inp n_ts showit min_inp min_outp max_outp max_inp n_ts_long_run num_output;
global apply_simulate single_obj max_hist_node;
global rand_list Ob MIN_OBJ;
global func_name_to_run simul_para F_best_till_now;

flag=0;
ff=zeros(num_genomes,num_objectives);

list=[];
for i_n=1:num_niches
    for i_g=1:niches(i_n).size_niches
        flag=flag+1;
        list(flag,:)=[i_n,i_g];
        genome_list(flag)=niches(i_n).list_num_genomes(i_g);
    end
end
N_G=flag;

input_for_FUNC.func_name_to_run=func_name_to_run;
input_for_FUNC.def_inp=def_inp; % empty anyway
input_for_FUNC.n_ts=n_ts;
input_for_FUNC.showit=showit;
input_for_FUNC.min_inp=min_inp;
input_for_FUNC.max_inp=max_inp;
input_for_FUNC.min_outp=min_outp;
input_for_FUNC.max_outp=max_outp;
input_for_FUNC.n_ts_long_run=n_ts_long_run;
input_for_FUNC.num_output=num_output;

input_for_FUNC.apply_simulate=apply_simulate;
input_for_FUNC.single_obj=single_obj;
input_for_FUNC.max_hist_node=max_hist_node;
input_for_FUNC.MIN_OBJ=MIN_OBJ;
input_for_FUNC.F_best_till_now=F_best_till_now;

input_for_FUNC.simul_para=simul_para;

GLOBAL_VARS.rand_list=rand_list;
GLOBAL_VARS.Ob=Ob;
input_for_FUNC.GLOBAL_VARS=GLOBAL_VARS;

out_needed_local=prefAnn;
input_for_FUNC.out_needed_local=out_needed_local;

total_eval=total_eval+N_G;

genomeNumberList = 1:1:N_G;

counter_Amir = zeros(N_G,1);
totalStepCounter = zeros(N_G,1);

if use_parallel_evaluations
    parfor i=1:N_G
        [genome_list(i),counter_Amir(i),totalStepCounter(i)]=FUNC(genome_list(i),input_for_FUNC,genomeNumberList(i),generationNumber,sample_id);
    end    
else
    for i=1:N_G
        [genome_list(i),counter_Amir(i),totalStepCounter(i)]=FUNC(genome_list(i),input_for_FUNC,genomeNumberList(i),generationNumber,sample_id);        
    end
end

total_counter_Amir = total_counter_Amir + sum(counter_Amir);
total_totalStepCounter = total_totalStepCounter + sum(totalStepCounter);

for i=1:N_G
    % genome_list(i).fit_fun
    if genome_list(i).fit_fun > F_best_till_now
        F_best_till_now = genome_list(i).fit_fun;
    end
end

for i=1:N_G
     niches(list(i,1)).list_num_genomes(list(i,2))=genome_list(i);
     ff(i)=genome_list(i).fit_fun(1);
end
% ffs = sort(ff);
% ffs
% ff

% 'xxxxxxxxxx'
mean_ff=mean(ff);
% sum(ff)
% mean_ff

% F_best_till_now

end