
dropboxPath = '~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/';
%dropboxPath = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';

fileIn = 'data-analysis-blind-users-20160524.xlsx';
idColName = 'id';
sheet = 1;

filePathIn = strcat(dropboxPath,fileIn);
[num,txt,raw] = xlsread(filePathIn,sheet);

firstRow = raw(1,:);
validTitleStrings = matlab.lang.makeValidName(firstRow);
ID = matlab.lang.makeUniqueStrings(validTitleStrings,{},...
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
id = cell2mat(idColRaw(elementsRelevant));

%check if id numbers are integers:
if ~all(~mod(id,1))
    error('id numbers have to all be integers!')
end

%%

%check if the id numbers are unique
[n, bin] = histc(id, unique(id));
multiple = find(n > 1);
index    = find(ismember(bin, multiple));

if ~isempty(index)
    error(strcat('id numbers are not unique, see indices:', mat2str(index)));
end
%%
%find usernum column


data = raw(elementsRelevant,:);


fileOut = 'data-analysis-blind-users-20160524_without_tango.mat';
filePathOut = strcat(dropboxPath,fileOut);

save(filePathOut,'ID','data');

% add tango data to it!

%TODO

fileOutTango = 'data-analysis-blind-users-20160524_with_tango.mat';
filePathOutTango = strcat(dropboxPath,fileOutTango);

save(filePathOutTango,'ID','data_compiled');


