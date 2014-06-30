function [M]=big_epsilon_variables(c,k,f)
        %Big Epsilon
        ec_big = 50;
        ek_big = 50;
        ef_big = 0.1;
        M = [[(c+ec_big) k f];[(c-ec_big) k f];[c (k+ek_big) f];[c (k-ek_big) f];[c k (f+ef_big)];[c k (f-ef_big)]]';
        M = num2cell(M);
        
    end