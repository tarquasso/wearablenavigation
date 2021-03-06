% Description: this takes in the spreadsheet 'data-analysis-blind-users-20160524.xlsx'
%  and the files in the ProcessedData folder, 
% then outputs it to a big .mat file in the dropbox: data-analysis-blind-users-20160524_with_tango.mat
% and also rewrites the processed Data files with fixed times and additional 
% infos into a separate folder called ProcessedDataFixed/

%% EDIT FILE NAMES BELOW IF NEEDED

% FILL IN YOUR computer username here:
editorNames = {'rkk', 'brandonaraki'};

dropboxPathOptions = {'~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/',...
    '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/'};

osUserName = char(java.lang.System.getProperty('user.name'));

for k = 1:length(editorNames)
    curName = editorNames{k};
  if strcmp (osUserName,curName)
      dropboxPath = dropboxPathOptions{k};
  end
end

fileIn = 'data-analysis-blind-users-20160524rev1.xlsx';

processedDataFolderName = 'processedData/';
processedDataFilesPath = [dropboxPath,processedDataFolderName];
processedDataFileName = '*.mat';

fileOutTango = 'data-analysis-blind-users-20160524rev1_with_tango1.mat';
filePathOutTango = strcat(dropboxPath,fileOutTango);
% writing to csv not fully functional yet...
%fileOutTangoCSV = 'data-analysis-blind-users-20160524_with_tango.csv';
%filePathOutTangoCSV = strcat(dropboxPath,fileOutTangoCSV);

%% AFTER THIS POINT NO CUSTOMIZATION NEEDED, hopefully...
idColName = 'id';
sheet = 1;

filePathIn = strcat(dropboxPath,fileIn);
[num,txt,raw] = xlsread(filePathIn,sheet);

firstRow = raw(1,:);
validTitleStrings = matlab.lang.makeValidName(firstRow);
dataheader = matlab.lang.makeUniqueStrings(validTitleStrings,{},...
    namelengthmax);


%%

tableSize = size(raw);

[~,idCol,idV] = find(strcmp(raw,idColName));

if isempty(idV)
    error('could not find id row and column, spreadsheet does not have id column!');
end

% now we found the column number to use!
idColRaw = raw(:,idCol);
elementsNumeric = cellfun(@(x) isnumeric(x) && ~isnan(x) , idColRaw);
elementsRelevant = find(elementsNumeric);
idVector = cell2mat(idColRaw(elementsRelevant));

%check if id numbers are integers:
if ~all(~mod(idVector,1))
    error('id numbers have to all be integers!')
end

%% check for unique id numbers

%check if the id numbers are unique
[n, bin] = histc(idVector, unique(idVector));
multiple = find(n > 1);
index    = find(ismember(bin, multiple));

if ~isempty(index)
    error(strcat('id numbers are not unique, see indices:', mat2str(index)));
end

%% Extract the rest of the data

data = raw(elementsRelevant,:);

% fileOut = 'data-analysis-blind-users-20160524_without_tango.mat';
% filePathOut = strcat(dropboxPath,fileOut);
% 
% save(filePathOut,'dataheader','data');

%% add tango data to it!

% loop through all the tango data files

processedDataFiles = dir([processedDataFilesPath,processedDataFileName]);
idNumArray = NaN(length(processedDataFiles),1);
counter = 1;

for file = processedDataFiles'
    % load data of the first file in the folder
    filePathAbs = [processedDataFilesPath,file.name];
    dataSetOrig = load(filePathAbs);
    dataSet = dataSetOrig;
    % Check if the data already contains an id number
    if ~isfield(dataSet,'id')
        % extract from file name
        [idOfTrial,remain] = strtok(file.name);
        dataSet.id = str2double(idOfTrial);
    end
    if any(dataSet.id==idNumArray)
        error(['ID number ',dataSet.id,' in ',file.name, 'was already processed']);
    end
    % find if test exists in the id column of the data!
    [isItMember,rowInData] = ismember(dataSet.id,idVector);
    
    if ~isItMember
        error(['ID number ',dataSet.id,' in ',file.name, 'does not exist']);
    end
    %append the test number
    idNumArray(counter) = dataSet.id;
    
    %     % fix time issue, if it exists
    %     tt1 = dataSet.total_time;
    %     if tt1 < 0
    %
    delta = diff(dataSet.time);
    index = find(delta<0);
    if isempty(index)
        index = NaN;
    else
        for iter = 1:length(index)
            dataSet.time(index(iter)+1:end) = dataSet.time(index(iter)+1:end)+100000;
        end
        deltaNew = diff(dataSet.time);
        indexNew = find(deltaNew<0);
        if ~isempty(indexNew)
            error(['time problem not fixed for test number ',dataSet.id,' in ',file.name]);
        end
        if1 = dataSet.index_first;
        il1 = dataSet.index_last;
        
        dataSet.total_time = (dataSet.time(il1) - dataSet.time(if1))/1000;
        
        dataSet.ave_velocity = dataSet.distance/dataSet.total_time;
    end
    
    dataSet.time_jumps_index = index;
    % add some more data variables
    
    [~,colVD,vVD] = find(strcmp(dataheader,'VideoDuration_s_'));
    if isempty(vVD)
        error(['can not find video duration column for test number ',dataSet.id,' in ',file.name]);
    end
    
    dataSet.VideoDuration_s_ = data{rowInData,colVD};
    dataSet.deltaTimeVideoTango = dataSet.total_time - data{rowInData,colVD};
   
    [~,colTG,vTG] = find(strcmp(dataheader,'tango'));
    if isempty(vTG)
        error(['can not find tango column for test number ',dataSet.id,' in ',file.name]);
    end
    dataSet.tango = data{rowInData,colTG};
    
    fields = fieldnames(dataSet);
    %iterate through all the datavalues
    for jj = 1:numel(fields)
        % find appropriate column
        [~,colF,vF] = find(strcmp(dataheader,fields{jj}));
        if ~isempty(vF)
            data{rowInData,colF} = dataSet.(fields{jj});
        end
    end
    counter = counter+1;
    % Save the fixed file
    processedDataFolderNameFixed = 'processedDataFixed/';
    processedDataFilesPathFixed = [dropboxPath,processedDataFolderNameFixed];

    filePathAbsFixed = [processedDataFilesPathFixed,file.name];
    save(filePathAbsFixed,'-struct','dataSet');
end

% generate some redundant presentations of data
structByHeader = cell2struct(data, dataheader, 2);
dataCombined = [dataheader;data];
subsetDataForTimeErrorChecking = dataCombined(:,[1,21,26,27,35,41,44,45]);

% save the data to a mat file for further processing
save(filePathOutTango,'dataheader','data','structByHeader','subsetDataForTimeErrorChecking','dataCombined');

%% TODO:
% The following is not working properly yet: Writing to csv

% fid=fopen(filePathOutTangoCSV,'wt');
% 
% [rows,cols]=size(dataCombined);
% for i=1:rows
%       fprintf(fid,'%s,',dataCombined{i,1:end-1});
%       fprintf(fid,'%s\n',dataCombined{i,end});
% end
% fclose(fid);
