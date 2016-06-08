userName = 'user01 - 20160506/paul';

test1 = '20160506144144';
test2 = '20160506154842';

[x1, y1] = tango_data(userName, test1);
[x2, y2] = tango_data(userName, test2);

%figure;plot(x,y);
[new_x,new_y] = rotatePoints(x1,y1,-0.05);
[new_x2,new_y2] = rotatePoints(x2,y2,-0.05);


fid = figure;
%plot(new_x,new_y,'LineWidth',2.5,'Color','b');
axis equal
hold on
%plot(new_x2,new_y2,'LineWidth',2.5,'Color','r');
grid on
% line([0.5 0.5],[-0.5,3.25],'LineWidth',4,'Color','black')
% line([0.5 -2],[3.25,3.25],'LineWidth',4,'Color','black')
% line([-2,-2],[3.25,4.5],'LineWidth',4,'Color','black')
% line([-2,3],[4.5,4.5],'LineWidth',4,'Color','black')
% line([-.5,-.5],[-0.5,2.25],'LineWidth',4,'Color','black')
% line([-.5,-3],[2.25,2.25],'LineWidth',4,'Color','black')
% line([-3,-3],[2.25,5.5],'LineWidth',4,'Color','black')
% line([-3,3],[5.5,5.5],'LineWidth',4,'Color','black')

line([0.5 0.5],[0,2.5],'LineWidth',4,'Color','black')
line([0.5 -1.75],[2.5,2.5],'LineWidth',4,'Color','black')
line([-1.75,-1.75],[2.5,3.75],'LineWidth',4,'Color','black')
line([-1.75,1.75],[3.75,3.75],'LineWidth',4,'Color','black')
line([-.5,-.5],[0,1.5],'LineWidth',4,'Color','black')
line([-.5,-2.75],[1.5,1.5],'LineWidth',4,'Color','black')
line([-2.75,-2.75],[1.5,4.75],'LineWidth',4,'Color','black')
line([-2.75,1.75],[4.75,4.75],'LineWidth',4,'Color','black')
export_fig test.png

writerObj = VideoWriter('out.avi'); % Name it.
writerObj.FrameRate = 60; % How many frames per second.
open(writerObj); 
 
for i=1:max(length(new_y),length(new_y2))     
    % We just use pause but pretend you have some really complicated thing here...
    pause(0.05);
    figure(fid); % Makes sure you use your desired frame.
    if i <= length(new_y)
        plot(new_x(i),new_y(i),'ob','Color','b');
    end
    if i <= length(new_y2)
        plot(new_x2(i),new_y2(i),'or','Color','r');
    end
 
    frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
    writeVideo(writerObj, frame);
 
end
hold off
close(writerObj); % Saves the movie.