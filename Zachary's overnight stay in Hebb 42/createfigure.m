function createfigure(X1, YMatrix1)
%CREATEFIGURE(X1, YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 18-Jun-2014 13:55:54

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1);
set(plot1(1),'DisplayName','Ambient Temperature');
set(plot1(2),'DisplayName','Thermocouple 1');
set(plot1(3),'DisplayName','Thermocouple 2');
set(plot1(4),'DisplayName','Thermocouple 3');
set(plot1(5),'DisplayName','Thermocouple 4');
set(plot1(6),'DisplayName','Heater');

% Create xlabel
xlabel('Time (s)');

% Create ylabel
ylabel('Temperature (Celsius)');

% Create title
title('Temperature of Aluminum Bar');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.529501488095237 0.452774735304856 0.1421875 0.127783862723622]);

save('variables','X1','YMatrix1')

