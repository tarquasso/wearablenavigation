dropboxPath = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';
test1 = '029 user02 AC 11a belt bx1';
path = strcat(dropboxPath,'processedData/',test1);
load(path);

saveAs1 = test1;
id1 = str2num(saveAs1(1:3));
x1 = x;
x_shift1 = x_shift;
y1 = y;
y_shift1 = y_shift;
theta1 = theta;
maze1 = mazeNum;
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


test2 = '027 user02 AC 09b belt bx2';
path = strcat(dropboxPath,'processedData/',test2);
load(path);

saveAs2 = test2;
id2 = str2num(saveAs2(1:3));
x2 = x;
x_shift2 = x_shift;
y2 = y;
maze2 = mazeNum;
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

test3 = '028 user02 AC 10a belt bx3';
path = strcat(dropboxPath,'processedData/',test3);
load(path);

saveAs3 = test3;
id3 = str2num(saveAs3(1:3));
x3 = x;
x_shift3 = x_shift;
y3 = y;
y_shift3 = y_shift;
theta3 = theta;
tt3 = total_time;
ave3 = ave_velocity;
maze3 = mazeNum;
distance3 = distance;
if3 = index_first;
il3 = index_last;
time3 = time;
if tt3 < 0
    tt3 = (100000 + time3(il3) - time3(if3))/1000;
    ave3 = distance3/tt3;
end

test4 = '025 user02 AC 08b belt bx4';
path = strcat(dropboxPath,'processedData/',test4);
load(path);

saveAs4 = test4;
id4 = str2num(saveAs4(1:3));
x4 = x;
x_shift4 = x_shift;
y4 = y;
y_shift4 = y_shift;
theta4 = theta;
tt4 = total_time;
ave4 = ave_velocity;
maze4 = mazeNum;
distance4 = distance;
if4 = index_first;
il4 = index_last;
time4 = time;
if tt4 < 0
    tt4 = (100000 + time4(il4) - time4(if4))/1000;
    ave4 = distance4/tt4;
end

file = 'data-analysis-blind-users-20160524.xlsx';
sheet = 1;
filePath = strcat(dropboxPath,file);
[num,txt,raw] = xlsread(filePath,sheet);

collisionCol = 18;

collisions1 = num(id1,collisionCol);
collisions2 = num(id2,collisionCol);
collisions3 = num(id3,collisionCol);
collisions4 = num(id4,collisionCol);

f1 = figure();
hold on
subplot(2,4,1);
plot(x1(if1:il1)+x_shift1,y1(if1:il1)+y_shift1,'LineWidth',2.5,'Color','b');
plot_box(f1,maze1);
title(sprintf('Box Trial %d',maze1));
subplot(2,4,2);
plot(x2(if2:il2)+x_shift2,y2(if2:il2)+y_shift2,'LineWidth',2.5,'Color','b');
plot_box(f1,maze2);
title(sprintf('Box Trial %d',maze2));
subplot(2,4,3);
plot(x3(if3:il3)+x_shift3,y3(if3:il3)+y_shift3,'LineWidth',2.5,'Color','b');
plot_box(f1,maze3);
title(sprintf('Box Trial %d',maze3));
subplot(2,4,4);
plot(x4(if4:il4)+x_shift4,y4(if4:il4)+y_shift4,'LineWidth',2.5,'Color','b');
plot_box(f1,maze4);
title(sprintf('Box Trial %d',maze4));

subplot(2,4,5)
bar([collisions1 distance1 tt1 ave1], 'facecolor', 'b');
set(gca, 'XTick', 1, 'XTickLabel', {'collisions, distance, time, velocity'});
subplot(2,4,6)
bar([collisions2 distance2 tt2 ave2], 'facecolor', 'b');
set(gca, 'XTick', 1, 'XTickLabel', {'collisions, distance, time, velocity'});
subplot(2,4,7)
bar([collisions3 distance3 tt3 ave3], 'facecolor', 'b');
set(gca, 'XTick', 1, 'XTickLabel', {'collisions, distance, time, velocity'});
subplot(2,4,8)
bar([collisions4 distance4 tt4 ave4], 'facecolor', 'b');
set(gca, 'XTick', 1, 'XTickLabel', {'collisions, distance, time, velocity'});

annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'User 02', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
