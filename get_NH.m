function NH_good=get_NH(num_input,num_output)

NH_good=sqrt(num_input*num_output);
NH_good=round(NH_good);
NH_good=max(NH_good,0);

end