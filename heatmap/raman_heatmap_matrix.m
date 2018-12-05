%--------------------------------------------------------------------------
% Author: Mirko Palla.
% Date: October 1, 2012.
%
% For: Vasopressin quantification by Raman spectroscopy at the Lin/Ju Lab - 
% Mechanical/Chemical Engineering Department, Columbia University.
%
% Purpose: This program receives a Raman measurement map in the form of an
% intensity matrix, then generates a heatmap displaying all intensity
% values.
%
% This software may be used, modified, and distributed freely, but this
% header may not be modified and must appear at the top of this file.
%--------------------------------------------------------------------------

function raman_heatmap_matrix(file_name)

% Set default number formatting.
format short;

% Get intensity values from intensity matrix data file.
M = load(file_name);

% Create heatmap object.
heatmap(M, [], [], [], 'Colormap', 'gray', 'Colorbar', true, 'ColorLevels', 256);
set(gcf, 'Units', 'normalized', 'PaperPositionMode', 'auto', 'Position', [0.1 0.1 0.7 1.]);

% Save histogram in *.bmp and *.fig file formats.
[pathstr, name, ext] = fileparts(char(file_name));
fn = strcat(name, '_hm_100%');
print ('-dbmp', [fn, '.bmp']);
saveas(gcf, [fn, '.fig']);
close;
