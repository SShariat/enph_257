%Time Initialization
time = 0;
for count = 1:number_of_ticks
    data_time(count,1)=time;
    for index=1:39
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
        if index == 8
            data_6(count,1)=rod(1,index);
        elseif index == 16
            data_12(count,1)=rod(1,index);
        elseif index == 24
            data_18(count,1)=rod(1,index);
        elseif index == 32
            data_24(count,1)=rod(1,index);
        end
    end
    
    %Increment time
    time = time + d_time;
end