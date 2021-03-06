delete(instrfindall);
clear all;
a = serial('COM10', 'BaudRate',9600);
% this refers to the port where Arduino is connected, and how fast the data
% is transferred.

fopen(a);
% This opens the Arduino board, as if it was a file on our computer.

%x = linspace(0,1,226);
%y = zeros(1, length(x));

interv =1000;
time_delta = 200;
time = 0;

while(1)
    y = fscanf(a,'%f');
    scatter(time, y);
    time = time + time_delta;
    drawnow;
end

% now we close the connection to Arduino
fclose(a);

% next, we plot our points.
%disp('creating plot...');
%plot(x,y);