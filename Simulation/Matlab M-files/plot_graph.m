%Plots Test Data to a Figure

hold on
    plot(data_time,data_6,'r');
    plot(data_time,data_12,'g');
    plot(data_time,data_18,'b');
    plot(data_time,data_24,'y');
    xlabel('Time(seconds)');
    ylabel('Temperature(Celsius)');
    title('Temperature as a Function of Time');
hold off