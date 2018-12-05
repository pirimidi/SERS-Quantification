%--------------------------------------------------------------------------
% Author: Mirko Palla.
% Date: August 5, 2013.
%
% For: Vasopressin quantification by Raman spectroscopy at the Lin/Ju Lab - 
% Mechanical/Chemical Engineering Department, Columbia University.
%
% Purpose: This program receives a set of Raman measurement maps in the 
% form of intensity matrices, then generates a 2D heatmap, a histogram
% of intensity distribution and intensity integrals for the top p% hotspots
% for all maps.
%
% This software may be used, modified, and distributed freely, but this
% header may not be modified and must appear at the top of this file.
%--------------------------------------------------------------------------

function raman_automator_matrix(hm, hi, ii)

fprintf('\n');
disp('--> Raman automator matrix start');

% Start timer.
tic;

% Set default number formatting.
format short;

% Get current working directory.
cwd = pwd;

% Execute heatmap automation.
if hm == 1
    
    % Change to heatmap direcory.
    cd([cwd, '/heatmap']);

    % Get all datasets in directory.
    d = dir('*.txt');
    file_names = {d.name};

    % Determine the number of files to evaluate.
    l = length(file_names);

    % Iterate through all datasets and create 2D heatmaps of intensity 
    % distribution for each concentration at each mapping area.
    for i=1:l

        % Get file name of mapping experiment.
        map = char(file_names(i));

        % Display heatmap processing status.
        disp(['--> Processing heatmap matrix: ', map]); 

        % Create 2D heatmap of hotspot intensities.
        raman_heatmap_matrix(map);
        
    end
    
    % Move image files into their appropiate directory.
    raman_move_files();
    
end

% Execute histogram automation.
if hi == 1
  
    % Change to histogram direcory.
    cd([cwd, '/histogram']);

    % Get all datasets in directory.
    d = dir('*.txt');
    file_names = {d.name};

    % Determine the number of files to evaluate.
    l = length(file_names);    
    
    % Top percentage value holder array.
    p = [20];
    
    % Define histogram extrema containers.
    x_max = []; y_max = [];
    
    % Iterate through all datasets and create histograms of intensity 
    % distribution for each concentration at each mapping area.
    i = 1;
    for n=1:l
        
        % Get file name of mapping experiment.
        map = char(file_names(n));
        
        for m=1:length(p)

            % Calculate extremes for individual histograms.
            [x_max(i) y_max(i)] = raman_histogram_extremes(map, (p(m))); 
            i = i + 1;
            
        end    
    end

    limits = [max(x_max) max(y_max)];
            
    % Iterate through all datasets and create histograms of intensity 
    % distribution for each concentration at each mapping area.
    for j=1:l

            % Get file name of mapping experiment.
            map = char(file_names(j));

            % Display histogram processing status.
            disp(['--> Processing histogram matrix: ', map]);  

        for k=1:length(p)

            % Create histogram of top p% of hotspot intensities.
            raman_histogram_matrix(map, (p(k)), limits); 

        end    
    end
    
    % Move image files into their appropiate directory.
    raman_move_files();
    
end

% Execute intensity integral automation.
if ii == 1
    
    % Change to heatmap direcory.
    cd([cwd, '/intensity']);
  
    % Top percentage value holder array.
    p = [20];
    
    % Outlyer percentage value holder array.
    o = [0 1 5 10];

    for k=1:length(p)
        for m=1:length(o)

            % Calculate intensity integral of top p% of hotspots and 
            %remove o% of the hotspot oputliers.
            raman_intensity_sum_power(8, 1, p(k), o(m)); 

        end    
    end
    
    % Move image files into their appropiate directory.
    raman_move_files();
    
end

disp('--> Raman automator matrix end');
fprintf('\n');

% Stop timer.
toc;

fprintf('\n');
