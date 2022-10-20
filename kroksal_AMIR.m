function T_m_s_T=kroksal_AMIR(V,E)% E : start, end , weight

[~,E_idx]=sort(E(:,3));
n_V=length(V);
mark=V;


flag=1;

T_m_s_T=0;
for i=1:(n_V-1)
    
    while (mark(E(E_idx(flag),1))==mark(E(E_idx(flag),2)))
        flag=flag+1;
        if flag>length(E_idx)
            break;
        end
    end
    if flag>length(E_idx)
        break;
    end
    min_mark=min(mark(E(E_idx(flag),1)),mark(E(E_idx(flag),2)));
    max_mark=max(mark(E(E_idx(flag),1)),mark(E(E_idx(flag),2)));

    for j=1:n_V
        if mark(j)==max_mark
            mark(j)=min_mark;
        end
    end

    T_m_s_T=T_m_s_T+E(E_idx(flag),3);
end

end

