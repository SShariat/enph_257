% This program calculates the heat transferred from a 100W heater through  
% a copper rod to a 0°C ice bath. The 1m rod is divided into 40 segments,  
% and the temperature of the segments at 0.1m, 0.5m and 0.9m is graphed
% against time. Only conduction is considered for heat transfer.
% The power into the leftmost segment will always be 100W because it is 
% next to the heater; the temperature of the rightmost segment will always 
% be 0°C because it is in the ice bath.

kCu = 401; % conductance of copper
cCu = 386; % specific heat capacity of copper
dCu = 8960; %density of copper
diameterRod = 0.01; % diameter of the rod [m]
lengthSeg = 0.025; % length of one segment [m]
areaSeg = (diameterRod/2)^2 * pi; % cross-sectional area of the copper rod [m^2]
volumeSeg = lengthSeg * areaSeg; % volume of one segment [m^3]
massSeg = volumeSeg * dCu; % mass of one segment

iterations = 250000; % number of times heat transfer is calculated for each segment
deltaTime = 0.01; % duration of each iteration [s]

tempMatrix = zeros(iterations+1,40); %
qOut = zeros(1,40);
qIn = zeros(1,40);
qIn(1) = 100 * deltaTime;


for k = 1:iterations
    
    for i = 1:39
    qOut(1,i) = kCu * areaSeg * (1/lengthSeg) * deltaTime * (tempMatrix(k,i) - tempMatrix(k,i+1)); 
    end
    
    for j = 2:39
    qIn(1,j) = qOut(1,j-1);
    end
    
    qNet = qIn - qOut;

    for j = 1:39
    tempMatrix(k+1,j) = tempMatrix(k,j) + qNet(1,j) / massSeg / cCu; 
    end

end

time = 0:iterations;
elements = 1:40;

tenCm = tempMatrix(:,4)';
fiftyCm = tempMatrix(:,20)';
ninetyCm = tempMatrix(:,36)';

finalElements = tempMatrix(iterations+1,:);

hold on
plot(time, tenCm, 'r-')
plot(time, fiftyCm, 'b-')
plot(time, ninetyCm, 'g-')

xlabeltitle = strcat('Time [', num2str(deltaTime), 's]');

legend('10 cm', '50 cm', '90 cm')
xlabel(xlabeltitle)
ylabel('Temperature [°C]')
title('Temperature of 1cm segments in copper rod')
hold off


