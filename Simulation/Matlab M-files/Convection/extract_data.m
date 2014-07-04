function [real_data]=extract_data(y)
    y = y';
    real_data = flipud(y(2:5,:));
end