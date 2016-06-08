function process_tango_data(userName,testName,pathToTest)

path = strcat(pathToTest,userName,'/tango/',testName,'/');

fileString = ls(path);

testPath = strcat(pathToTest,userName,'/tango/');
testString = ls(testPath);
testFiles = sort(strsplit(testString,{'\t','\n','\0'},'CollapseDelimiters',true))

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
plot_maze(f1,1);
theta = 0;
index_first = 1;
index_last = length(x);
y_shift = 0;
x_shift = 0;
saveName = 'test';
mazeNum = 1;

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

guidata(f1, data);

b1 = uicontrol('Parent',f1,'Style','slider','Position',[100,40,419,23],...
              'value',theta, 'min',-30, 'max',30,'SliderStep',[0.005 0.10]);
b1.Callback = @(es,ed) rotateData(es,ed,ax,f1);

b2 = uicontrol('Parent',f1,'Style','slider','Position',[100,20,419,23],...
              'value',index_first, 'min',1, 'max',200,'SliderStep',[0.005 0.10]);
b2.Callback = @(es,ed) clipDataFirst(es,ed,ax,f1);

b3 = uicontrol('Parent',f1,'Style','slider','Position',[100,0,419,23],...
              'value',index_last, 'min',length(x)-200, 'max',length(x),'SliderStep',[0.005 0.10]);
b3.Callback = @(es,ed) clipDataLast(es,ed,ax,f1);

b4 = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,60,60,23],...
              'String','Save');
b4.Callback = @(es,ed) saveData(es,ed,ax);

b5 = uicontrol('Parent',f1,'Style','slider','Position',[100,60,419,23],...
              'value',y_shift, 'min',0, 'max',1,'SliderStep',[0.01 0.10]);
b5.Callback = @(es,ed) shiftY(es,ed,ax,f1);

b6 = uicontrol('Parent',f1,'Style','slider','Position',[100,80,419,23],...
              'value',x_shift, 'min',-2.5, 'max',2.5,'SliderStep',[0.002 0.02]);
b6.Callback = @(es,ed) shiftX(es,ed,ax,f1);

b7 = uicontrol('Parent',f1,'Style','edit','Position',[545,90,70,30],...
              'String',saveName);
b7.Callback = @(es,ed) saveNameCallback(es,ed,ax);

b8 = uicontrol('Parent',f1,'Style','popup','Position',[525,160,100,30],...
              'String',{'no maze','maze 1','maze 2','maze 3','maze 4'});
b8.Callback = @(es,ed) chooseMaze(es,ed,ax,f1);

b9 = uicontrol('Parent',f1,'Style','pushbutton','Position',[550,330,70,23],...
              'String','Flatten Data');
b9.Callback = @(es,ed) flattenData(es,ed,ax,f1);

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
          
saveName_label = uicontrol('Parent',f1,'Style','text','Position',[545,120,60,23],...
              'String','Save As:');
          
chooseMaze_label = uicontrol('Parent',f1,'Style','text','Position',[525,200,100,23],...
              'String','Choose Maze');
          
end

function saveData(es,ed,ax)

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

distance = findDistance(x(index_first:index_last),y(index_first:index_last));
total_time = (time(index_last) - time(index_first))/1000;
ave_velocity = distance/total_time;

save(saveName,'x','y','orig_x','orig_y','time','index_first','index_last','theta','total_time','y_shift','x_shift','distance','ave_velocity','mazeNum','z');

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

    yAngle = atan(sf.p10)

    xAngle = atan(sf.p01)

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
index_last = floor(es.Value);

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

cla(ax);

hold on;

plot(x(index_first:index_last)+x_shift,y(index_first:index_last)+y_shift,'LineWidth',2.5,'Color','b');
plot_maze(f1,mazeNum);
%axis([-3 2.5 0.5 6])

hold off;

set(zplot,'YData',z(index_first:index_last));

distance = findDistance(x(index_first:index_last),y(index_first:index_last));
total_time = (time(index_last) - time(index_first))/1000;
title(sprintf('degrees = %.3f | first index = %d | last index = %d | x shift = %0.3f | y shift = %0.3f | time = %0.3f | distance = %0.3f',theta,index_first,index_last,x_shift,y_shift,total_time,distance));

end