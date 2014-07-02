function [M]=epsilon_variables(c,k,f,ec,ek,ef)
M = [[(c+ec) k f];[(c-ec) k f];[c (k+ek) f];[c (k-ek) f];[c k (f+ef)];[c k (f-ef)]]';
% M = num2cell(M);

end