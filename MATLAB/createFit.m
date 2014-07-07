function [fitresult, gof] = createFit(x, y, w)
%CREATEFIT(X,Y,W)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Output: y
%      Weights : w
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 19-Sep-2013 14:20:02


%% Fit: 'untitled fit 1'.
[xData, yData, weights] = prepareCurveData( x, y, w );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf];
opts.StartPoint = [13.5996895608078 -0.822472300445505];
opts.Upper = [Inf Inf];
opts.Weights = weights;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData, 'kx' );
hold on;
errorbar(x,y,w,'k-');
hold off;
legend( h, 'y vs. x with w', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel( 'x' );
ylabel( 'y' );
grid on

