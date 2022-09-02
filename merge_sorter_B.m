function [s_n_x]=merge_sorter_B(u_n_x,l)

if l<=1
    s_n_x=u_n_x;
else
    l1=floor(l/2);
    l2=l-l1;
    for i=1:l1
        u1(i)=u_n_x(i);
    end
    for i=(l1+1):l
        u2(i-l1)=u_n_x(i);
    end
    s1=merge_sorter_B(u1,l1);
    s2=merge_sorter_B(u2,l2);
    s_n_x=merge_B(s1,l1,s2,l2);
end

end

