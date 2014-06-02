%% Temperature Test Mark iII : Real-Time Graph

%  Like last time, we are going to use a potentiometer to simulate the
%  input from a solid-state thermometer. The difference from the previous
%  iteration is, however, that we are going to be using three of them!

        %Commented out for now, available in arduinoConnect
% Our setup, deleting all that came before.
% clc;
% clear all;
% delete(instrfindall);

% These define the concencated matrix, as well as the default time
% interval, in seconds.
newT = zeros(); 
dT = 1;

% For future reference, add a keyevent so that it will just run and stop on
% queue
% Value, in seconds, we want to run the program for.
second = 1;
minute = 60;
hour = minute*60;

period = 1.5*hour;

%Constants
to_voltage = (5.0 / 1023.0);
gain = 85.0;
carley_couple = 24.7*1000.0;

% Activates our control over the Arduino board. Dance, puppet, dance!
%a = arduino('COM10');
%T = [(a.analogRead(1)) * to_voltage; (a.analogRead(2)) * to_voltage; (a.analogRead(3)) * to_voltage;];
T = [0;0;0;0;0;0];
% A side effect of our concencation; we must define the initial value of T
% at t=0. This big nasty equation is what we do to get the initial values.
%disp(Press Start);

disp('Begun Recording');

%Added a Wait Bar to the System
h = waitbar(0, 'Recording Data...');

for i = 1:period
      

    % This will read in a value (between 0 and 1023, this is an analog
    % input), from the first potentiometer. (Measured in Volts)
    sensorValue0 = a.analogRead(0)* to_voltage;
    sensorValue1 = a.analogRead(1)* to_voltage;
    sensorValue2 = a.analogRead(2)* to_voltage;
    sensorValue3 = a.analogRead(3)* to_voltage;
    sensorValue4 = a.analogRead(4)* to_voltage;
    sensorValue5 = a.analogRead(5)* to_voltage;
    
    %Variable Matrix is then update accordingly
    
    %Ambient Temperature using TMP
    temp_amb = sensorValue0*100.0;
    
    newT(1,1) = temp_amb;
    %Analog Sensors using Thermo-couple
    newT(2,1) = (sensorValue1/gain)*carley_couple + temp_amb;
    newT(3,1) = (sensorValue2/gain)*carley_couple + temp_amb;
    newT(4,1) = (sensorValue3/gain)*carley_couple + temp_amb;
    newT(5,1) = (sensorValue4/gain)*carley_couple + temp_amb;
    newT(6,1) = sensorValue5*100.0;
    
    % Now, we concencate the values onto the matrix. Despite this taking
    % longer, since we pause for a whole second at the end of each loop, it
    % shouldn't be a problem. This program is not built for speed, but for
    % reliability and readability.
    T = [T newT];
    x = 0:dT:i;
    %plot data
    plot(x, T(1:6,:));

    
    %Save Variables to file incase recording stops
    save('variables.mat', 'T', 'x');
    
    %Graphing Parameters
    xlabel('Time (s)');
    ylabel('Temperature (Celsius)');
    title('Temperature as a Function of Time');
    % legend('Ambient Temp','Sensor 1', 'Sensor 2','Sensor 3', 'Sensor 4', 'PWR R');
    grid on;
    
    waitbar(i/period);
    % We pause for our previously-agreed-upon delta-t value.
    pause(dT);
   
end
close(h)

disp('Finished Recording');

% No more deletions for now
% a.delete();
% delete(a);

% Closes our port connection; the Invisible Hand has withdrawn.

disp('Saving Variables to File');

%NOTE: If a sensor is not conncected to anything it will float and base its
%value based on the other sensor values.
