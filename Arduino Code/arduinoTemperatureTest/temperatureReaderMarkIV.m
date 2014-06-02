%% Temperature Test Mark IV : Clean(er) Code

%  This iteration of our temperature test code simply cleans up a few
%  things; it is also dependant on the arduinoConnect code to initialize
%  Arduino before we can run this program.

% Commented out for posterity, it is available in arduinoConnect
% clc;
% clear all;
% delete(instrfindall);

% These define the concencated matrix, as well as the default time
newT = zeros(); 
dT = 1;
% interval between points, in seconds.

% For future reference, add a keyevent so that it will just run and stop on
% queue
second = 1;
minute = 60;
hour = minute*60;

period = 2*minute;
% Value, in seconds, we want to run the program for.

% Constants
to_voltage = (5.0 / 1023.0); % Changes analog values to their equivalent voltages.
gain = 85.0;                 % Gain of the op-amp
carley_couple = 24.7*1000.0; % Carley's Thermocouple Constant, converts temperature values.


% Again, commented out for posterity.
% a = arduino('COM10');

%T = [(a.analogRead(1)) * to_voltage; (a.analogRead(2)) * to_voltage; (a.analogRead(3)) * to_voltage;];
%T = [0;0;0];
T = zeros(6,1);
% A side effect of our concencation; we must define the initial value of T
% at t=0. For now, we are simply setting it to zero.

disp('Begun Recording');

%Added a Wait Bar to the System
h = waitbar(0, 'Recording Data...');

for i = 1:period
    % Reads in a value (between 0 and 1023, this is an analog
    % input), from the first potentiometer. (Measured in Volts)
    sensorValue = zeros(1,6);
    
    for j = 0:5
        sensorValue(j+1) = a.analogRead(j) * to_voltage;
    end
       
%     sensorValue1 = a.analogRead(0)* to_voltage;
%     sensorValue2 = a.analogRead(1)* to_voltage;
%     sensorValue3 = a.analogRead(2)* to_voltage;
%     sensorValue4 = a.analogRead(3)* to_voltage;
%     sensorValue5 = a.analogRead(4)* to_voltage;
%     sensorValue6 = a.analogRead(5)* to_voltage;
% Temporarily commented out, in case this doesn't work.
    
% The variable matrix is then updated accordingly.
    
% We measure the ambient temperature using a TMP. This will be compared
% with the other values.
temp_amb = sensorValue(1)*100.0;
    
% This plots the ambient temperature.
newT(1,1) = temp_amb;
    
% This plots the values from our sensors onto the graph.
for k = 2:5
    newT(k,1) = (sensorValue(k)/gain)*carley_couple + temp_amb;
end

% newT(2,1) = (sensorValue(2)/gain)*carley_couple + temp_amb;
% newT(3,1) = (sensorValue(3)/gain)*carley_couple + temp_amb;
% newT(4,1) = (sensorValue(4)/gain)*carley_couple + temp_amb;
% newT(5,1) = (sensorValue(5)/gain)*24.7 + temp_amb;

newT(6,1) = (sensorValue(6)*100.0);
% These are commented out for now, but I'll bring them back into the
% equation soon.
    

% Now, we concencate the values onto the matrix.
T = [T newT];
x = 0:dT:i;
%plot data
plot(x, T(1:6,:));

% As a safety measure, we save the variables to file every iteration.
save('variables.mat', 'T', 'x');
    
% The parameters of our graph
xlabel('Time (s)');
ylabel('Temperature (Celsius)');
title('Temperature of Aluminum Bar');
legend('Ambient Temp','Sensor 1', 'Sensor 2', 'Sensor 3', 'Sensor 4', 'Power R');
grid on;

% We pause for our delta-t value, and update the progress bar.
waitbar(i/period);
pause(dT);
   
end

close(h)
disp('Finished Recording');

% No more deletions for now
% a.delete();
% delete(a);
% Finally, these are kept for posterity as well.

%NOTE: If a sensor is not conncected to anything it will float and base its
%value based on the other sensor values.
