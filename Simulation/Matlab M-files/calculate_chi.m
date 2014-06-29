function [chi_square]=calculate_chi(sim_data, real_data)
    error = 1;
    diff = ((real_data - sim_data)/error);
    chi_square = norm(diff,'fro')^2;
end