function init_genomes(sample_id)

global num_genomes_start num_genomes num_input num_output min_w max_w;
global edge_struct genome_struct def_edge_struct def_genome_struct;
global N_nodetypes max_hist_node;
global genome;
global dt_dynamic_simulate list_to_FUNC;
global global_node_num; 
global r_mute_w r_mute_enable r_mute_remove_node r_mute_add_edge r_mute_add_node r_mute_change_node_change_type r_mute_change_node_change_time;

if isempty(global_node_num) 
    global_node_num =num_input + num_output;
end

r_mute_w_BU=r_mute_w;
r_mute_enable_BU=r_mute_enable;
r_mute_remove_node_BU=r_mute_remove_node;
r_mute_add_edge_BU=r_mute_add_edge;
r_mute_add_node_BU=r_mute_add_node;
r_mute_change_node_change_type_BU=r_mute_change_node_change_type;
r_mute_change_node_change_time_BU=r_mute_change_node_change_time;

% to avoid any other mutations
r_mute_w=0;
r_mute_enable=0;
r_mute_remove_node=0;
r_mute_add_edge=0;
r_mute_change_node_change_type=0;
r_mute_change_node_change_time=0;


for i=1:num_input
    def_list_input(i)=i;
end

for i=1:num_output
    def_list_output(i)=num_input+i;
end

def_edge_struct=edge_struct;

def_genome_struct=genome_struct;
genome=[def_genome_struct];
def_genome_struct.n_node=num_input+num_output;


def_genome_struct.n_node=num_input+num_output;
def_genome_struct.n_layer=2;
def_genome_struct.list_layers={def_list_input def_list_output};
def_genome_struct.n_edge=num_input*num_output;
def_genome_struct.edge_gene=def_edge_struct;

all_W=[];
all_N=[];

for i_genomes=1:num_genomes_start
    for i_node=1:num_input+num_output
        def_genome_struct.list_node(i_node).list_node_type=randi(N_nodetypes);
        r=rand;
        if r<0.5
            def_genome_struct.list_node(i_node).list_node_time=randi(max_hist_node+1)-1;
        else
            def_genome_struct.list_node(i_node).list_node_time=0;
        end
        
        if def_genome_struct.list_node(i_node).list_node_time==0
            def_genome_struct.list_node(i_node).list_node_history_W=[1,0,0];
        elseif def_genome_struct.list_node(i_node).list_node_time==1
            def_genome_struct.list_node(i_node).list_node_history_W=[1,-1,0]/dt_dynamic_simulate;
        elseif def_genome_struct.list_node(i_node).list_node_time==2
            def_genome_struct.list_node(i_node).list_node_history_W=[1,-2,1]/(dt_dynamic_simulate^2);
        end
        
        for i_h=1:max_hist_node
            def_genome_struct.list_node(i_node).list_node_history(i_h)=0;
        end
        def_genome_struct.list_node(i_node).list_node_ID=i_node;
    end
     def_genome_struct.list_node;

    NH_good=get_NH(num_input,num_output);
    
    all_N=[all_N;def_genome_struct.list_node.list_node_ID,888,def_genome_struct.list_node.list_node_type,777,...
        def_genome_struct.list_node.list_node_time,666,def_genome_struct.list_node.list_node_history,666,def_genome_struct.list_node.list_node_history_W];
    def_genome_struct.n_layer=2;
    
    for i_l_n=1:length(def_list_input)
        def_genome_struct.list_layers{1}(i_l_n)=def_genome_struct.list_node(def_list_input(i_l_n)).list_node_ID;
    end
    
    for i_l_n=1:length(def_list_output)
        def_genome_struct.list_layers{2}(i_l_n)=def_genome_struct.list_node(def_list_output(i_l_n)).list_node_ID;
    end
    
    genome(i_genomes)=def_genome_struct;
    
    genome(i_genomes).matrix_weights=zeros(def_genome_struct.n_node,def_genome_struct.n_node);
    genome(i_genomes).enable_weights=zeros(def_genome_struct.n_node,def_genome_struct.n_node);
    for i=1:num_input
        for j=1:num_output
            genome(i_genomes).matrix_weights(i,num_input+j)=min_w+rand*(max_w-min_w);
            genome(i_genomes).enable_weights(i,num_input+j)=1;
            genome(i_genomes).edge_gene((i-1)*(num_output)+j).start=i;
            genome(i_genomes).edge_gene((i-1)*(num_output)+j).end=num_input+j;
            genome(i_genomes).edge_gene((i-1)*(num_output)+j).weight=genome(i_genomes).matrix_weights(i,num_input+j);
            genome(i_genomes).edge_gene((i-1)*(num_output)+j).enable=genome(i_genomes).enable_weights(i,num_input+j);
            genome(i_genomes).edge_gene((i-1)*(num_output)+j).inn_number=(i-1)*(num_output)+j;
        end
    end
    
    genome(i_genomes).num_genome=i_genomes;
    
    all_W=[all_W;genome(i_genomes).matrix_weights];
    genome(i_genomes).fathers=[i_genomes,1];
    
    NH_good=get_NH(num_input,num_output);

    r_mute_add_node=min(1,NH_good/def_genome_struct.n_edge);

    for i=1:ceil(NH_good/def_genome_struct.n_edge)
        genome(i_genomes)=mutate_it(genome(i_genomes));
        NH_good=NH_good-def_genome_struct.n_edge;
        r_mute_add_node=min(1,NH_good/def_genome_struct.n_edge);
    end
    
    genome_to_save(i_genomes)=genome(i_genomes);
end
list_to_FUNC=[];

r_mute_w=r_mute_w_BU;
r_mute_enable=r_mute_enable_BU;
r_mute_remove_node=r_mute_remove_node_BU;
r_mute_add_edge=r_mute_add_edge_BU;
r_mute_add_node=r_mute_add_node_BU;
r_mute_change_node_change_type=r_mute_change_node_change_type_BU;
r_mute_change_node_change_time=r_mute_change_node_change_time_BU;

filename=['genome_inits' num2str(sample_id) '.mat'];
save(filename,'genome_to_save');

num_genomes_start=length(genome);
num_genomes=num_genomes_start;

end




