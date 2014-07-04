%Creates the Simulation Matrix
function [sim_data]=conduction(specific_heat,kappa,factor,rd_t4)

%Constansts for Test Rod
elements = 40;
elements_1=elements-1;
t_amb = 25;
rod = ones(1,elements)*t_amb;
diameter_rod = (2.26/100.0);
cross_area = pi*(diameter_rod/2)^2;
unit_length = ((30.5-6.1)/elements)/100.0;
unit_mass = 0.3265;
surface_a_element = pi*diameter_rod*unit_length;
d_time = 0.5;
number_of_ticks=10800*2;
P_in = 6.667;

%Initialization of the Data-Recording Vectors
tc_1_index = 10;
tc_2_index = 20;
tc_3_index = 30;
tc_4_index = 40;

%Initialize Data Tables
data_time = zeros(number_of_ticks,1);
data_tc_1  = zeros(number_of_ticks,1);
data_tc_2 = zeros(number_of_ticks,1);
data_tc_3 = zeros(number_of_ticks,1);

%Time Initialization
time = 0;

%Real Power into Initial Element
Q = P_in*factor;
for count = 1:number_of_ticks
    rod(1,elements) = rd_t4(1,count);
    data_time(count,1)=time;
    for index=1:elements_1
        %For the first rod block, the energy entering is constant
        if index == 1
            Q_in = Q*d_time;
        else
            Q_in = kappa*cross_area*(rod(1,index-1)-rod(1,index))*d_time/unit_length;
        end
        
        Q_out = kappa*cross_area*(rod(1,index)-rod(1,index+1))*d_time/unit_length;
        %         Q_convection = h_c *surface_a_element*(rod(1,index)-t_amb);
        %         Q_radiation = emiss*stephen*(rod(1,index)^4)*surface_a_element;
        
        Q_net = Q_in - Q_out;
        rod(1,index) = Q_net/(unit_mass * specific_heat) + rod(1,index);
        
        %Record Data at 6.1,12.2,18.3,24.4 cm intervals at appropriate
        %indexes
        if index == tc_1_index
            data_tc_1(count,1)=rod(1,index);
        elseif index == tc_2_index
            data_tc_2(count,1)=rod(1,index);
        elseif index == tc_3_index
            data_tc_3(count,1)=rod(1,index);
        end
    end
    
    %Increment time
    time = time + d_time;
end
sim_data = [data_tc_1,data_tc_2,data_tc_3]';
end

