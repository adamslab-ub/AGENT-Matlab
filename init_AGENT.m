function init_AGENT(sample_id)

% Initalize coefficents
% rand
init_user_specified_variables(sample_id);
% rand
init_hyperparameters_variables(sample_id);
% rand
init_constant_variables(sample_id);
% rand
% initalize structures used
init_structs;
% rand

% Initalize the population
init_genomes(sample_id);
% rand
% Initalize the niches
init_niches(1);
% rand

end

