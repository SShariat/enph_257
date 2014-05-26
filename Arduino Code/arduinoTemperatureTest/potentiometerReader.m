delete(instrfindall);
clear all;
n=0;
i=1;
cycles = 30;
t = zeros(1,cycles);
arduino = serial('COM10','BaudRate', 9600);

% this refers to the port where Arduino is connected, and how fast the data
% is transferred.

fopen(arduino);
% This opens the Arduino board, as if it was a file on our computer.
while (n <cycles)
    t(1,i) = fscanf(arduino, '%f');
    i = i + 1;
    set(gcf, 'color', 'white');
    drawnow;
    plot(t,'-.dk','linewidth',1.8), axis([1 cycles 0 5]);
    grid on
    title('Graph');
    xlabel('Trials');
    ylabel('Temperature(Celsius)');
    n= n+1;
    pause(0.5);
end

% now we close the connection to Arduino
fclose(arduino);
