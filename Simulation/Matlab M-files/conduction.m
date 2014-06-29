%Creates the Simulation Matrix
function [sim_data]=conduction(specific_heat,kappa,factor)

%Constansts for Test Rod
elements = 30;
elements_1=elements-1;
t_amb = 23;
rod = ones(1,elements)*t_amb;
density = 2700.0;
diameter_rod = (2.26/100.0);
cross_area = pi*(diameter_rod/2)^2;
unit_length = (30.5/elements)/100.0;
unit_mass = density*unit_length*cross_area;
surface_a_element = pi*diameter_rod*unit_length;
d_time = 0.5;
number_of_ticks=10800*2;
P_in = 6.667;

%Initialization of the Data-Recording Vectors
int_8 = elements*0.2;
int_16= elements*0.4;
int_24= elements*0.6;
int_32= elements*0.8;

%Initialize Data Tables
data_time = zeros(number_of_ticks,1);
data_6 = zeros(number_of_ticks,1);
data_12 = zeros(number_of_ticks,1);
data_18 = zeros(number_of_ticks,1);
data_24 = zeros(number_of_ticks,1);

%Values being Changed
h_c = 0;
stephen = 0;
emiss = 0;

%Time Initialization
time = 0;

%Real Power into Initial Element
Q = P_in*factor;
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
        Q_convection = h_c *surface_a_element*(rod(1,index)-t_amb);
        Q_radiation = emiss*stephen*(rod(1,index)^4)*surface_a_element;
        
        Q_net = Q_in - Q_out - Q_convection - Q_radiation;
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
    end;
   
    %Increment time
    time = time + d_time;
end;
    M = [data_6,data_12,data_18,data_24]';
    sim_data = zeros(4,(number_of_ticks/2));
    for j=1:(number_of_ticks/2)
        sim_data(:,j) = M(:,j*2-1);
    end
end 

