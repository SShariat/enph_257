%% Temperature Test Mark II : Reading in from multiple input sources.

%  Like last time, we are going to use a potentiometer to simulate the
%  input from a solid-state thermometer. The difference from the previous
%  iteration is, however, that we are going to be using three of them!

% Our setup, deleting all that came before.
clc;
clear all;
delete(instrfindall);

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

period = 2*minute;

% Activates our control over the Arduino board. Dance, puppet, dance!
a = arduino('COM10');
T = [(a.analogRead(1)) * 5.0 / 1023.0; (a.analogRead(2)) * 5.0 / 1023.0; (a.analogRead(3)) * 5.0 / 1023.0;];
% A side effect of our concencation; we must define the initial value of T
% at t=0. This big nasty equation is what we do to get the initial values.
%disp(Press Start);

disp('Begun Recording');

%Added a Wait Bar to the System
h = waitbar(0, 'Recording Data DO NOT CANCEL...');

for i = 1:period
      
    % This will read in a value (between 0 and 1023, this is an analog
    % input), from the first potentiometer.
    sensorValueA = a.analogRead(1);
    
    % Now we do this two more times.
    sensorValueB = a.analogRead(2);
    sensorValueC = a.analogRead(3);
            
    % This converts the data from an Arduino analog input into an actual
    % voltage value.
    newT(1,1) = (sensorValueA) * 5.0 / 1023.0;
    
    % And again, let's do this two more times, reading into successive
    % columns of our matrix.
    newT(2,1) = (sensorValueB) * 5.0 / 1023.0;
    newT(3,1) = (sensorValueC) * 5.0 / 1023.0;
    
    % Now, we concencate the values onto the matrix. Despite this taking
    % longer, since we pause for a whole second at the end of each loop, it
    % shouldn't be a problem. This program is not built for speed, but for
    % reliability and readability.
    T = [T newT];
    x = 0:dT:i;
    %plot data
    plot(x, T(1:3,:));
   
    waitbar(i/period);
    % We pause for our previously-agreed-upon delta-t value.
    pause(dT);
   
end
close(h)

disp('Finished Recording');
%Graphing Parameters
xlabel('Time (s)');
ylabel('Value');
legend('Sensor 1','Sensor 2','Sensor 3');
grid on;


delete(a);
% Closes our port connection; the Invisible Hand has withdrawn.

disp('Saving Variables to File');
save('variables.mat', 'T', 'x');

%NOTE: If a sensor is not conncected to anything it will float and base its
%value based on the other sensor values.
