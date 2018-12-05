%--------------------------------------------------------------------------
% Author: Mirko Palla.
% Date: September 18, 2012.
%
% For: Vasopressin quantification by Raman spectroscopy at the Lin/Ju Lab - 
% Mechanical/Chemical Engineering Department, Columbia University.
%
% Purpose: This program receives a set of Raman measurement map containing 
% three columns: [C1] X coordinate (uM), [C2] Y coordinate and the [C3] 
% corresponding intensity values (cnt), then creates the matrix of intensity 
% values (which can be later used to generate the equivalent heatmap).
%
% This software may be used, modified, and distributed freely, but this
% header may not be modified and must appear at the top of this file.
%--------------------------------------------------------------------------

function raman_matrix()

% Set default number formatting.
format short;

% Get all datasets in directory.
d = dir('*.txt');
file_names = {d.name};

% Determine the number of files to evaluate.
l = length(file_names);

% Iterate through all datasets and create matrix of intensities.
for i=1:l

    % Get intensity values from snake map data file.
    map = load(char(file_names(i)));

    % Display heatmap processing status.
    disp(['--> Processing matrix: ', char(file_names(i))]);      

    Y = map(:,1);   % Y coordinate (um)
    I = map(:,3);   % relative intensity value (cnt) 

    % Replace negative intensity values with zero. 
    for n=1:length(I)

        if(I(n) < 0)
            I(n) = 0;
        end
    end

    % Count horizontal step number. 
    y_val = Y(1);

    for m=1:length(Y)

        if(y_val ~= Y(m))
            x_steps = m-1;
            break;
        end

        y_val = Y(m);   % update current Y coordinate 
    end

    % Count vertical step number.
    y_steps = floor(length(Y)/x_steps);

    % Create 3D matrix containing intensity values corresponding to XY
    % coordinates.

    u = 1;  % main counter
    for j=1:y_steps

        if mod(j,2)==1
            for k=1:x_steps            
                M(j,k) = I(u);  % build intensity matrix when y-step is odd
                u = u+1;    % increment main counter             
            end
        end

        if mod(j,2)==0
            for k=1:x_steps            
                M(j,x_steps-k+1) = I(u);  % build intensity matrix when y-step is even
                u = u+1;    % increment main counter             
            end        
        end
    end
    
    % Print intensity data respresented into text file.
    [pathstr, name, ext] = fileparts(char(file_names(i)));
    fi = strcat(name, '_matrix.txt');
    dlmwrite(fi, M, 'delimiter', '\t', 'precision', 6);
    
end
