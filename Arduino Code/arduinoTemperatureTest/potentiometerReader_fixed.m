a = serial('COM10');
% this refers to the port where Arduino is connected, and how fast the data
% is transferred.

fopen(a);
% This opens the Arduino board, as if it was a file on our computer.

x = linspace(0,1,226);
y = zeros(1, length(x));

for i = 1:length(x);
    y(i) = fscanf(a, '%d');
end

% now we close the connection to Arduino
fclose(a);

% next, we plot our points.
disp('creating plot...');
plot(x,y);