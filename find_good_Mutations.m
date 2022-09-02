function find_good_Mutations(change_I,K_ICHANGE_MUTATION,min_mute,max_mute,run_step,sample_id)

global r_mute_w0 r_mute_enable0 r_mute_remove_node0 r_mute_add_edge0 r_mute_add_node0 r_mute_change_node_change_type0 r_mute_change_node_change_time0;

change_I = min(change_I, 0.1);
% change_I = max(change_I, -0.1);

r_mute_w0=r_mute_w0*(exp(change_I*K_ICHANGE_MUTATION(1)));
r_mute_add_edge0=r_mute_add_edge0*(exp(change_I*K_ICHANGE_MUTATION(2)));
r_mute_add_node0=r_mute_add_node0*(exp(change_I*K_ICHANGE_MUTATION(3)));
r_mute_change_node_change_type0=r_mute_change_node_change_type0*(exp(change_I*K_ICHANGE_MUTATION(4)));
r_mute_change_node_change_time0=r_mute_change_node_change_time0*(exp(change_I*K_ICHANGE_MUTATION(5)));

% It looks bad duplicated
% r_mute_w0=r_mute_w0*(exp(change_I*K_ICHANGE_MUTATION(1)));
% r_mute_add_edge0=r_mute_add_edge0*(exp(change_I*K_ICHANGE_MUTATION(2)));
% r_mute_add_node0=r_mute_add_node0*(exp(change_I*K_ICHANGE_MUTATION(3)));
% r_mute_change_node_change_type0=r_mute_change_node_change_type0*(exp(change_I*K_ICHANGE_MUTATION(4)));
% r_mute_change_node_change_time0=r_mute_change_node_change_time0*(exp(change_I*K_ICHANGE_MUTATION(5)));

% make it real value
r_mute_w0=real(r_mute_w0);
r_mute_add_edge0=real(r_mute_add_edge0);
r_mute_add_node0=real(r_mute_add_node0);
r_mute_change_node_change_type0=real(r_mute_change_node_change_type0);
r_mute_change_node_change_time0=real(r_mute_change_node_change_time0);

r_mute_w0=max(r_mute_w0,min_mute(1));
r_mute_add_edge0=max(r_mute_add_edge0,min_mute(2));
r_mute_add_node0=max(r_mute_add_node0,min_mute(3));
r_mute_change_node_change_type0=max(r_mute_change_node_change_type0,min_mute(4));
r_mute_change_node_change_time0=max(r_mute_change_node_change_time0,min_mute(5));
% 
r_mute_w0=min(r_mute_w0,max_mute(1));
r_mute_add_edge0=min(r_mute_add_edge0,max_mute(2));
r_mute_add_node0=min(r_mute_add_node0,max_mute(3));
r_mute_change_node_change_type0=min(r_mute_change_node_change_type0,max_mute(4));
r_mute_change_node_change_time0=min(r_mute_change_node_change_time0,max_mute(5));

r_mute_enable0=0.8*r_mute_add_edge0;
r_mute_remove_node0=0.8*r_mute_add_node0;

mute0.r_mute_w0=r_mute_w0;
mute0.r_mute_add_edge0=r_mute_add_edge0;
mute0.r_mute_add_node0=r_mute_add_node0;
mute0.r_mute_change_node_change_type0=r_mute_change_node_change_type0;
mute0.r_mute_change_node_change_time0=r_mute_change_node_change_time0;
mute0.r_mute_enable0=r_mute_enable0;
mute0.r_mute_remove_node0=r_mute_remove_node0;
mute0
save(['Mute_0 of ' num2str(sample_id) ' on generataion '  num2str(run_step) '.mat'],'mute0');
end

