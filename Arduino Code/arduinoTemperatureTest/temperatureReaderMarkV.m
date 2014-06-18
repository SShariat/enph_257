%% Temperature Test Mark V : Computer-Controlled Circuit
% (heh, alliteration)

% This code controls a MOSFET hooked up to our temperature circuit,
% turning on and off the power resistor. This lets us control the circuit 
% remotely. I also fixed the bug where dT could only be 1.

% Clears all prior data clogging up our screen.
clc;

% Measures the time interval between points, in seconds.
dT = 1;
n = 1; % The number of times the code has run for.
m = 0; % A simple variable, if negative 1 then we exit our loop.

% I'm reverting to the old version where we concencate the values. This
% means we won't have wasted space.

% Constants related to measuring temperature.
to_voltage = (5.0 / 1023.0); % Changes analog values to their equivalent voltages.
gain = 247.0;                % Gain of the op-amp.
carley_couple = 24.7*1000.0; % Carley's Thermocouple Constant, converts temperature values.
offset = 0.972;              % The voltage offset we introduced in the circuit.
% epsilon = 0.5;               % Named after the calculus value, this compensates for noise.

% Initializes our T matrix, based on the period.
T = zeros(6,1);

disp('Begun Recording');
arduinoOn;

for n = 1:10
    
    % Begins our timer code, it makes the graph *actually* real-time. (See
    % end of the loop for details)
    tic;
        
    % First, we initialize our sensorValue vector. This will store all our
    % data for this time step.
    sensorValue = zeros(6,1);
    
    % This is our first TMP, the ambient air temperature. We multiply it by
    % 100 to set this to be true.
    sensorValue(1) = a.analogRead(0) * to_voltage * 100.0;
    
    % Now, we can for loop it up for the thermocouples.
    for j = 1:4
        sensorValue(j+1) = ((a.analogRead(j) * to_voltage) - offset)*carley_couple;
    end
    
    % This is the final TMP, it measures the power resistor.
    sensorValue(6) = a.analogRead(5) * to_voltage * 100.0;

    % The thermocouples can be erratic at times, they report temperatures
    % higher/lower than they're actually experiencing. As such,we must
    % correct them here.
    sensorValue(2,n) = sensorValue(2,n) - 1.5;
    sensorValue(5,n) = sensorValue(5,n) + 1.5;
    
    
    % Finally, we concencate the data from the sensors with the T matrix.
    T = [T sensorValue];
        
    % After a while (6000 seconds), we want to start checking if we've 
    % reached equilibrium.
    if ( n > 6000/dT )
        if ( (T(3,n) - T(3,(n-500))) < epsilon )
                arduinoOff;
                m = -1;
        end % I chose the second thermocouple to check for equilibrium, as
    end     % as it gives fairly consistent data.
    
    % This sets up our x-axis, and plots the data.
    x = dT:dT:n*dT;
    plot(x, T(1:6,1:n));
    
    % As a safety measure, we save the variables to file every iteration.
    save('temp.mat','T','x');
    
    % The parameters of our graph
    xlabel('Time (s)');
    ylabel('Temperature (Celsius)');
    title('Temperature of Aluminum Bar');
    legend('Ambient Temperature','Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Heater', 'Location', 'NorthWest');
    grid on;
    
    
    % We stop the timer, and adjust our waiting time for the time elapsed. 
    timeElapsed = toc;
    pause(dT - timeElapsed);
end

c = clock;
d = int2str(c);
save(d,'T','x');
disp('Recording Complete');