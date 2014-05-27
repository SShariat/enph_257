%% Temperature Test Mark III : Real-Time Graph

%  Last time, we managed to graph three seperate potentiometer inputs.
%  However, it outputs the graph at the very end, so that we don't know
%  what's going on until we finish recording the data. This is not ideal,
%  as when we're recording the temperature data overnight, we don't want to
%  come in one morning and see that since a wire was disconnected, we
%  simply recorded a straight line of zero temperature.

% Our setup, deleting all that came before.
clc;
clear all;
delete(instrfindall);

% These define the concencated matrix, as well as the default time
% interval, in seconds.
newT = zeros(); 
dT = 1;

% Value, in seconds, we want to run the program for.
period = 10;

% Activates our control over the Arduino board. Dance, puppet, dance!
a = arduino('COM10');

T = [(a.analogRead(1)) * 5.0 / 1023.0; (a.analogRead(2)) * 5.0 / 1023.0; (a.analogRead(3)) * 5.0 / 1023.0;];
% A side effect of our concencation; we must define the initial value of T
% at t=0. This big nasty equation is what we do to get the initial values.

% This initializes our x-axis variable, the time.
time = 0;

% Here, we initialize our graph. Despite just showing the initial value of
% T, we will grow this as time goes on.
hold on
drawnow;
plot(time, T(1,:)), axis auto;
plot(time, T(2,:)), axis auto;
plot(time, T(3,:)), axis auto;
grid on;
xlabel('Time (s)');
ylabel('Value');

display('Drawing Graph...')

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
    
    % Under construction...    
    
    time = time+1;
    plot(time, T(1,:)), axis auto;
    drawnow;
    plot(time, T(2,:)), axis auto;
    drawnow;
    plot(time, T(3,:)), axis auto;
    drawnow;
    
    
    % Finally, we pause for our previously-agreed-upon delta-t value.
    pause(dT);
end

delete(a);
% Closes our port connection; the Invisible Hand has withdrawn.

hold off

display('Plotting complete!');