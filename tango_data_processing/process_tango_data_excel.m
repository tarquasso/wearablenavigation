function process_tango_data_excel()
global tests mazeCol testNameCol userFolderCol numUsers numTests dropboxPath num txt sp1 sp2 f1 uiH

dropboxPath = '~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/';
%dropboxPath = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';

file = 'data-analysis-blind-users-20160524.xlsx';
sheet = 1;
filePath = strcat(dropboxPath,file);
[num,txt,~] = xlsread(filePath,sheet);

% get data from excel spreadsheet
tests = findTestData(dropboxPath,num,txt);
numTests = sum(~cellfun('isempty',tests(1,:,1)));

% define global variables
mazeCol = 8;
testNameCol = 2;
userFolderCol = 9;
numUsers = size(tests,1);

userNum = 1;
testNum = 1;

f1 = figure();
set(f1,'OuterPosition',[0 0 750 750]);
sp1 = subplot('Position',[0.7 0.55 0.25 0.25]);

title('z axis data');

sp2 = subplot('Position',[0.13 0.35 0.5 0.5]);
axis equal

data = processNextTrial(userNum,testNum);

%store data into the gui
guidata(f1, data);

%plot the path
calculationsAndPlotPath();

uiH = struct();

% Controllers
uiH.theta = uicontrol('Parent',f1,'Style','slider','Position',[100,40,419,23],...
              'value',data.theta, 'min',-179.99, 'max',180,'SliderStep',[0.0007 0.10]);
uiH.theta.Callback = @(es,ed) rotateDataCallback(es,ed);

uiH.index_first = uicontrol('Parent',f1,'Style','slider','Position',[100,20,419,23],...
              'value',data.index_first, 'min',1, 'max',length(data.orig_x),'SliderStep',[0.0007 0.10]);
uiH.index_first.Callback = @(es,ed) clipDataFirst(es,ed);

uiH.index_last = uicontrol('Parent',f1,'Style','slider','Position',[100,0,419,23],...
              'value',data.index_last, 'min',1, 'max',length(data.orig_x),'SliderStep',[0.0009 0.10]);
uiH.index_last.Callback = @(es,ed) clipDataLast(es,ed);

uiH.saveUi = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,60,60,23],...
              'String','Save');
uiH.saveUi.Callback = @(es,ed) saveDataCB(es,ed);

uiH.y_shift = uicontrol('Parent',f1,'Style','slider','Position',[100,60,419,23],...
              'value',data.y_shift, 'min',0, 'max',2,'SliderStep',[0.005 0.10]);
uiH.y_shift.Callback = @(es,ed) shiftY(es,ed);

uiH.x_shift = uicontrol('Parent',f1,'Style','slider','Position',[100,80,419,23],...
              'value',data.x_shift, 'min',-3, 'max',3,'SliderStep',[0.0015 0.02]);
uiH.x_shift.Callback = @(es,ed) shiftX(es,ed);

uiH.flattenData = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,330,70,23],...
              'String','Flatten Data');
uiH.flattenData.Callback = @(es,ed) flattenData(es,ed,ax);

uiH.nextTest = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,230,70,23],...
              'String','Next Test -->');
uiH.nextTest.Callback = @(es,ed) nextTestCB(es,ed);

uiH.nextTest = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,180,170,23],...
              'String','Next Test (Save and Load)-->');
uiH.nextTest.Callback = @(es,ed) nextTestSaveAndLoadCB(es,ed);


uiH.load = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,80,60,23],...
              'String','Load');
uiH.load.Callback = @(es,ed) loadDataCB(es,ed);

% Labels
uiH.shiftX_label = uicontrol('Parent',f1,'Style','text','Position',[40,80,50,23],...
              'String','x_shift');

uiH.shiftY_label = uicontrol('Parent',f1,'Style','text','Position',[40,60,50,23],...
              'String','y_shift');
          
uiH.rotate_label = uicontrol('Parent',f1,'Style','text','Position',[40,40,50,23],...
              'String','rotate');
          
uiH.clipDataFirst_label = uicontrol('Parent',f1,'Style','text','Position',[35,20,60,23],...
              'String','clipBegin');
          
uiH.clipDataLast_label = uicontrol('Parent',f1,'Style','text','Position',[35,0,60,23],...
              'String','clipEnd');
          
end

function nextTestSaveAndLoadCB(es,ed)

saveData();
nextTest();
loadData();

end

function loadData()
global f1 dropboxPath

d = guidata(f1);

loadFrom = strcat(dropboxPath,'processedData/',d.saveAs);
try
loadedData = load(loadFrom);
catch
    warning('no data exists yet for this trial');
    return;
end  
%% TODO update uicontrol

d.index_first = loadedData.index_first;
d.index_last = loadedData.index_last;
d.x_shift = loadedData.x_shift;
d.y_shift = loadedData.y_shift;
d.theta = loadedData.theta;
guidata(f1, d);

updateUI();

calculationsAndPlotPath();

end

function loadDataCB(es,ed)

loadData();
  
end

function updateUI()

global f1 uiH

d = guidata(f1);

set(uiH.index_first,'max',length(d.x))
set(uiH.index_last,'max',length(d.x))
set(uiH.index_first, 'value', d.index_first);
set(uiH.index_last, 'value', d.index_last);
set(uiH.y_shift, 'value', d.y_shift);
set(uiH.x_shift, 'value', d.x_shift);
set(uiH.theta, 'value', (d.theta));

end

function saveData()
global dropboxPath f1

data = guidata(f1);

saveAs = strcat(dropboxPath,'processedData/',data.saveAs);
save(saveAs,'-struct','data');

end

function saveDataCB(es,ed)

saveData();

end

function [distance] = calculateDistance(x,y)

distance = 0;

for i=2:length(x)
    addDistance = sqrt((x(i)-x(i-1))^2+(y(i)-y(i-1))^2);
    distance = distance + addDistance;
end

end

% function chooseMaze(es,ax)
%     data = guidata(es);
%     mazeNum = es.Value - 1;
%     data{12} = mazeNum;
%     guidata(es, data);
% 
%     plotPath();
% end

function flattenData(es,ax,f1)
% NOT TESTED YET
    data = guidata(es);
    x = data.x;
    y = data.y;
    z = data.z;
    index_first = data.index_first;
    index_last = data.index_last;

    syms b g;

    rotateY(b) = [cos(b) 0 sin(b); 0 1 0; -sin(b) 0 cos(b)];
    rotateX(g) = [1 0 0; 0 cos(g) -sin(g); 0 sin(g) cos(g)];

    sf = fit([x(index_first:index_last) y(index_first:index_last)],z(index_first:index_last),'poly11');

    yAngle = -atan(sf.p10);

    xAngle = -atan(sf.p01);

    points = [x';y';z'];
    
    double(rotateY(yAngle)*rotateX(xAngle))

    newPoints = double(rotateY(yAngle)*rotateX(xAngle))*points;

    nx = newPoints(1,:)';
    ny = newPoints(2,:)';
    nz = newPoints(3,:)';
    
    data.x = nx;
    data.y = ny;
    data.z = nz;
    
    guidata(es, data);
        
    calculationsAndPlotPath();

end
function [xrot,yrot] = rotateData(xorig,yorig,thetaRad)

%angle input in radian

r = [cos(thetaRad) sin(thetaRad); -sin(thetaRad) cos(thetaRad)];
points = [xorig yorig];
newpoints = (r*points')';
xrot = newpoints(:,1);
yrot = newpoints(:,2);

end

function rotateDataCallback(es,ed)

data = guidata(es);

data.theta = es.Value;

guidata(es, data);

calculationsAndPlotPath();

end

function clipDataFirst(es,ed)

d = guidata(es);
d.index_first = floor(es.Value);

d.x = d.x - d.x(d.index_first);
d.y = d.y - d.y(d.index_first);

guidata(es,d);

calculationsAndPlotPath();

end

function clipDataLast(es,ed)

d = guidata(es);
d.index_last = floor(es.Value);
guidata(es,d);

calculationsAndPlotPath();

end

function shiftY(es,ed)

d = guidata(es);
d.y_shift = es.Value;
guidata(es,d);

calculationsAndPlotPath();

end

function shiftX(es,ed)

d = guidata(es);
d.x_shift = es.Value;

guidata(es,d);

calculationsAndPlotPath();

end

function calculationsAndPlotPath()
global f1 sp1 sp2

%first redo calculations
d = guidata(f1);
d.distance = calculateDistance(d.x(d.index_first:d.index_last),d.y(d.index_first:d.index_last));
d.total_time = (d.time(d.index_last) - d.time(d.index_first))/1000;
d.ave_velocity = d.distance/d.total_time;

xorig = d.orig_x;
yorig = d.orig_y;
%translate the 'index_first' point to the origin
%so that rotation occurs around the index_first point
xNotRotated = xorig - xorig(d.index_first); 
yNotRotated = yorig - yorig(d.index_first);
%convert degrees to radian:
thetaRad = d.theta*pi/180;
%rotate data
[d.x,d.y] = rotateData(xNotRotated,yNotRotated,thetaRad);

guidata(f1,d);

% now plot
plot(sp2,d.x(d.index_first:d.index_last)+d.x_shift,d.y(d.index_first:d.index_last)+d.y_shift,'LineWidth',2.5,'Color','b');
hold on
if d.mazeOrBox == 0
    plot_maze(f1,d.mazeNum);
else
    plot_box(f1,d.mazeNum);
end
%axis([-3 2.5 0.5 6])

hold off;

plot(sp1,d.z(d.index_first:d.index_last));

title(sprintf('degrees = %.3f | first index = %d | last index = %d | x shift = %0.3f | y shift = %0.3f \n time = %0.3f | distance = %0.3f | mazeNum = %d \n userNum = %02d testNum = %03d \n saveAs = %s', ...
    d.theta,d.index_first,d.index_last,d.x_shift,d.y_shift,d.total_time,d.distance,d.mazeNum,d.userNum,d.testNum,d.saveAs));

end


function nextTest()
global numTests numUsers f1

d = guidata(f1);

if d.testNum < numTests
    testNumNext = d.testNum +1;
    userNumNext = d.userNum;
elseif d.userNum < numUsers
    userNumNext = d.userNum +1;
    testNumNext = d.testNum;
else
    return;    
end

data = processNextTrial(userNumNext,testNumNext);

%store data into the gui
guidata(f1, data);

updateUI();

%plot the path
calculationsAndPlotPath();

end

function nextTestCB(es,ed)

nextTest();

end

function data = processNextTrial(userNum,testNum)
global tests mazeCol testNameCol userFolderCol numUsers numTests dropboxPath uiH

foundTest = 0;
for i=userNum:numUsers
    
    for j=testNum:numTests
        %check that the test is a maze or a box
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
                path = strcat(dropboxPath,userFolder,testName,'/vio_rgb/');
                foundTest = 1;
                userNum = i;
                testNum = j;
                break;
            end
        end
    end
    if foundTest
        % so leave the outer for loop
        break;
    else
        % iterate through the next user
        testNum = 1;
    end
end

fileString = ls(path);

files = sort(strsplit(fileString,{'\t','\n','\0'},'CollapseDelimiters',true));

x = [];
y = [];
z = [];
t = [];

for i=3:length(files)
    fileString = strcat(path, files{i});
    if i == 3
        file = dlmread(fileString,',',3,0);
        tinit = file(1,11);
    else
        file = dlmread(fileString);
    end
    
    x = [x; file(:,1)];
    y = [y; file(:,2)];
    z = [z; file(:,3)];
    t = [t; file(:,11)-tinit];
end

% Initialize some values
x = x - x(1);
y = y - y(1);

index_first = 1;
index_last = length(x);

y_shift = 0;
x_shift = 0;
mazeNum = str2double(maze(3));

% plot(sp1,z);
% plot(sp2,x,y,'LineWidth',2.5,'Color','b');

testRun = tests{userNum,testNum,1};
id = tests{userNum,testNum,4};
user = tests{userNum,testNum,5};
subj = tests{userNum,testNum,6};
device = tests{userNum,testNum,7};
maze = tests{userNum,testNum,8};
saveAs = strcat(id,' user',user,{' '},subj,{' '},testRun,{' '},device,{' '},maze,'.mat');
saveAs = saveAs{1};

data =struct();

data.x = x; % these are intended to store the ROTATED and TRANSLATED x, y data
data.y = y;
data.index_first = index_first;
data.index_last = index_last;
data.orig_x = x; % these are intended to store the ORIGINAL x, y data
data.orig_y = y;
data.theta = 0;
data.time = t;
data.y_shift = y_shift;
data.x_shift = x_shift;
data.saveAs = saveAs;
data.mazeNum = mazeNum;
data.z = z;
data.orig_z = z; % stores the ORIGINAL z data
data.userNum = userNum;
data.testNum = testNum;
data.mazeOrBox = mazeOrBox;
% data.distance = distance;
% data.total_time = total_time;
% data.ave_velocity = ave_velocity;

end