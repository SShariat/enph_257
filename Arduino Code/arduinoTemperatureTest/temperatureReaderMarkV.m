%% Temperature Test Mark V : Computer-Controlled Circuit
% (heh, alliteration)

% This code controls a MOSFET hooked up to our temperature circuit,
% turning on and off the power resistor. This lets us control the circuit 
% remotely. I also fixed the bug where dT could only be 1.

% Clears all prior data clogging up our screen.
clc;

% Measures the time interval between points, in seconds.
dT = 1;

% Constants which define the length of time our program will run for, which
% itself is defined in the next block.
second = 1;
minute = 60;
hour = minute*60;

% Value, in seconds, we want to run the program for. Thanks to the above
% constants, we can simply enter in the time period in the time units we
% prefer.
period = 5*hour;

% Constants related to measuring temperature.
to_voltage = (5.0 / 1023.0); % Changes analog values to their equivalent voltages.
gain = 247.0;                % Gain of the op-amp.
carley_couple = 24.7*1000.0; % Carley's Thermocouple Constant, converts temperature values.
offset = 0.972;              % The voltage offset we introduced in the circuit.
% epsilon = 0.5;               % Named after the calculus value, this compensates for noise.

% Initializes our T matrix, based on the period.
T = zeros(6,(dT*period));

disp('Begun Recording');
arduinoOn;

for i = 1:(period/dT)
    
    % Begins our timer code, it makes the graph *actually* real-time. (See
    % end of the loop for details)
    tic;
        
    % First, we initialize our sensorValue vector. This will store all our
    % data for this time step.
    sensorValue = zeros(1,6);
    
    % This is our first TMP, the ambient air temperature. We multiply it by
    % 100 to set this to be true.
    sensorValue(1) = a.analogRead(0) * to_voltage * 100.0;

    % To do: fix this so that it's more readable.
    
    % Now, we can for loop it up for the voltage offset.
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

    % The thermocouples can be erratic at times, they report temperatures
    % higher/lower than they're actually experiencing. As such,we must
    % correct them here.
    T(2,i) = T(2,i) - 1.5;
    T(5,i) = T(5,i) + 1.5;
        
    % After a while, we want to start checking if we've reached equilibrium
    if ( i > 6000/dT )
        if ( (T(3,i) - T(3,(i-500))) < epsilon )
                arduinoOff;
        end % I chose the second thermocouple to check for equilibrium, as
    end     % as it gives fairly consistent data.
    
    % This sets up our x-axis, and plots the data.
    x = dT:dT:i*dT;
    plot(x, T(1:6,1:i));
    
    % As a safety measure, we save the variables to file every iteration.
    save('variables_test.mat', 'T', 'x');
    
    % The parameters of our graph
    xlabel('Time (s)');
    ylabel('Temperature (Celsius)');
    title('Temperature of Aluminum Bar');
    legend('Ambient Temperature','Thermocouple 1', 'Thermocouple 2', 'Thermocouple 3', 'Thermocouple 4', 'Heater', 'Location', 'NorthEast');
    grid on;
    
    
    % We stop the timer, and adjust our waiting time for the time elapsed. 
    timeElapsed = toc;
    pause(dT - timeElapsed);
end

disp('Recording Complete');