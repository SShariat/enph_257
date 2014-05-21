arduino = serial('COM10','BaudRate',9600);
% this refers to the port where Arduino is connected, and how fast the data
% is transferred.

fopen(arduino);
% This opens the Arduino board, as if it was a file on our computer.

% The following will plot the data received (in this case a series of
% linearly increasing integers) on a graph.

x = linspace(1, 100);

% We are scanning Arduino using the fscanf function.
for i = 1:length(x)
    y(i) = fscanf(arduino, '%d');
end

% now we close the connection to Arduino
fclose(arduino);

% next, we plot our points.
disp('creating plot...');
plot(x,y);