function merged=merge_B(u_n_x1,l1,u_n_x2,l2)

flag1=1;
flag2=1;

for i=1:l1
    u_1(i)=u_n_x1(i).fit_fun(1);
end
for i=1:l2
    u_2(i)=u_n_x2(i).fit_fun(1);
end

flag_merged=1;
while(flag1<=l1)&&(flag2<=l2)
    
    if (u_1(flag1)>=u_2(flag2))
        merged(flag_merged)=u_n_x1(flag1);
        flag1=flag1+1;
    else
        merged(flag_merged)=u_n_x2(flag2);
        flag2=flag2+1;
    end
    flag_merged=flag_merged+1;
end
if (flag1<=l1)
    for i=flag1:l1
        merged(flag_merged)=u_n_x1(i);
        flag_merged=flag_merged+1;
    end
else
    for i=flag2:l2
        merged(flag_merged)=u_n_x2(i);
        flag_merged=flag_merged+1;
    end
end

end

