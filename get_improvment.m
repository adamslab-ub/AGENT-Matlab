function Imp=get_improvment(set_data)

global alpha_imp

N=length(set_data);
Imp=0;
for i=1:N-1
    Imp=Imp+(alpha_imp*max(set_data(N)-set_data(i),0))^(i/N);
end
Imp
end

