function init_AGENT(sample_id)

% Initalize coefficents
init_user_specified_variables(sample_id);
init_hyperparameters_variables(sample_id);
init_constant_variables(sample_id);
% initalize structures used
init_structs;
% Initalize the population
init_genomes(sample_id);
% Initalize the niches
init_niches(1);

end

