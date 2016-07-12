%% Created by Bent O. Arnesen, Summer 2016, NTNU

%This function creates an "arbitrary" folder string, makes the directory as
%a subfolder within the desired path, and saves the function input as a
%.mat-file in this folder. Additional subfolders can be created if desired.

%Retrieve the data with var = load('filename'), var.varargin{1},
%doubleclick the file, etc.

%Run the command t = datetime('now'); and enter it in the beginning of the
%function. In this way, we can call saving(t, args) for the same t and for 
% many arguments. For instance, when saving figures we run
% saving(t, fig1, fig2, fig3, ...)   and when saving mat-files we run
% saving(t, matFile1, matFile2, ...) (this avoids buggy save behavior in 
% Matlab version R2015b). 

function saving(t, varargin)

%Make directories
%The directory name is chosen as the date, as it changes naturally, and
%prevents Matlab from overwriting existing files.
%
% t = datetime('now');
% ds = datestr(t);
% folderString = strcat(ds(1:2),ds(4:6),ds(8:11),'_',ds(13:14),ds(16:17),ds(19:20));
%
% %subFolder may be named, e.g., "june2016" or whatever
% [MonthNum, MonthString] = month(date);
% YearString = num2str(year(date));
% subFolder = strcat(YearString,'_', num2str(MonthNum),MonthString);



ds = datestr(t);

folderString = strcat(ds(13:14),'-', ds(16:17),'-', ds(19:20));

%subFolder may be named, e.g., "june2016" or whatever
[MonthNum, MonthString] = month(date);
MonthNumStr = num2str(MonthNum);
if length(MonthNumStr) == 1
    MonthNumStr = strcat('0', MonthNumStr);
end
YearString = num2str(year(date));
subFolder = strcat(YearString,'-', MonthNumStr, '-', ds(1:2));

nVarargs = length(varargin); %number of input arguments

%In LINUX
if isunix
    
    %Directory separators "/"
    % To find your current folder: type pwd in the command window
    % Example below
    
    %Make the name of the new directory
    parentFolder = '/home/uvlab/bent/videoray/sommerjobb/Matlab code/data and plotting/';
    newDir = strcat(parentFolder, subFolder);
    
    %Make the directory and set the path to this new directory
    mkdir(newDir, folderString);
    path = strcat(newDir,'/',folderString);
    
    %For each input...
    for k = 1:nVarargs
        try
            %...get the name...
            vararg = (varargin{k});
            str = inputname(k);
            
            %...if the name is empty, give it a "random name" so that the file can
            %be loaded...
            if strcmp(str, '')
                str = strcat('unspecified','_',num2str(k));
            end
            
            %...save "filename" w.r.t. the varargin
            file = strcat(str, '.mat');
            filename = fullfile(path, file);
            save(filename, 'varargin');
            
            fprintf('File "%s" was created in ~/%s/%s at ', file, subFolder, folderString); cprintf('*green',  '%s \n', t);
        catch
            fprintf('File "%s" was NOT created (error) in ~/%s/%s at ', file, subFolder, folderString); cprintf('*red',  '%s \n', t);
        end
        
    end
    
    %In WINDOWS
elseif ispc
    %Directory separators "\"
    
    %Make the name of the new directory
    parentFolder = strcat(pwd,'\');
    newDir = strcat(parentFolder, subFolder);
    
    mkdir(newDir, folderString); %Create all new folders
    path = strcat(newDir,'\', folderString, '\');
    
    %For each input...

    for k = 1:nVarargs
%         inputname(k)
        
        %...get the name...
        vararg = (varargin{k});
        str = inputname(k);
        
        %...if the name is empty, give it a "random name" so that the file can
        %be loaded...
        if strcmp(str, '')
            str = strcat('unspecified','_',num2str(k));
        elseif strcmp(str, 't')
            continue;
        end
        
        %...save "filename" w.r.t. the varargin
        
        
        if isstruct(vararg)
            file = strcat(str, '.mat');
            filename = fullfile(path, file);
            save(filename, 'varargin', '-mat');
            
        elseif isgraphics(vararg)
            newPath = strcat(path, str);
            savefig(vararg, newPath);
            file = strcat(str, '.fig');
        end
        
        fprintf('File "%s" was created in ', file);
        cprintf('*green',  '~\\%s\\%s. \n', subFolder, folderString);
        
    end
    
    
end

end
