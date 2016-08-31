% FILL IN YOUR computer username here:
editorNames = {'rkk', 'brandonaraki_backup'};

dropboxPathOptions = {'~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/',...
    '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/'};

osUserName = char(java.lang.System.getProperty('user.name'));

for k = 1:length(editorNames)
    curName = editorNames{k};
  if strcmp (osUserName,curName)
      dropboxPath = dropboxPathOptions{k};
  end
end

tests = {{'015 user02 AC 01b cane mz1','020 user02 AC 05a belt mz1'},{'016 user02 AC 02a cane mz2','019 user02 AC 04a belt mz2'},{'018 user02 AC 03b cane mz3','021 user02 AC 06a belt mz3'},{'030 user02 AC 12a cane mz4','023 user02 AC 07b belt mz4'}};
numTests = numel(tests);

file = 'data-analysis-blind-users-20160524.xlsx';
sheet = 1;
filePath = strcat(dropboxPath,file);
[num,txt,raw] = xlsread(filePath,sheet);

wallTapCol = 15;
collisionCol = 18;

f1 = figure();

for i=1:numTests
    test1 = tests{i}{1};
    path = strcat(dropboxPath,'processedData/',test1);
    load(path);
    saveAs1 = test1;
    id1 = str2num(saveAs1(1:3));
    id1 = find(num(:,1)==id1);
    x1 = x;
    x_shift1 = x_shift;
    y1 = y;
    y_shift1 = y_shift;
    theta1 = theta;
    tt1 = total_time;
    ave1 = ave_velocity;
    time1 = time;
    distance1 = distance;
    if1 = index_first;
    il1 = index_last;
    if tt1 < 0
        tt1 = (100000 + time1(il1) - time1(if1))/1000;
        ave1 = distance1/tt1;
    end
    
    test2 = tests{i}{2};
    path = strcat(dropboxPath,'processedData/',test2);
    load(path);

    saveAs2 = test2;
    id2 = str2num(saveAs2(1:3));
    id2 = find(num(:,1)==id2);
    x2 = x;
    x_shift2 = x_shift;
    y2 = y;
    y_shift2 = y_shift;
    theta2 = theta;
    tt2 = total_time;
    ave2 = ave_velocity;
    distance2 = distance;
    if2 = index_first;
    il2 = index_last;
    time2 = time;
    if tt2 < 0
        tt2 = (100000 + time2(il2) - time2(if2))/1000;
        ave2 = distance2/tt2;
    end

    
    wallTaps = num(id1,wallTapCol);
    if isnan(wallTaps)
        wallTaps = 0;
    end
    collisions = num(id2,collisionCol);
    if isnan(collisions)
        collisions = 0;
    end
    
    subplot(4,2*numTests,[1 2 1+2*numTests 2+2*numTests]+2*(i-1));
    hold on
    plot(x1(if1:il1)+x_shift1,y1(if1:il1)+y_shift1,'LineWidth',2.5,'Color','b');
    plot(x2(if2:il2)+x_shift2,y2(if2:il2)+y_shift2,'LineWidth',2.5,'Color','r');
    legend('cane','belt','Location','southeast');
    title(sprintf('User %02d Maze %d',userNum,mazeNum));
    plot_maze(f1,mazeNum);
    hold off
    
    subplot(4,2*numTests,4*numTests+2*(i-1)+1)
    hold on;
    bar(1, distance1, 'facecolor', 'b');
    bar(2, distance2, 'facecolor', 'r');
    hold off;
    ylabel('distance [m]');
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

    subplot(4,2*numTests,4*numTests+2*(i-1)+2)
    hold on;
    bar(1, tt1, 'facecolor', 'b');
    bar(2, tt2, 'facecolor', 'r');
    hold off;
    ylabel('time [s]')
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

    subplot(4,2*numTests,6*numTests+2*(i-1)+1)
    hold on;
    bar(1, ave1, 'facecolor', 'b');
    bar(2, ave2, 'facecolor', 'r');
    hold off;
    ylabel('average velocity [m/s]')
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

    subplot(4,2*numTests,6*numTests+2*(i-1)+2)
    hold on;
    bar(1, wallTaps, 'facecolor', 'b');
    bar(2, collisions, 'facecolor', 'r');
    hold off;
    ylabel('wall taps / collisions')
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});
    
end