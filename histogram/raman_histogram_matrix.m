%--------------------------------------------------------------------------
% Author: Mirko Palla.
% Date: October 1, 2012.
%
% For: Vasopressin quantification by Raman spectroscopy at the Lin/Ju Lab - 
% Mechanical/Chemical Engineering Department, Columbia University.
%
% Purpose: This program receives a Raman measurement map in the form of an
% intensity matrix, then creates the histogram of intensity distribution
% of the top p%.
%
% This software may be used, modified, and distributed freely, but this
% header may not be modified and must appear at the top of this file.
%--------------------------------------------------------------------------

function raman_histogram_matrix(file_name, p, limits)

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
title('Hotspot Intensity Distribution in Heatmap')
axis([0 limits(1) 0 limits(2)]);

% Fit histogram with power law and display functional relationship.
showfit('power; lin', 'fitcolor', 'red');

% Save histogram in *.bmp and *.fig file formats.
[pathstr, name, ext] = fileparts(file_name);
f = strcat(name, '_hi_', num2str(p), '%');
print ('-dbmp', [f, '.bmp']);
saveas(gcf, [f, '.fig']);
close;

% Display some statistics on hotspots.
fprintf('\n');
disp(['--> Total number of measurements: ', num2str(length(D))]);
disp(['--> Total number of hotspots: ', num2str(length(R))]);
disp(['--> Top ', num2str(p), '% of hotspots: ', num2str(length(T))]);
disp(['--> File ', f, ' was created!']);
fprintf('\n');
