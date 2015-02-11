if (all(data(:,1) == t))
    y_comb_top = {y_comb_top{:} data(:,2)};
    y_comb_mid = {y_comb_mid{:} data(:,4)};
    y_comb_bot = {y_comb_bot{:} data(:,6)};
    u_comb = {u_comb{:} data(:,8)};
else
    printf('time wrong\n')
end