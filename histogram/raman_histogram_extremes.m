%--------------------------------------------------------------------------
% Author: Mirko Palla.
% Date: August 5, 2013.
%
% For: Vasopressin quantification by Raman spectroscopy at the Lin/Ju Lab - 
% Mechanical/Chemical Engineering Department, Columbia University.
%
% Purpose: This program receives a Raman measurement map in the form of an
% intensity matrix, then creates the histogram of intensity distribution
% of the top p% and returns the x and y-axis extremes.
%
% This software may be used, modified, and distributed freely, but this
% header may not be modified and must appear at the top of this file.
%--------------------------------------------------------------------------

function [x_max, y_max] = raman_histogram_extremes(file_name, p)

% Set default number formatting.
format short;

% Get intensity values from intensity matrix data file.
M = load(file_name);

% Determine dimensions of intensity matrix.
[r, c] = size(M);

% Collect all intensity entries from matrix into an array, I.
I = reshape(M, 1, r*c); 

% Sort intensity values in descending order.
D = sort(I, 'descend');

% Remove non-positive intensity values from intensity array. 
m = 1;
for n=1:length(D)
    
    if(D(n) > 0)
        R(m) = D(n);
        m = m + 1;  % update internal counter.
    end
end

% Select top p% of intensity values to display.
maxima = floor(p*length(R)/100);
T = R(1:maxima);

% Create histogram of intensity distribution using 100 bins.
hist(T, 100);

% Get extremes of all histograms for scaling purposes.
h = gca;
x_max = get(h, 'XLim'); x_max = x_max(2);
y_max = get(h, 'YLim'); y_max = y_max(2);
close;

