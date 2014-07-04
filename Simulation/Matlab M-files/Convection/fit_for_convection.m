function [ h_c_f, emiss_f, stephen_f ] = fit_for_convection(h_c_in,emiss_in,stephen_in,real_data)

%You are at your first point.
current_chi = calculate_chi(convection(h_c_in,emiss_in,stephen_in),real_data);
smallest_chi = current_chi;

h_c     = h_c_in;
emiss   = emiss_in;
stephen = stephen_in;

%Calculates the value of the new c,k,f for big epsilon
count = 0;
%Loop for Big values of Epsilon
ehc = 0.1;
ee = 0.1;
es = 1*10^-8;
while true
    %For loop tests 6 points around point
        next_h_c     = h_c;
        next_emiss   = emiss;
        next_stephen = stephen;
    for variable = epsilon_variables(h_c,emiss,stephen,ehc,ee,es)
        %Initializes 3 Variables
        h_c1 = variable(1,1);
        emiss1 = variable(2,1);
        stephen1 = variable(3,1);
        
        new_chi = calculate_chi(convection(h_c1,emiss1,stephen1),real_data);
        if new_chi < smallest_chi
            next_h_c     = h_c1;
            next_emiss   = emiss1;
            next_stephen = stephen1;
            smallest_chi = new_chi;
        end
    end
        h_c     = next_h_c;
        emiss   = next_emiss;
        stephen = next_stephen;
    if current_chi > smallest_chi
        current_chi = smallest_chi;
    else
        display(count);
        display(smallest_chi);
        break
    end
    count = count + 1;
end
display(h_c);
display(emiss);
display(stephen);

current_chi = calculate_chi(convection(h_c,emiss,stephen),real_data);
smallest_chi = current_chi;

count = 0;
%Loop for Small values of Epsilon
ehc = 0.001;
ee = 0.01;
es = 0.1*10^-8;
while true
    %For loop tests 6 points around point
        next_h_c     = h_c;
        next_emiss   = emiss;
        next_stephen = stephen;
    for variable = epsilon_variables(h_c,emiss,stephen,ehc,ee,es)
        %Initializes 3 Variables
        h_c1 = variable(1,1);
        emiss1 = variable(2,1);
        stephen1 = variable(3,1);
        
        new_chi = calculate_chi(convection(h_c1,emiss1,stephen1),real_data);
        if new_chi < smallest_chi
            next_h_c     = h_c1;
            next_emiss   = emiss1;
            next_stephen = stephen1;
            smallest_chi = new_chi;
        end
    end
        h_c     = next_h_c;
        emiss   = next_emiss;
        stephen = next_stephen;
    if current_chi > smallest_chi
        current_chi = smallest_chi;
    else
        display(count);
        display(smallest_chi);
        break
    end
    count = count + 1;
end

h_c_f = h_c;
emiss_f = emiss;
stephen_f = stephen;

end