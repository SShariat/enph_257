%Creates Multiple Plots of Various Combinations of Specific Heat Capcity
%and Conductance

%Time Constants
sec = 1.0;
minute = 60.0*sec;
hour = 60.0*minute;

% %Test Constants
% rod = zeros(1,40);
% density = 8960;
% diameterRod = (0.01);
% cross_area = pi*(diameterRod/2)^2;
% unit_length = 0.025;
% unit_mass = density*unit_length*cross_area;
% time_sec = 2*hour;
% d_time = 0.001;
% number_of_ticks=time_sec/d_time;
% Q = 100;

%Constansts for Test Rod
elements = 40;
elements_1=elements-1;


int_8 = elements*0.2;
int_16= elements*0.4;
int_24= elements*0.6;
int_32= elements*0.8;

rod = ones(1,elements)*25;
density = 2700.0;
diameterRod = (2.26/100.0);
cross_area = pi*(diameterRod/2)^2;
unit_length = (30.5/elements)/100.0;
unit_mass = density*unit_length*cross_area;
time_sec = 2*hour;
d_time = 0.01;
number_of_ticks=time_sec/d_time;
Q = 6.667;

%Initialize Data Tables
data_time = zeros(number_of_ticks,1);
data_6 = zeros(number_of_ticks,1);
data_12 = zeros(number_of_ticks,1);
data_18 = zeros(number_of_ticks,1);
data_24 = zeros(number_of_ticks,1);

%Values being Changed
kappa = 140.0;
specific_heat = 1100.0;

%Time Initialization
time = 0;
for count = 1:number_of_ticks
    data_time(count,1)=time;
    for index=1:elements_1
        %For the first rod block, the energy entering is constant
        if index == 1
            Q_in = Q*d_time;
        else
            Q_in = kappa*cross_area*(rod(1,index-1)-rod(1,index))*d_time/unit_length;
        end
        
        Q_out = kappa*cross_area*(rod(1,index)-rod(1,index+1))*d_time/unit_length;
        Q_net = Q_in - Q_out;
        rod(1,index) = Q_net/(unit_mass * specific_heat) + rod(1,index);
        
        %Record Data at 6.1,12.2,18.3,24.4 cm intervals at appropriate
        %indexes
        if index == int_8
            data_6(count,1)=rod(1,index);
        elseif index == int_16
            data_12(count,1)=rod(1,index);
        elseif index == int_24
            data_18(count,1)=rod(1,index);
        elseif index == int_32
            data_24(count,1)=rod(1,index);
        end
    end
    
    %Increment time
    time = time + d_time;
end

% Save data to new file (conductance, specfic_heat_capacity)
filename = strcat(num2str(kappa),',',num2str(specific_heat));
save(filename, 'data_time','data_6','data_12','data_18','data_24');
