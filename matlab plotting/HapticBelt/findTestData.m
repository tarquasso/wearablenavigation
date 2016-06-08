function [ goodTests ] = findTestData(dropboxPath, num,txt )

%give this function data from an excel spreadsheet file
%it will parse through the spreadsheet and find the
%tests that you should process
%and return the relevant information associated with those tests

numRows = size(num,1);
dateCol = 2;
userCol = 3;
initialsCol = 4;
tangoCol = 14;
row = 1;
userSection = 1;
goodTests = {};


while row < numRows
    % use excel spreadsheet to generate folder name
    textRow = row + 2;
    userNum = num(row,userCol);
    serialDate = num(row,dateCol);
    date = datetime(serialDate,'ConvertFrom','excel');
    day = sprintf('%02d',date.Day);
    month = sprintf('%02d',date.Month);
    year = sprintf('%04d',date.Year);
    user = sprintf('%02d',userNum);
    initials = txt(textRow,initialsCol);
    userFolder1 = dropboxPath;
    userFolder2 = strcat('user',user,' -',{' '}, year,month,day,'/',initials,'/tango/');
    userFolder2 = userFolder2{1};
    userFolder = strcat(userFolder1,userFolder2);
    skip = 0;
    try
        foldersString = ls(userFolder);
    catch ME
        if (strcmp(ME.identifier,'MATLAB:ls:OSError'))
            skip = 1;
        end
    end
    if ~skip
        folders = sort(strsplit(foldersString,{'\t','\n','\0'},'CollapseDelimiters',true));
    end

    isUser = num(row,1);
    rowRange = row;
    while ~isnan(isUser) && rowRange < numRows-1
        rowRange = rowRange + 1;
        isUser = num(rowRange+1,1);
    end
    
    if ~skip
        % use excel spreadsheet to find test names
        tests = num(row:rowRange,7);
        tries = txt(row+2:rowRange+2,8);
        testNames = num(row:rowRange,14);
        sortedTests = {};
        for i = 1:size(tests,1)
            catTest = strcat(sprintf('%02d',tests(i)),tries(i));
            sortedTests{i,1} = catTest{1};
            sortedTests{i,2} = testNames(i);
            sortedTests{i,3} = row - 1 + i;
        end
        sortedTests = sortrows(sortedTests,1);

        % use test names to find the successful/latest tests
        goodTests{userSection,1,1} = sortedTests{1,1};
        goodTests{userSection,1,2} = sortedTests{1,2};
        goodTests{userSection,1,3} = sortedTests{1,3};
        ticker = 1;
        for i = 1:size(sortedTests,1)-1
            gT = goodTests{userSection,ticker,1};
            sT = sortedTests{i+1,1};
            if gT(2) == sT(2)
                goodTests{userSection,ticker,1} = sortedTests{i+1,1};
                goodTests{userSection,ticker,2} = sortedTests{i+1,2};
                goodTests{userSection,ticker,3} = sortedTests{i+1,3};
            else
                goodTests{userSection,ticker+1,1} = sortedTests{i+1,1};
                goodTests{userSection,ticker+1,2} = sortedTests{i+1,2};
                goodTests{userSection,ticker+1,3} = sortedTests{i+1,3};
                ticker = ticker + 1;
            end
        end

        for i = 1:size(goodTests,2)
            testRow = goodTests{userSection,i,3};
            id = sprintf('%03d',num(testRow,1));
            user = sprintf('%02d',num(testRow,userCol));
            subj = txt(testRow+2,initialsCol);
            testRun = goodTests{userSection,i,1};
            device = txt(testRow+2,9);
            maze = txt(testRow+2,10);

            goodTests{userSection,i,4} = id;
            goodTests{userSection,i,5} = user;
            goodTests{userSection,i,6} = subj;
            goodTests{userSection,i,7} = device;
            goodTests{userSection,i,8} = maze;
            goodTests{userSection,i,9} = userFolder2;
        end
        userSection = userSection + 1;
    end

    row = rowRange + 2;
end

end

