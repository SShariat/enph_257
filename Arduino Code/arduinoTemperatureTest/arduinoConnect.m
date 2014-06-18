clc;
clear all;
delete(instrfindall);

% This clears everything else, as well as the COM port

a = arduino('COM10');