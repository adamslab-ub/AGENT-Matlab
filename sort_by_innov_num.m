function e_x=sort_by_innov_num(n_x,e_x)

for i=1:n_x-1   % Bubble sort
    for j=i+1:n_x
        if e_x(i).inn_number>e_x(j).inn_number
            temp=e_x(i);
            e_x(i)=e_x(j);
            e_x(j)=temp;
        end
    end
end

end

