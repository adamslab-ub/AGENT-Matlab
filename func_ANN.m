function f=func_ANN(v,type)
%'XXXXXXXXXXX'

if type==1
    f=1/(1+exp(-4.9*v));
elseif type==2
    f=max(min(v+.5,1),0);
elseif type==3
    f=1/(1+exp(-1*v));
elseif type==4
    f=tanh(v);
elseif type==0% ONLY FOR THE LAST LAYER
    f=v;
end
%v
%f
end

