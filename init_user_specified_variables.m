function init_user_specified_variables(sample_id)
% This is the function user shoulfd modify.

global min_run_step max_run_step stalled_iteration tolerance_f Total_AGENT_CPU_time;
global num_genomes num_input num_output;
global func_name_to_run;
global min_inp max_inp min_output max_output;
global use_parallel_evaluations;
global simul_para;

% These parameters must be chosen by user , You should not add any more
% parameter, just change the values
%% AGENT parameters
% if you use func_test you need to provife simulation parameters otherwise
% you can define a function like func_test yourself

% use this one
func_name_to_run = 'Simulate'; % PYTHON TEST
% or this one
% func_name_to_run = 'func_test'; % MATLAB TEST FILE
if strcmp(func_name_to_run,'Simulate')
    if sample_id<=20
        openAI_run= 'trialMountain'; 
    elseif sample_id<=40
        openAI_run= 'trialAcrobot'; 
    elseif sample_id<=60
        openAI_run= 'trialLunar';
    elseif sample_id<=80
        openAI_run= 'trialBipedal';
    end
	
else
    openAI_run= 'NO OPEN AI';
end

% Stopping Criteria
max_run_step = 100;% 500 FOR HIGH % 50 NOW
min_run_step = 100;% AGENT will not stop in 10 iterations unless CPU time  % 200 FOR HIGH % 300 FOR NOW

min_run_step = min(min_run_step,max_run_step);
stalled_iteration = 10;
stalled_iteration = min(stalled_iteration , min_run_step-1);
tolerance_f = 0.000001; % Relative 
Total_AGENT_CPU_time = 10*3600; % Seconds, can be Inf

switch openAI_run
    
    case 'trialMountain'
        min_inp=[-1.2, -0.07]; % input states range
        max_inp=[ 0.6, 0.07]; % input states range
        min_output= [-1]; % output actions range
        max_output= [+1]; % output actions range
        num_genomes = 50;
        
    case 'trialAcrobot'
        min_inp=[-1*ones(1,4),-4*pi,-9*pi];
        max_inp=[ones(1,4),4*pi,9*pi];
        min_output= [-1];
        max_output= [+1];
        num_genomes = 10;
        
    case 'trialLunar'
        min_inp=[-1,0        ,-1,-1,-pi,-pi,0,0];
        max_inp=[ 1,1+(20/30), 1, 1, pi, pi,1,1];
        min_output= [0];
        max_output= [1];
        num_genomes = 10;
        
    case 'trialCartpole'
        min_inp=[-4.8, -10, -24*pi/180, -240*pi/180];
        max_inp=[+4.8, +10, +24*pi/180, +240*pi/180];
        min_output= [0];
        max_output= [1];
        
    case 'trialBipedal'
        min_inp=[0       ,-100*pi,-1,-1,-pi*ones(1,4),0,-100*pi*ones(1,4),0,   zeros(1,10)];
        max_inp=[2*pi/180,+100*pi,+1,+1,+pi*ones(1,4),1,+100*pi*ones(1,4),1,250*ones(1,10)];
        
        min_output= [-1*ones(1,4)]; % output actions range % originaly it was one output but it must be wrong
        max_output= [+1*ones(1,4)]; % output actions range % originaly it was one output but it must be wrong
    case 'NO OPEN AI'
        min_inp=[-1.2, -0.07]; % input states range
        max_inp=[ 0.6, 0.07]; % input states range
        
        min_output= [-1]; % output actions range
        max_output= [+1]; % output actions range
end

min_inp=[min_inp,1]; % input states bias 
max_inp=[max_inp,1]; % input states bias	
num_input = length(min_inp);

num_output = length(max_output);

use_parallel_evaluations = 1;

% num_genomes = max(50,(num_input+num_output)*10);
% num_genomes = min(500,num_genomes);

user_para.func_name_to_run = func_name_to_run;
user_para.max_run_step = max_run_step;
user_para.num_genomes = num_genomes;
user_para.min_inp = min_inp;
user_para.max_inp = max_inp;
user_para.min_output = min_output;
user_para.max_output = max_output;
user_para.use_parallel_evaluations =use_parallel_evaluations;

save(['user_para' num2str(sample_id) '.mat'],'user_para');

%% Simulation parameters
% These parameters should be defined by user, Uou can add more parametrs
% but don't remove any parameter

N_inp = length(min_inp);

simul_para.initial_choice = 'Random_fixed';
if strcmp(simul_para.initial_choice,'Random_fixed')
    simul_para.initial_state = rand(1,N_inp).*(max_inp-min_inp) + min_inp;
    simul_para.initial_state(end) = []; % Remove bias
elseif strcmp(simul_para.initial_choice,'Mean')
    simul_para.initial_state = (max_inp-min_inp)/2;
    simul_para.initial_state(end) = []; % Remove bias
elseif strcmp(simul_para.initial_choice,'Specific')
    simul_para.initial_state = [-0.6,0];    % user should specify it 
end
if strcmp(simul_para.initial_choice,'Random')
    % simul_para.initial_state Will be specified later 
end

%%% These are some examples for termination, You can use them or any other
% parametr you prefer
simul_para.max_CPU_time = Inf;% seconds (tic-toc)
simul_para.max_simulation_time = 1000;% seconds (virtual time)
simul_para.max_iteration = 1000;% Number of evaluations
simul_para.dynamic_func = 'MC_Dynamic'; % Dynamic_func; It must be defined by user. , it is not optional
simul_para.intermediate_rewared_func = 'MC_rew_int';% Intermediate_rewared_func , it is not optional but it can be zero
simul_para.final_state_rewared_func = 'MC_rew_end';% final_state_rewared_func , it is not optional but it can be zero
simul_para.openAI_run = openAI_run;

%%% These are optional parameters, problem Dependent
simul_para.stopping_func = 'MC_stopping'; % Additional stopping criteria function , it is optional 

save(['simul_para' num2str(sample_id) '.mat'],'simul_para');

end

