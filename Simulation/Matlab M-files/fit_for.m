function [c0,k0,f0]=fit_for(c_in,k_in,f_in,y)
c0 = c_in;
k0 = k_in;
f0 = f_in;

%Extracts real data-matrix
real_data = extract_data(y);

current_chi = calculate_chi(conduction(c0,k0,f0),real_data);
while(true)
    %For loop tests 6 points around point
    for variable = big_epsilon_variables(c0,k0,f0);
        new_chi = calculate_chi(conduction(c,k,f),real_data);
        if new_chi < current_chi
            c0 = c;
            k0 = k;
            f0 = f;
            current_chi = new_chi;
        end
    end
end

    function [M]=big_epsilon_variables(c,k,f)
        %Big Epsilon
        ec_big = 50;
        ek_big = 50;
        ef_big = 0.1;
        M = [[(c+ec_big) k f];[(c-ec_big) k f];[c (k+ek_big) f];[c (k-ek_big) f];[c k (f+ef_big)];[c k (f-ef_big)]]';
        M = num2cell(M);
        
    end
    function [M]=small_epsilon_variables(c,k,f)
        %Small Epsilon
        ec_small = 10;
        ek_small = 10;
        ef_small = 0.02;
        M = [[(c+ec_small) k f];[(c-ec_small) k f];[c (k+ek_small) f];[c (k-ek_small) f];[c k (f+ef_small)];[c k (f-ef_small)]]';
        M = num2cell(M);
    end
end