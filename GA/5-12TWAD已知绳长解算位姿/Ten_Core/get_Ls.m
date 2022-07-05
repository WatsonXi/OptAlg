function L_s = get_Ls(A1,Cs)
    LL = get_L(A1,Cs);
    L_s = nan * ones(size(LL,1),1);
    for i = 1 : size(LL,1)
        L_s(i) = norm(LL(i,:));
    end
end