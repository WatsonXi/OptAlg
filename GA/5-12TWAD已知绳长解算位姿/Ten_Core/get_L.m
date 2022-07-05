%% get_L.m
function L = get_L(A,Cs)
    A1 = A(:,1:5);
    A2 = A(:,6:9);
    L = Cs * [A1 , A2]';
end