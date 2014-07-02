function [M]=small_epsilon_variables(c,k,f)
%Small Epsilon
ec_small = 10;
ek_small = 10;
ef_small = 0.02;
M = [[(c+ec_small) k f];[(c-ec_small) k f];[c (k+ek_small) f];[c (k-ek_small) f];[c k (f+ef_small)];[c k (f-ef_small)]]';
M = num2cell(M);
end