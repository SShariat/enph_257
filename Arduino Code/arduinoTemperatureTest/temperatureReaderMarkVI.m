%% Temperature Test Mark IV : Clean(er) Code

%  This iteration of our temperature test code is an improvement over Mark
%  III; it cleans up the code, and even manages to optimize speed! (Gasp)

clc;

% This measures the time interval between points, in seconds. 
dT = 1;

% These are just constants which define the length of time our program will
% run for, which itself is defined in the next block.
second = 1;
minute = 60;
hour = minute*60;

% Value, in seconds, we want to run the program for. Thanks to the above
% constants, we can simply enter in the time period in the time units we
% prefer.
period = 3*hour;

% Our lovely constants
to_voltage = (5.0 / 1023.0); % Changes analog values to their equivalent voltages.
gain = 805.0;                % Gain of the op-amp. This has been changed from previous versions of the circuit.
carley_couple = 24.7*1000.0; % Carley's Thermocouple Constant, converts temperature values.
offset = 0.972;              % The voltage offset we introduced in the circuit.

% This initializes our T matrix, based on the period.
T = zeros(6,(dT*period));

disp('Begun Recording');

% Added a Wait Bar to the System
% I took the Wait Bar out, it was annoying during tests. It can be returned
% at a later date.
% h = waitbar(0, 'Recording Data...');
global KEY_IS_PRESSED
KEY_IS_PRESSED = 0;
gcf
set(gcf, 'KeyPressFcn', @myKeyPressFcn)
while ~KEY_IS_PRESSED
    tic;
    % First, we initialize our sensorValue vector. This will store all our
    % data for this time step.
    sensorValue = zeros(1,6);
    
    % This is our first TMP, the ambient air temperature. We multiply it by
    % 100 to set this to be true.
    sensorValue(1) = a.analogRead(0) * to_voltage * 100.0;
    
    % Now, we can for loop it up for the offset.
    for j = 1:4
        sensorValue(j+1) = (a.analogRead(j) * to_voltage) - offset;
    end
    % This is the final TMP, it measures the power resistor.
    sensorValue(6) = a.analogRead(5) * to_voltage;
        
    % We place the ambient temperature into the T matrix in the first row.
    T(1,i) = sensorValue(1);
    
    % We then continue filling up the matrix with the thermocouple values
    for k = 2:5
        T(k,i) = (sensorValue(k)/gain)*carley_couple + sensorValue(1);
    end
    % Finally, we introduce the last TMP, the one measuring the power
    % resistor's temperature.
    T(6,i) = (sensorValue(6)*100.0);
    
    % Thermocouple 3 is really odd, it consistently plots data at 5 degrees
    % below what it actually reads. Hence, we're correcting it here.
    T(2,i) = T(2,i) - 1.5; % Thermocouple 1
    T(4,i) = T(4,i) - 2.0; % Thermocouple 3
    T(5,i) = T(5,i) + 1.5; % Thermocouple 4

    % This sets up our x-axis, and plots the data.
    x = 1:dT:i;
    plot(x, T(1:6,1:i));

    % As a safety measure, we save the variables to file every iteration.
    save('variables_test.mat', 'T', 'x');
    
    % The parameters of our graph
    xlabel('Time (s)');
    ylabel('Temperature (Celsius)');
    title('Temperature of Aluminum Bar');
    legend('Ambient Temperature','Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Heater');
    grid on;

          
    % We pause for our delta-t value, and update the progress bar.
    
    % waitbar(i/period);
    % No progress bar! It is annoying!
    
    % We then pause for our delta-t value, ready to implement this again on
    % the next step!
    timeElapsed = toc;
        
    pause(dT - timeElapsed);
end

% The final bit of the progress bar, we don't need its kind in here!
% close(h)
disp('Finished Recording');