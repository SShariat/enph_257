clc;
clear all;
delete(instrfindall);
% Our setup, deleting all that came before.

newT = zeros(); % These can be changed to be longer vectors, representing multiple points on the rod.
dT = 1;

% Value, in seconds, we want to run the program for.
period = 10;

% Activates our control over the Arduino board. Dance, puppet, dance!
a = arduino('COM10');
T = 0; % (a.analogRead(1)) * 5 / 1023;

for i = 1:period
    sensorValue = a.analogRead(1);
    newT = (sensorValue) * 5.0 / 1023.0;
    T = [T newT];
    pause(dT);
end

delete(a);
% Closes our port connection; the Invisible Hand has withdrawn.

x = 0:dT:period;
plot(x, T);
xlabel('Time (s)');
ylabel('Value');