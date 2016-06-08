function process_tango_data_excel(dropboxPath,num,txt)

tests = findTestData(dropboxPath,num,txt);
mazeCol = 8;
testNameCol = 2;
userFolderCol = 9;

numUsers = size(tests,1);

maze = tests(1,1,mazeCol);
maze = maze{1}{1};
userNum = 1;
testNum = 1;
for i=1:numUsers
    foundTest = 0;
    numTests = sum(~cellfun('isempty',tests(1,:,1)));
    for j=1:numTests
        %check that the test is a maze
        maze = tests(i,j,mazeCol);
        maze = maze{1}{1};
        if strcmp(maze(1:2),'mz')
            %check that tango data exists
            testName = tests(i,j,testNameCol);
            testName = testName{1};
            if ~isnan(testName)
                userFolder = tests{i,j,userFolderCol};
                testName = num2str(testName);
                path = strcat(dropboxPath,userFolder,testName,'/');
                foundTest = 1;
                userNum = i;
                testNum = j;
                break;
            end
        end
    end
    if foundTest
        break;
    end
end

try
    fileString = ls(path);
catch
    path = strcat(path,'vio_rgb/');
    fileString = ls(path);
end

files = sort(strsplit(fileString,{'\t','\n','\0'},'CollapseDelimiters',true));

x = [];
y = [];
z = [];
t = [];

for i=3:length(files)
    fileString = strcat(path, files{i});
    if i == 3
        file = dlmread(fileString,',',3,0);
    else
        file = dlmread(fileString);
    end
    
    x = [x; file(:,1)];
    y = [y; file(:,2)];
    z = [z; file(:,3)];
    t = [t; mod(file(:,11), 100000)];
end

x = x - x(1);
y = y - y(1);

total_time = (t(end)-t(1))/1000;
if total_time < 0
    total_time = (100000 + t(end) - time1(1))/1000;
end
distance = findDistance(x,y);

f1 = figure();
set(f1,'OuterPosition',[0 0 750 750]);
subplot('Position',[0.7 0.55 0.25 0.25]);
zplot = plot(z);
title('z axis data');
subplot('Position',[0.13 0.35 0.5 0.5]);
plot(x,y,'LineWidth',2.5,'Color','b');
title(sprintf('degrees = 0 | first index = 1 | last index = end | x shift = 0 | y shift = 0 | time = %0.3f | distance = %0.3f',total_time,distance));
axis equal
ax = gca;
mazeNum = str2num(maze(3));
plot_maze(f1,mazeNum);
theta = 0;
index_first = 1;
index_last = length(x);
y_shift = 0;
x_shift = 0;
saveName = 'test';
mazeOrBox = 0;

data = {};
data{1} = x; % these are intended to store the ROTATED and TRANSLATED x, y data
data{2} = y;
data{3} = index_first;
data{4} = index_last;
data{5} = x; % these are intended to store the ORIGINAL x, y data
data{6} = y;
data{7} = theta;
data{8} = t;
data{9} = y_shift;
data{10} = x_shift;
data{11} = saveName;
data{12} = mazeNum;
data{13} = z;
data{14} = z; % stores the ORIGINAL z data
data{15} = zplot; %the handle to the z plot
data{16} = userNum;
data{17} = testNum;
data{19} = mazeOrBox;

testRun = tests{userNum,testNum,1};
id = tests{userNum,testNum,4};
user = tests{userNum,testNum,5};
subj = tests{userNum,testNum,6};
device = tests{userNum,testNum,7};
maze = tests{userNum,testNum,8};
saveAs = strcat(id,' user',user,{' '},subj,{' '},testRun,{' '},device,{' '},maze,'.mat');
saveAs = saveAs{1};
data{18} = saveAs;

guidata(f1, data);

b1 = uicontrol('Parent',f1,'Style','slider','Position',[100,40,419,23],...
              'value',theta, 'min',-120, 'max',180,'SliderStep',[0.0007 0.10]);
b1.Callback = @(es,ed) rotateData(es,ed,ax,f1);

b2 = uicontrol('Parent',f1,'Style','slider','Position',[100,20,419,23],...
              'value',index_first, 'min',1, 'max',1500,'SliderStep',[0.0007 0.10]);
b2.Callback = @(es,ed) clipDataFirst(es,ed,ax,f1);

b3 = uicontrol('Parent',f1,'Style','slider','Position',[100,0,419,23],...
              'value',index_last, 'min',length(x)-200, 'max',9*length(x),'SliderStep',[0.0009 0.10]);
b3.Callback = @(es,ed) clipDataLast(es,ed,ax,f1);

b4 = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,60,60,23],...
              'String','Save');
b4.Callback = @(es,ed) saveData(es,ed,ax,dropboxPath);

b5 = uicontrol('Parent',f1,'Style','slider','Position',[100,60,419,23],...
              'value',y_shift, 'min',0, 'max',2,'SliderStep',[0.005 0.10]);
b5.Callback = @(es,ed) shiftY(es,ed,ax,f1);

b6 = uicontrol('Parent',f1,'Style','slider','Position',[100,80,419,23],...
              'value',x_shift, 'min',-3, 'max',3,'SliderStep',[0.0015 0.02]);
b6.Callback = @(es,ed) shiftX(es,ed,ax,f1);

b9 = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,330,70,23],...
              'String','Flatten Data');
b9.Callback = @(es,ed) flattenData(es,ed,ax,f1);

b10 = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,230,70,23],...
              'String','Next Test -->');
b10.Callback = @(es,ed) nextTest(es,ed,ax,f1,dropboxPath,numUsers,tests);

shiftX_label = uicontrol('Parent',f1,'Style','text','Position',[40,80,50,23],...
              'String','x_shift');

shiftY_label = uicontrol('Parent',f1,'Style','text','Position',[40,60,50,23],...
              'String','y_shift');
          
rotate_label = uicontrol('Parent',f1,'Style','text','Position',[40,40,50,23],...
              'String','rotate');
          
clipDataFirst_label = uicontrol('Parent',f1,'Style','text','Position',[35,20,60,23],...
              'String','clipDataFirst');
          
clipDataLast_label = uicontrol('Parent',f1,'Style','text','Position',[35,0,60,23],...
              'String','clipDataLast');
          
end

function saveData(es,ed,ax,dropboxPath)

data = guidata(es);

x = data{1};
y = data{2};
orig_x = data{5};
orig_y = data{6};
time = data{8};
index_first = data{3};
index_last = data{4};
theta = data{7};
y_shift = data{9};
x_shift = data{10};
saveName = data{11};
mazeNum = data{12};
z = data{13};
orig_z = data{14};
userNum = data{16};
testNum = data{17};
saveAs = data{18};
saveAs = strcat(dropboxPath,'processedData/',saveAs);
mazeOrBox = data{19};

distance = findDistance(x(index_first:index_last),y(index_first:index_last));
total_time = (time(index_last) - time(index_first))/1000;
if total_time < 0
    total_time = (100000 + time(index_last) - time(index_first))/1000;
end
ave_velocity = distance/total_time;

save(saveAs,'x','y','orig_x','orig_y','time','index_first','index_last','theta','total_time','y_shift','x_shift','distance','ave_velocity','mazeNum','z','orig_z','userNum','testNum','mazeOrBox');

end

function saveNameCallback(es,ed,ax)

data = guidata(es);
data{11} = es.String;
guidata(es, data);

end

function [distance] = findDistance(x,y)

distance = 0;

for i=2:length(x)
    addDistance = sqrt((x(i)-x(i-1))^2+(y(i)-y(i-1))^2);
    distance = distance + addDistance;
end

end

function chooseMaze(es,ed,ax,f1)
    data = guidata(es);
    mazeNum = es.Value - 1;
    data{12} = mazeNum;
    guidata(es, data);

    plotPath(es,ed,ax,f1);
end

function flattenData(es,ed,ax,f1)
    data = guidata(es);
    x = data{1};
    y = data{2};
    z = data{13};
    index_first = data{3};
    index_last = data{4};

    syms b g;

    rotateY(b) = [cos(b) 0 sin(b); 0 1 0; -sin(b) 0 cos(b)];
    rotateX(g) = [1 0 0; 0 cos(g) -sin(g); 0 sin(g) cos(g)];

    sf = fit([x(index_first:index_last) y(index_first:index_last)],z(index_first:index_last),'poly11')

    yAngle = -atan(sf.p10)

    xAngle = -atan(sf.p01)

    points = [x';y';z'];
    
    double(rotateY(yAngle)*rotateX(xAngle))

    newPoints = double(rotateY(yAngle)*rotateX(xAngle))*points;

    nx = newPoints(1,:)';
    ny = newPoints(2,:)';
    nz = newPoints(3,:)';
    
    data{1} = nx;
    data{2} = ny;
    data{13} = nz;
    
    guidata(es, data);
        
    plotPath(es,ed,ax,f1);

end

function rotateData(es,ed,ax,f1)

data = guidata(es);
theta = es.Value*pi/180;

x = data{5};
y = data{6};
index_first = data{3};
%translate the 'index_first' point to the origin
%so that rotation occurs around the index_first point
x = x - x(index_first); 
y = y - y(index_first);
r = [cos(theta) sin(theta); -sin(theta) cos(theta)];
points = [x y];
newpoints = (r*points')';
x = newpoints(:,1);
y = newpoints(:,2);

data{1} = x;
data{2} = y;
data{7} = es.Value;

guidata(es, data);

plotPath(es,ed,ax,f1);

end

function clipDataFirst(es,ed,ax,f1)

data = guidata(es);
index = floor(es.Value);

x = data{1};
y = data{2};
x = x - x(index);
y = y - y(index);

data{3} = index;
data{1} = x;
data{2} = y;

guidata(es,data);

plotPath(es,ed,ax,f1);

end

function clipDataLast(es,ed,ax,f1)

data = guidata(es);
max_index = size(data{1},1);
index_last = floor(es.Value);

if index_last > max_index
    index_last = max_index;
end

data{4} = index_last;
guidata(es,data);

plotPath(es,ed,ax,f1);

end

function shiftY(es,ed,ax,f1)

data = guidata(es);
y_shift = es.Value;
data{9} = y_shift;
guidata(es,data);

plotPath(es,ed,ax,f1);

end

function shiftX(es,ed,ax,f1)

data = guidata(es);
x_shift = es.Value;
data{10} = x_shift;
guidata(es,data);

plotPath(es,ed,ax,f1);

end

function plotPath(es,ed,ax,f1)

data = guidata(es);

x = data{1};
y = data{2};
index_first = data{3};
index_last = data{4};
theta = data{7};
y_shift = data{9};
x_shift = data{10};
time = data{8};
mazeNum = data{12};
zplot = data{15};
z = data{13};
userNum = data{16};
testNum = data{17};
saveAs = data{18};
mazeOrBox = data{19};

cla(ax);

hold on;

plot(x(index_first:index_last)+x_shift,y(index_first:index_last)+y_shift,'LineWidth',2.5,'Color','b');
if mazeOrBox == 0
    plot_maze(f1,mazeNum);
else
    plot_box(f1,mazeNum);
end
%axis([-3 2.5 0.5 6])

hold off;

set(zplot,'YData',z(index_first:index_last));

distance = findDistance(x(index_first:index_last),y(index_first:index_last));
total_time = (time(index_last) - time(index_first))/1000;
if total_time < 0
    total_time = (100000 + time(index_last) - time(index_first))/1000;
end
title(sprintf('degrees = %.3f | first index = %d | last index = %d | x shift = %0.3f | y shift = %0.3f \n time = %0.3f | distance = %0.3f | mazeNum = %d \n userNum = %02d testNum = %03d \n saveAs = %s', ...
    theta,index_first,index_last,x_shift,y_shift,total_time,distance,mazeNum,userNum,testNum,saveAs));

end

function nextTest(es,ed,ax,f1,dropboxPath,numUsers,tests)
data = guidata(es);

userNum = data{16};
testNum = data{17} + 1;

mazeCol = 8;
testNameCol = 2;
userFolderCol = 9;

mazeOrBox = 0;
testName = tests(userNum,testNum,testNameCol);
maze = tests(userNum,testNum,mazeCol);
maze = maze{1}{1};
firstTime = 1;
for i=userNum:numUsers
    foundTest = 0;
    numTests = sum(~cellfun('isempty',tests(1,:,1)));
    
    %if this is not the first time the loop is iterating, then you want
    %to reset testNum to be 1
    if ~firstTime
        testNum = 1;
    else
        firstTime = 0;
    end
    for j=testNum:numTests
        %check that the test is a maze
        maze = tests(i,j,mazeCol);
        maze = maze{1}{1};
        if strcmp(maze(1:2),'mz') || strcmp(maze(1:2),'bx')
            if strcmp(maze(1:2),'bx')
                mazeOrBox = 1;
            else
                mazeOrBox = 0;
            end
            %check that tango data exists
            testName = tests(i,j,testNameCol);
            testName = testName{1};
            if ~isnan(testName)
            %if it does exist, proceed down
                userFolder = tests{i,j,userFolderCol};
                testName = num2str(testName);
                path = strcat(dropboxPath,userFolder,testName,'/');
                foundTest = 1;
                userNum = i;
                testNum = j;
                break;
            end            
        end
    end
    if foundTest
        break;
    end
end

try
    fileString = ls(strcat(path,'vio_rgb/'));
    path = strcat(path,'vio_rgb/');
catch
    fileString = ls(path);
end

files = sort(strsplit(fileString,{'\t','\n','\0'},'CollapseDelimiters',true));

x = [];
y = [];
z = [];
t = [];

for i=3:length(files)
    fileString = strcat(path, files{i});
    if i == 3
        file = dlmread(fileString,',',3,0);
    else
        file = dlmread(fileString);
    end
    
    x = [x; file(:,1)];
    y = [y; file(:,2)];
    z = [z; file(:,3)];
    t = [t; mod(file(:,11), 100000)];
end

x = x - x(1);
y = y - y(1);

total_time = (t(end)-t(1))/1000;
if total_time < 0
    total_time = (100000 + t(end) - t(1))/1000;
end
distance = findDistance(x,y);

theta = 0;
index_first = 1;
index_last = length(x);
y_shift = 0;
x_shift = 0;
saveName = 'test';
mazeNum = str2num(maze(3));

data{1} = x; % these are intended to store the ROTATED and TRANSLATED x, y data
data{2} = y;
data{3} = index_first;
data{4} = index_last;
data{5} = x; % these are intended to store the ORIGINAL x, y data
data{6} = y;
data{7} = theta;
data{8} = t;
data{9} = y_shift;
data{10} = x_shift;
data{11} = saveName;
data{12} = mazeNum;
data{13} = z;
data{14} = z; % stores the ORIGINAL z data
data{16} = userNum;
data{17} = testNum;
data{19} = mazeOrBox;

testRun = tests{userNum,testNum,1};
id = tests{userNum,testNum,4};
user = tests{userNum,testNum,5};
subj = tests{userNum,testNum,6};
device = tests{userNum,testNum,7};
maze = tests{userNum,testNum,8};
saveAs = strcat(id,' user',user,{' '},subj,{' '},testRun,{' '},device,{' '},maze,'.mat');
saveAs = saveAs{1};
data{18} = saveAs;

guidata(f1, data);

plotPath(es,ed,ax,f1);

end