function plot_maze(f1,num)

height = 1.23*5;
width = 1.23*5;
h = height/5; 
w = width/5;

grid = {};

for i=1:6
    for j=1:6
        grid{i,j} = [(i-1)*w - width/2 (j-1)*h];
    end
end

figure(f1)

hold on

if num == 0
    return;
elseif num == 1
    line([grid{3,1}(1) grid{3,3}(1)],[grid{3,1}(2) grid{3,3}(2)],'LineWidth',4,'Color','black')
    line([grid{4,1}(1) grid{4,4}(1)],[grid{4,1}(2) grid{4,4}(2)],'LineWidth',4,'Color','black')
    line([grid{3,3}(1) grid{1,3}(1)],[grid{3,3}(2) grid{1,3}(2)],'LineWidth',4,'Color','black')
    line([grid{1,3}(1) grid{1,6}(1)],[grid{1,3}(2) grid{1,6}(2)],'LineWidth',4,'Color','black')
    line([grid{4,4}(1) grid{2,4}(1)],[grid{4,4}(2) grid{2,4}(2)],'LineWidth',4,'Color','black')
    line([grid{2,4}(1) grid{2,5}(1)],[grid{2,4}(2) grid{2,5}(2)],'LineWidth',4,'Color','black')
    line([grid{2,5}(1) grid{6,5}(1)],[grid{2,5}(2) grid{6,5}(2)],'LineWidth',4,'Color','black')
    line([grid{1,6}(1) grid{6,6}(1)],[grid{1,6}(2) grid{6,6}(2)],'LineWidth',4,'Color','black')
elseif num == 2
    line([grid{1,1}(1) grid{1,4}(1)],[grid{1,1}(2) grid{1,4}(2)],'LineWidth',4,'Color','black')
    line([grid{1,4}(1) grid{3,4}(1)],[grid{1,4}(2) grid{3,4}(2)],'LineWidth',4,'Color','black')
    line([grid{3,4}(1) grid{3,6}(1)],[grid{3,4}(2) grid{3,6}(2)],'LineWidth',4,'Color','black')
    line([grid{3,6}(1) grid{6,6}(1)],[grid{3,6}(2) grid{6,6}(2)],'LineWidth',4,'Color','black')
    line([grid{2,1}(1) grid{2,3}(1)],[grid{2,1}(2) grid{2,3}(2)],'LineWidth',4,'Color','black')
    line([grid{2,3}(1) grid{4,3}(1)],[grid{2,3}(2) grid{4,3}(2)],'LineWidth',4,'Color','black')
    line([grid{4,3}(1) grid{4,5}(1)],[grid{4,3}(2) grid{4,5}(2)],'LineWidth',4,'Color','black')
    line([grid{4,5}(1) grid{6,5}(1)],[grid{4,5}(2) grid{6,5}(2)],'LineWidth',4,'Color','black')
elseif num == 3
    line([grid{1,1}(1) grid{1,6}(1)],[grid{1,1}(2) grid{1,6}(2)],'LineWidth',4,'Color','black')
    line([grid{1,6}(1) grid{4,6}(1)],[grid{1,6}(2) grid{4,6}(2)],'LineWidth',4,'Color','black')
    line([grid{4,6}(1) grid{4,4}(1)],[grid{4,6}(2) grid{4,4}(2)],'LineWidth',4,'Color','black')
    line([grid{4,4}(1) grid{6,4}(1)],[grid{4,4}(2) grid{6,4}(2)],'LineWidth',4,'Color','black')
    line([grid{6,4}(1) grid{6,1}(1)],[grid{6,4}(2) grid{6,1}(2)],'LineWidth',4,'Color','black')
    line([grid{2,1}(1) grid{2,5}(1)],[grid{2,1}(2) grid{2,5}(2)],'LineWidth',4,'Color','black')
    line([grid{2,5}(1) grid{3,5}(1)],[grid{2,5}(2) grid{3,5}(2)],'LineWidth',4,'Color','black')
    line([grid{3,5}(1) grid{3,3}(1)],[grid{3,5}(2) grid{3,3}(2)],'LineWidth',4,'Color','black')
    line([grid{3,3}(1) grid{5,3}(1)],[grid{3,3}(2) grid{5,3}(2)],'LineWidth',4,'Color','black')
    line([grid{5,3}(1) grid{5,1}(1)],[grid{5,3}(2) grid{5,1}(2)],'LineWidth',4,'Color','black')
elseif num == 4
    line([grid{1,1}(1) grid{6,1}(1)],[grid{1,1}(2) grid{6,1}(2)],'LineWidth',4,'Color','black')
    line([grid{6,1}(1) grid{6,4}(1)],[grid{6,1}(2) grid{6,4}(2)],'LineWidth',4,'Color','black')
    line([grid{6,4}(1) grid{2,4}(1)],[grid{6,4}(2) grid{2,4}(2)],'LineWidth',4,'Color','black')
    line([grid{2,4}(1) grid{2,5}(1)],[grid{2,4}(2) grid{2,5}(2)],'LineWidth',4,'Color','black')
    line([grid{2,5}(1) grid{6,5}(1)],[grid{2,5}(2) grid{6,5}(2)],'LineWidth',4,'Color','black')
    line([grid{1,2}(1) grid{5,2}(1)],[grid{1,2}(2) grid{5,2}(2)],'LineWidth',4,'Color','black')
    line([grid{5,2}(1) grid{5,3}(1)],[grid{5,2}(2) grid{5,3}(2)],'LineWidth',4,'Color','black')
    line([grid{5,3}(1) grid{1,3}(1)],[grid{5,3}(2) grid{1,3}(2)],'LineWidth',4,'Color','black')
    line([grid{1,3}(1) grid{1,6}(1)],[grid{1,3}(2) grid{1,6}(2)],'LineWidth',4,'Color','black')
    line([grid{1,6}(1) grid{6,6}(1)],[grid{1,6}(2) grid{6,6}(2)],'LineWidth',4,'Color','black')
end

hold off

%     line([0.5 0.5],[0,2.5],'LineWidth',4,'Color','black')
%     line([0.5 -1.75],[2.5,2.5],'LineWidth',4,'Color','black')
%     line([-1.75,-1.75],[2.5,3.75],'LineWidth',4,'Color','black')
%     line([-1.75,1.75],[3.75,3.75],'LineWidth',4,'Color','black')
%     line([-.5,-.5],[0,1.5],'LineWidth',4,'Color','black')
%     line([-.5,-2.75],[1.5,1.5],'LineWidth',4,'Color','black')
%     line([-2.75,-2.75],[1.5,4.75],'LineWidth',4,'Color','black')
%     line([-2.75,1.75],[4.75,4.75],'LineWidth',4,'Color','black')

end