
%Constansts
rod = zeros(1,40);
rod(1,40) = 25;
density = 8960;
diameterRod = 0.01;
cross_area = pi*(diameterRod/2)^2;
unit_length = 0.025;
unit_mass = density*unit_length*cross_area;
specific_heat = 386;
d_time = 0.5;
kappa = 401;
number_of_ticks=50000;

%Initialize Data Tables
data_time = zeros(number_of_ticks,1);
data_20 = zeros(number_of_ticks,1);
data_40 = zeros(number_of_ticks,1);
data_60 = zeros(number_of_ticks,1);
data_80 = zeros(number_of_ticks,1);

%Time Initialization
time = 0;
for count = 1:number_of_ticks,
    data_time(count,1)=time;
    for index=1:39,
        %For the first rod block, the energy entering is constant
        if index == 1
            Q_in = 100*d_time;
        else
            Q_in = kappa*cross_area*(rod(1,index-1)-rod(1,index))*d_time/unit_length;
        end
        
        Q_out = kappa*cross_area*(rod(1,index)-rod(1,index+1))*d_time/unit_length;
        Q_net = Q_in - Q_out;
        rod(1,index) = Q_net/(unit_mass * specific_heat) + rod(1,index);
        
        %Record Data at 10,50, and 90cm times
        if index == 8
            data_20(count,1)=rod(1,index);
        elseif index == 16
            data_40(count,1)=rod(1,index);
        elseif index == 24
            data_60(count,1)=rod(1,index);
        elseif index == 32
            data_80(count,1)=rod(1,index);
        end
    end
    
    %Increment time
    time = time + d_time;
end

%Plot the graphs
hold on
    plot(data_time,data_20,'r');
    plot(data_time,data_40,'g');
    plot(data_time,data_60,'b');
    plot(data_time,data_80,'y');
    xlabel('Time(seconds)');
    ylabel('Temperature(Celsius)');
    title('Temperature as a Function of Time');
hold off

