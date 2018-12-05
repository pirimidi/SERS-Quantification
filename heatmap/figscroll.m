function figscroll()

dirstruct=dir(pwd);
filenames=arrayfun(@(x) x.name,dirstruct,'UniformOutput',false);
TF=strfind(filenames,'.fig');
notfigcells=cellfun(@isempty,TF);
figfiles_start=(filenames(~notfigcells));
i=1;
figfiles=figfiles_start;

while i<(length(figfiles)+1)
    
    workingfiles=cellfun(@isempty,figfiles);
    figfiles=figfiles(~workingfiles);
    open(figfiles{i});
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    strResponse = input('Press Enter (foward), b (back), e (end) and then hit enter: ', 's')
    
    %pause;
    if isempty(strResponse)
        i=i+1;
    end
    if strcmp(strResponse,'b')
        i=i-1;
    end
        
    if strcmp(strResponse,'e')
        close all;
        break;
    end

    close;
end