function [ bestTests ] = findTestData(dropboxPath, num,txt )

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


while row <= numRows
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
    
    %skip this set of data if the user folder does not exist
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

    %rowRange is the number of rows of test data that this user has
    %even if you want to skip this user you need to know how many rows to
    %skip
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
        wallTaps = num(row:rowRange,15);
        majColls = num(row:rowRange,16);
        minColls = num(row:rowRange,17);
        sumColls = num(row:rowRange,18);
        %sortedTests is just a cell array of the test data in the excel
        %spreadsheet, regardless of whether or not the test is 'good'
        sortedTests = {};
        for i = 1:size(tests,1)
            catTest = strcat(sprintf('%02d',tests(i)),tries(i));
            sortedTests{i,1} = catTest{1};
            sortedTests{i,2} = testNames(i);
            sortedTests{i,3} = row - 1 + i;
            sortedTests{i,4} = wallTaps(i);
            sortedTests{i,5} = majColls(i);
            sortedTests{i,6} = minColls(i);
            sortedTests{i,7} = sumColls(i);
        end
        %you need to sort the tests to get the good data
        %for example you want test 1c, not 1a
        sortedTests = sortrows(sortedTests,1);

        % use test names to find the successful/latest tests

        ticker = 1;
        maxWallTaps = 0;
        maxMajCollRow = 1;
        i = 1;

        goodTests{userSection,ticker,1} = sortedTests{i,1};
        goodTests{userSection,ticker,2} = sortedTests{i,2};
        goodTests{userSection,ticker,3} = sortedTests{i,3};
        wallTapMax = sortedTests{i,4};
        goodTests{userSection,ticker,11} = wallTapMax;
        goodTests{userSection,ticker,12} = sortedTests{i,5}; %majColls
        goodTests{userSection,ticker,13} = sortedTests{i,6}; %minColls
        goodTests{userSection,ticker,14} = sortedTests{i,7}; %sumColls
        
        while i < size(sortedTests,1)
            
            i = i + 1;
            
            gT = goodTests{userSection,ticker,1}
            sT = sortedTests{i,1}
            if strcmp(gT(1:2),sT(1:2)) && i <= size(sortedTests,1)
                goodTests{userSection,ticker,1} = sortedTests{i,1};
                goodTests{userSection,ticker,2} = sortedTests{i,2};
                goodTests{userSection,ticker,3} = sortedTests{i,3}; %testRow
                goodTests{userSection,ticker,11} = max(goodTests{userSection,ticker,11},sortedTests{i,4});
                
                if goodTests{userSection,ticker,12} < sortedTests{i,5}
                    goodTests{userSection,ticker,12} = sortedTests{i,5}; %majColls
                    goodTests{userSection,ticker,13} = sortedTests{i,6}; %minColls
                    goodTests{userSection,ticker,14} = sortedTests{i,7}; %sumColls
                end
                
                %i = i + 1;
            else
                ticker = ticker + 1;

                goodTests{userSection,ticker,1} = sortedTests{i,1};
                goodTests{userSection,ticker,2} = sortedTests{i,2};
                goodTests{userSection,ticker,3} = sortedTests{i,3};
                wallTapMax = sortedTests{i,4};
                goodTests{userSection,ticker,11} = wallTapMax;
                goodTests{userSection,ticker,12} = sortedTests{i,5}; %majColls
                goodTests{userSection,ticker,13} = sortedTests{i,6}; %minColls
                goodTests{userSection,ticker,14} = sortedTests{i,7}; %sumColls
            end
        end

%             gT = goodTests{userSection,ticker,1};
%             i = i + 1;
%             if i <= size(sortedTests,1)
%                 sT = sortedTests{i,1};
%                 while strcmp(gT(1:2),sT(1:2)) && i <= size(sortedTests,1)
%                     %testNameDebug = sortedTests(i,1);
%                     goodTests{userSection,ticker,1} = sortedTests{i,1};
%                     goodTests{userSection,ticker,2} = sortedTests{i,2};
%                     goodTests{userSection,ticker,3} = sortedTests{i,3}; %testRow
%                     potentialMax = sortedTests{i,4}
%                     wallTapMax = max(goodTests{userSection,ticker,11},sortedTests{i,4})
%                     goodTests{userSection,ticker,11} = wallTapMax;
%                     i = i+1;
%                     if i < size(sortedTests,1)
%                         sT = sortedTests{i+1,1};
%                     end
%                 end
%             end
%             ticker = ticker + 1;
%         end

%         for i = 1:size(sortedTests,1)-1
%             gT = goodTests{userSection,ticker,1}
%             sT = sortedTests{i+1,1}
%             testName = goodTests{userSection,ticker,2};
%             testRow = sortedTests{i+1,3};
%             if strcmp(gT(1:2), sT(1:2))
%                 goodTests{userSection,ticker,1} = sortedTests{i+1,1};
%                 goodTests{userSection,ticker,2} = sortedTests{i+1,2};
%                 goodTests{userSection,ticker,3} = testRow;
%                 
%             else
%                 goodTests{userSection,ticker+1,1} = sortedTests{i+1,1};
%                 goodTests{userSection,ticker+1,2} = sortedTests{i+1,2};
%                 goodTests{userSection,ticker+1,3} = testRow;
%                 ticker = ticker + 1;
%                 maxWallTaps = 0;
%                 maxMajCollRow = testRow;
%             end
%             
%             maze = txt(testRow+2,10);
%             if ~isempty(maze)
%                 maze = maze{1}
%                 isMaze = strcmp(maze(1:2),'mz');
% 
%                 if isMaze
%                     maxWallTaps = max(maxWallTaps,num(testRow,15));
%                     if num(maxMajCollRow,16) < num(testRow,16)
%                         maxMajCollRow = testRow;
%                     end
%                     maxMajColl = max(num(maxMajCollRow,16),num(testRow,16));
%                     goodTests{userSection,ticker,11} = maxWallTaps;
%                     maxWallTaps
%                     
%                     goodTests{userSection,ticker,16} = maxMajCollRow;
%                     goodTests{userSection,ticker,12} = num(maxMajCollRow,16);
%                     goodTests{userSection,ticker,13} = num(maxMajCollRow,17);
%                     goodTests{userSection,ticker,14} = num(maxMajCollRow,18);
%                 end
%             end
%         end

        for i = 1:size(goodTests,2)
            if i > size(goodTests,2)
                break
            end
            testRow = goodTests{userSection,i,3};
            id = sprintf('%03d',num(testRow,1))
            user = sprintf('%02d',num(testRow,userCol));
            subj = txt(testRow+2,initialsCol);
            testRun = goodTests{userSection,i,1};
            device = txt(testRow+2,9);
            maze = txt(testRow+2,10);
            video = num(testRow,12);
            majCollAct = num(testRow,16);
            minCollAct = num(testRow,17);
            sumCollAct = num(testRow,18);

            goodTests{userSection,i,4} = id;
            goodTests{userSection,i,5} = user;
            goodTests{userSection,i,6} = subj;
            goodTests{userSection,i,7} = device;
            goodTests{userSection,i,8} = maze;
            goodTests{userSection,i,9} = userFolder2;
            goodTests{userSection,i,10} = video;
            %wallTaps = goodTests{userSection,i,11};
            %{id maze wallTaps}
            
            maze = maze{1};
            if strcmp(maze(1:2),'bx')
                goodTests{userSection,i,12} = majCollAct;
                goodTests{userSection,i,13} = minCollAct;
                goodTests{userSection,i,14} = sumCollAct;
                boxTrial = txt{testRow+2,19};
                if strcmp(boxTrial,'cleared it') || strcmp(boxTrial,'yes')
                    goodTests{userSection,i,15} = 1; %boxSuccess
                elseif strcmp(boxTrial,'kicked it') || strcmp(boxTrial,'no') || strcmp(boxTrial,'felt it')
                    goodTests{userSection,i,15} = -1;
                else
                    goodTests{userSection,i,15} = 0;
                end
            end
        end
        userSection = userSection + 1;
    end

    row = rowRange + 2
end

numTests = size(goodTests,1)*size(goodTests,2);
ticker = 1;
bestTests = {};
for i = 1:size(goodTests,1)
    for j = 1:size(goodTests,2)
        testName = goodTests(i,j,2);
        if ~isnan(testName{1})
            for k=1:size(goodTests,3)
                databit = goodTests(i,j,k);
                bestTests{ticker,k} = databit{1};
            end
            ticker = ticker + 1;
        end
    end
end

end