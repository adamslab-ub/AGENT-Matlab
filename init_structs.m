function init_structs

global edge_struct genome_struct niche_struct num_objectives node_struct num_input num_output max_hist_node MIN_OBJ RANK_0;


edge_struct=struct('start',0,'end',0,'weight',0,'enable',0,'inn_number',0);

node_struct=struct('list_node_ID',zeros(1,num_input+num_output),'list_node_type',0,'list_node_time',0,'list_node_history',zeros(1,max_hist_node),...
    'list_node_history_W',zeros(1,max_hist_node));
genome_struct=struct('n_node',0,'list_node',node_struct,'n_layer',0,'list_layers',0,'matrix_weights',0,'enable_weights',0,'n_edge',0,'edge_gene',edge_struct,...
    'num_genome',0,'niche_of_genome',0,'go_on',0,'fit_fun1',0,'fit_fun2',0,'fit_fun',MIN_OBJ*ones(num_objectives,1),'fit_fun4',zeros(num_objectives,1),...
    'constraints',0,'experience',0,'rank',RANK_0,'rank_global',RANK_0,'fathers',[]);
niche_struct=struct('size_niches',0,'list_num_genomes',0,'best_ff_niches',0,'stall_time',0,'number_niches',0);


end

