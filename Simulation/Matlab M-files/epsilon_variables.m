function [M]=epsilon_variables(c,kf,ec,ekef)
M = [[(c+ec) kf];[(c-ec) kf]; [c (kf+ekef)]; [c (kf - ekef)]]';
%M = [[(c+ec) k f];[(c-ec) k f];[c (k+ek) f];[c (k-ek) f];[c k (f+ef)];[c k (f-ef)]]';
% M = num2cell(M);

end