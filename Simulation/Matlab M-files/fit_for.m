function [c_f,k_f,f_f]=fit_for(c_in,k_in,f_in,y)

%Extracts real data-matrix
real_data = y;

%You are at your first point.
current_chi = calculate_chi(conduction(c_in,k_in,f_in),real_data);
smallest_chi = current_chi;

c = c_in;
k = k_in;
f = f_in;

%Calculates the value of the new c,k,f for big epsilon
count = 0;
%Loop for Big values of Epsilon
ec = 100;
ek = 1;
ef = 0.001;
while true
    %For loop tests 6 points around point
        next_c=c;
        next_k=k;
        next_f=f;
    for variable = epsilon_variables(c,k,f,ec,ek,ef)
        %Initializes 3 Variables
        c1 = variable(1,1);
        k1 = variable(2,1);
        f1 = variable(3,1);
        
        new_chi = calculate_chi(conduction(c1,k1,f1),real_data);
        if new_chi < smallest_chi
            next_c = c1;
            next_k = k1;
            next_f = f1;
            smallest_chi = new_chi;
        end
    end
        c = next_c;
        k = next_k;
        f = next_f;
    if current_chi > smallest_chi
        current_chi = smallest_chi;
    else
        display(count);
        break
    end
    count = count + 1;
end

current_chi = calculate_chi(conduction(c,k,f),real_data);
smallest_chi = current_chi;
%Loop for Small values of Epsilon
ec = 50;
ek = 1;
ef = 0.001;
while true
    %For loop tests 6 points around point
        next_c=c;
        next_k=k;
        next_f=f;
    for variable = epsilon_variables(c,k,f,ec,ek,ef)
        %Initializes 3 Variables
        c1 = variable(1,1);
        k1 = variable(2,1);
        f1 = variable(3,1);
        
        new_chi = calculate_chi(conduction(c1,k1,f1),real_data);
        if new_chi < smallest_chi
            next_c = c1;
            next_k = k1;
            next_f = f1;
            smallest_chi = new_chi;
        end
    end
        c = next_c;
        k = next_k;
        f = next_f;
    if current_chi > smallest_chi
        current_chi = smallest_chi;
    else
        display(count);
        break
    end
    count = count + 1;
end

c_f = c;
k_f = k;
f_f = f;

end