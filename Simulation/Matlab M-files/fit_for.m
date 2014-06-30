function [c_f,k_f,f_f]=fit_for(c_in,k_in,f_in,y)

%Extracts real data-matrix
real_data = extract_data(y);

%You are at your first point.
current_chi = calculate_chi(conduction(c0,k0,f0),real_data);
smallest_chi = current_chi;

c = c_in;
k = k_in;
f = f_in;


while true
    %For loop tests 6 points around point
    for variable = big_epsilon_variables(c,k,f);
        %Initializes 3 Variables
        c1 = variable(1,1);
        k1 = variable(2,1);
        f1 = variable(3,1);
        
        new_chi = calculate_chi(conduction(c1,k1,f1),real_data);
        if new_chi < smallest_chi
            next_c = c;
            next_k = k;
            next_f = f;
            smallest_chi = new_chi;
        end
    end
    
    if smallest_chi == current_chi
        break
    else
        c = next_c;
        k = next_k;
        f = next_f;
    end
end

c_f = f;
k_f = k;
f_f = f;

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