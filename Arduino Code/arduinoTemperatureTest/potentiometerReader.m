arduino = serial('COM10','BaudRate',9600);
% this refers to the port where Arduino is connected, and how fast the data
% is transferred.

fopen(arduino);
% This opens the Arduino board, as if it was a file on our computer.

x = linspace(0,1,226);
y = zeros(226,1);

for i = 1:length(x);
    y(i) = fscanf(arduino, '%d');
end

% now we close the connection to Arduino
fclose(newobjs);

% next, we plot our points.
disp('creating plot...');
plot(x,y);