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

userNumber = 11;

users = { ...
{{'005 user01 PP 01c cane mz1','009 user01 PP 06b belt mz1'},{'002 user01 PP 02a cane mz2','006 user01 PP 04a belt mz2'},{'003 user01 PP 03a cane mz3','007 user01 PP 05a belt mz3'}}, ...
{{'015 user02 AC 01b cane mz1','020 user02 AC 05a belt mz1'},{'016 user02 AC 02a cane mz2','019 user02 AC 04a belt mz2'},{'018 user02 AC 03b cane mz3','021 user02 AC 06a belt mz3'},{'030 user02 AC 12a cane mz4','023 user02 AC 07b belt mz4'}}, ...
{{'031 user03 SG 01a cane mz1','036 user03 SG 06a belt mz1'},{'032 user03 SG 02a cane mz2','035 user03 SG 05a belt mz2'},{'033 user03 SG 03a cane mz3','037 user03 SG 07a belt mz3'},{'034 user03 SG 04a cane mz4','038 user03 SG 08a belt mz4'}}, ...
{{'045 user04 SF 01a cane mz1','050 user04 SF 06a belt mz1'},{'046 user04 SF 02a cane mz2','049 user04 SF 05a belt mz2'},{'047 user04 SF 03a cane mz3','051 user04 SF 07a belt mz3'},{'048 user04 SF 04a cane mz4','052 user04 SF 08a belt mz4'}}, ...
{{'069 user06 RC 01a cane mz1','074 user06 RC 06a belt mz1'},{'070 user06 RC 02a cane mz2','073 user06 RC 05a belt mz2'},{'071 user06 RC 03a cane mz3','075 user06 RC 07a belt mz3'},{'072 user06 RC 04a cane mz4','076 user06 RC 08a belt mz4'}}, ...
{{'095 user08 HS 01a cane mz1','100 user08 HS 06a belt mz1'},{'096 user08 HS 02a cane mz2','099 user08 HS 05a belt mz2'},{'097 user08 HS 03a cane mz3','101 user08 HS 07a belt mz3'},{'098 user08 HS 04a cane mz4','102 user08 HS 08a belt mz4'}}, ...
{{'108 user09 JK 01a cane mz1','113 user09 JK 06a belt mz1'},{'109 user09 JK 02a cane mz2','112 user09 JK 05a belt mz2'},{'110 user09 JK 03a cane mz3','114 user09 JK 07a belt mz3'},{'111 user09 JK 04a cane mz4','116 user09 JK 08b belt mz4'}}, ...
{{'122 user10 KB 01b cane mz1','127 user10 KB 06a belt mz1'},{'123 user10 KB 02a cane mz2','126 user10 KB 05a belt mz2'},{'124 user10 KB 03a cane mz3','128 user10 KB 07a belt mz3'},{'125 user10 KB 04a cane mz4','129 user10 KB 08a belt mz4'}}, ...
{{'135 user11 MK 01a cane mz1','140 user11 MK 06a belt mz1'},{'136 user11 MK 02a cane mz2','139 user11 MK 05a belt mz2'},{'137 user11 MK 03a cane mz3','141 user11 MK 07a belt mz3'},{'138 user11 MK 04a cane mz4','142 user11 MK 08a belt mz4'}}, ...
{{'147 user12 BB 01a cane mz1','152 user12 BB 06a belt mz1'},{'148 user12 BB 02a cane mz2','151 user12 BB 05a belt mz2'},{'149 user12 BB 03a cane mz3','153 user12 BB 07a belt mz3'},{'150 user12 BB 04a cane mz4','154 user12 BB 08a belt mz4'}}, ...
{{'159 user13 TL 01a cane mz1','164 user13 TL 06a belt mz1'},{'160 user13 TL 02a cane mz2','163 user13 TL 05a belt mz2'},{'161 user13 TL 03a cane mz3','165 user13 TL 07a belt mz3'},{'162 user13 TL 04a cane mz4','166 user13 TL 08a belt mz4'}} ...
};
userNumToID = [1, 2, 3, 4, 6, 8, 9, 10, 11, 12, 13];
%tests = {{'015 user02 AC 01b cane mz1','020 user02 AC 05a belt mz1'},{'016 user02 AC 02a cane mz2','019 user02 AC 04a belt mz2'},{'018 user02 AC 03b cane mz3','021 user02 AC 06a belt mz3'},{'030 user02 AC 12a cane mz4','023 user02 AC 07b belt mz4'}};
%tests = {{'005 user01 PP 01c cane mz1','009 user01 PP 06b belt mz1'},{'002 user01 PP 02a cane mz2','006 user01 PP 04a belt mz2'},{'003 user01 PP 03a cane mz3','007 user01 PP 05a belt mz3'}};
%tests = {{'031 user03 SG 01a cane mz1','036 user03 SG 06a belt mz1'},{'032 user03 SG 02a cane mz2','035 user03 SG 05a belt mz2'},{'033 user03 SG 03a cane mz3','037 user03 SG 07a belt mz3'},{'034 user03 SG 04a cane mz4','038 user03 SG 08a belt mz4'}};
%tests = {{'045 user04 SF 01a cane mz1','050 user04 SF 06a belt mz1'},{'046 user04 SF 02a cane mz2','049 user04 SF 05a belt mz2'},{'047 user04 SF 03a cane mz3','051 user04 SF 07a belt mz3'},{'048 user04 SF 04a cane mz4','052 user04 SF 08a belt mz4'}};
%tests = {{'069 user06 RC 01a cane mz1','074 user06 RC 06a belt mz1'},{'070 user06 RC 02a cane mz2','073 user06 RC 05a belt mz2'},{'071 user06 RC 03a cane mz3','075 user06 RC 07a belt mz3'},{'072 user06 RC 04a cane mz4','076 user06 RC 08a belt mz4'}};
%tests = {{'095 user08 HS 01a cane mz1','100 user08 HS 06a belt mz1'},{'096 user08 HS 02a cane mz2','099 user08 HS 05a belt mz2'},{'097 user08 HS 03a cane mz3','101 user08 HS 07a belt mz3'},{'098 user08 HS 04a cane mz4','102 user08 HS 08a belt mz4'}};
%tests = {{'108 user09 JK 01a cane mz1','113 user09 JK 06a belt mz1'},{'109 user09 JK 02a cane mz2','112 user09 JK 05a belt mz2'},{'110 user09 JK 03a cane mz3','114 user09 JK 07a belt mz3'},{'111 user09 JK 04a cane mz4','116 user09 JK 08b belt mz4'}};
%tests = {{'122 user10 KB 01b cane mz1','127 user10 KB 06a belt mz1'},{'123 user10 KB 02a cane mz2','126 user10 KB 05a belt mz2'},{'124 user10 KB 03a cane mz3','128 user10 KB 07a belt mz3'},{'125 user10 KB 04a cane mz4','129 user10 KB 08a belt mz4'}};
%tests = {{'135 user11 MK 01a cane mz1','140 user11 MK 06a belt mz1'},{'136 user11 MK 02a cane mz2','139 user11 MK 05a belt mz2'},{'137 user11 MK 03a cane mz3','141 user11 MK 07a belt mz3'},{'138 user11 MK 04a cane mz4','142 user11 MK 08a belt mz4'}};
%tests = {{'147 user12 BB 01a cane mz1','152 user12 BB 06a belt mz1'},{'148 user12 BB 02a cane mz2','151 user12 BB 05a belt mz2'},{'149 user12 BB 03a cane mz3','153 user12 BB 07a belt mz3'},{'150 user12 BB 04a cane mz4','154 user12 BB 08a belt mz4'}};
%tests = {{'159 user13 TL 01a cane mz1','164 user13 TL 06a belt mz1'},{'160 user13 TL 02a cane mz2','163 user13 TL 05a belt mz2'},{'161 user13 TL 03a cane mz3','165 user13 TL 07a belt mz3'},{'162 user13 TL 04a cane mz4','166 user13 TL 08a belt mz4'}};
tests = users{userNumber};
numTests = numel(tests);

file = 'data-analysis-blind-users-20160524.xlsx';
sheet = 1;
filePath = strcat(dropboxPath,file);
[num,txt,raw] = xlsread(filePath,sheet);

wallTapCol = 15;
collisionCol = 18;

xll = 0.6;
xul = 2.4;

f1 = figure();
set(f1, 'Position', [30 60 1200 400]);

bigTitleFontSize = 14;
titleFontSize = 10;
legendFontSize = 10;
xaxisFontSize = 10;

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
    
    % Plotting
    sp1 = subplot(3,3*numTests,[1 2 3 3*numTests+1 3*numTests+2 3*numTests+3]+3*(i-1));
    hold on
    plot(x1(if1:il1)+x_shift1,y1(if1:il1)+y_shift1,'LineWidth',2.5,'Color','b');
    plot(x2(if2:il2)+x_shift2,y2(if2:il2)+y_shift2,'LineWidth',2.5,'Color','r');
    if i==1
        plot([-3 -2],[0.5,0.5],'k');
        plot([-3 -3],[0.45,0.55],'k');
        plot([-2 -2],[0.45,0.55],'k');
        text(-2.8,0.27,'1m');
        text(-5,6,'A','FontSize',24);
    elseif i==2 || i==3
        plot([-0.5 0.5],[0.5,0.5],'k');
        plot([-0.5 -0.5],[0.45,0.55],'k');
        plot([0.5 0.5],[0.45,0.55],'k');
        text(-0.25,0.27,'1m');
    elseif i==4
        plot([-3 -2],[1.9,1.9],'k');
        plot([-3 -3],[1.85,1.95],'k');
        plot([-2 -2],[1.85,1.95],'k');
        text(-2.8,1.67,'1m');
    end
    if i==1 || i==2
        legendLocation = 'southeast';
        legend({'cane','belt'},'Location',legendLocation,'FontSize',legendFontSize);
    elseif i==3
        legendLocation = 'northeast';
        legend({'cane','belt'},'Position',[0.645,0.81,0.05,0.05],'FontSize',legendFontSize);
    elseif i==4
        legend({'cane','belt'},'Position',[0.835,0.703,0.05,0.05],'FontSize',legendFontSize);
    end
    %title(sprintf('User %02d Maze %d',userNum,mazeNum),'FontSize',bigTitleFontSize);
    title(sprintf('Maze %d',mazeNum),'FontSize',bigTitleFontSize);
    plot_maze(f1,mazeNum);
    box off
    set(gca,'visible','off')
    hold off
    
    sp2 = subplot(3,3*numTests,6*numTests+3*(i-1)+1);
    hold on;
    bar(1, distance1, 'facecolor', [0.1 0.1 1]);
    bar(2, distance2, 'facecolor', [1 0.1 0.1]);
    xlim(sp2,[xll xul])
    hold off;
    ylabel('Distance [m]','FontSize',titleFontSize);
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'},'FontSize',xaxisFontSize);

    sp3 = subplot(3,3*numTests,6*numTests+3*(i-1)+2);
    hold on;
    bar(1, wallTaps, 'facecolor', [0.4 0.4 1]);
    bar(2, collisions, 'facecolor', [1 0.4 0.4]);
    xlim(sp3,[xll xul])
    hold off;
    ylabel('Wall Taps / Collisions','FontSize',titleFontSize);
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'},'FontSize',xaxisFontSize);
    
    sp4 = subplot(3,3*numTests,6*numTests+3*(i-1)+3);
    hold on;
    bar(1, tt1, 'facecolor', [0.77 0.77 1]);
    bar(2, tt2, 'facecolor', [1 0.77 0.77]);
    xlim(sp4,[xll xul])
    hold off;
    ylabel('Duration [s]','FontSize',titleFontSize)
    set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'},'FontSize',xaxisFontSize);

%     subplot(4,2*numTests,6*numTests+2*(i-1)+1)
%     hold on;
%     bar(1, ave1, 'facecolor', 'b');
%     bar(2, ave2, 'facecolor', 'r');
%     hold off;
%     ylabel('average velocity [m/s]')
%     set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

    %ah=axes('position',[0,0,1,1],'visible','off'); % <- select your pos... 
    %line([0,0],[0,1],'parent',ah,'linewidth',1);
end


userNo = sprintf('User %02d', userNumToID(userNumber));

annotation('textbox', [0 0.9 1 0.1], ...
    'String', userNo, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',...
    'FontSize', 30);
