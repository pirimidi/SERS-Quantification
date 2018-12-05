%--------------------------------------------------------------------------
% Author: Mirko Palla.
% Date: August 6, 2013.
%
% For: Thilophenol quantification by Raman spectroscopy at the Boisen Lab - 
% Department of Micro- and Nanotechnology, DTU Nanotech.
%
% Purpose: This program creates two folders (bmp, fig) and move appropiate
% file types into them in the current directory.
%
% This software may be used, modified, and distributed freely, but this
% header may not be modified and must appear at the top of this file.
%--------------------------------------------------------------------------

function raman_move_files()
    
    if exist('fig','dir') == 0
        mkdir('fig');
    end
    
    if exist('bmp','dir') == 0
        mkdir('bmp');
    end
    
    movefile('*.bmp','bmp')
    movefile('*.fig','fig')
    
end
