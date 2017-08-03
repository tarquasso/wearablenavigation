clear all
close all

% dropbox folder location
% FILL IN YOUR computer username here:
editorNames = {'rkk', 'brandonaraki', 'santaniteng'};

dropboxPathOptions = {'~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/',...
    '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/',...
    '/Users/santaniteng/Downloads/'};

osUserName = char(java.lang.System.getProperty('user.name'));

for k = 1:length(editorNames)
    curName = editorNames{k};
  if strcmp (osUserName,curName)
      dropboxPath = dropboxPathOptions{k};
  end
end

fileOutCompiledData = 'data-analysis-blind-users-20160524_with_tango_compiled_170731.mat';
matFileToOpen = strcat(dropboxPath,fileOutCompiledData);
load(matFileToOpen);

duraBelt = zeros(12,4);
duraCane = zeros(12,4);
contactsBelt = zeros(12,4);
contactsCane = zeros(12,4);
distBelt = zeros(11,4);
distCane = zeros(11,4);

for ii = 1:3
duraBelt(:,ii) = dc.belt.maze{ii}.durationTango.raw;
duraCane(:,ii) = dc.cane.maze{ii}.durationTango.raw;
contactsBelt(:,ii) = dc.belt.maze{ii}.majorColl.raw;
contactsCane(:,ii) = dc.cane.maze{ii}.wallTaps.raw;
withTango = ~(dc.belt.maze{ii}.user == 7);
distBelt(:,ii) = dc.belt.maze{ii}.distance.raw(withTango);
withTango = ~(dc.cane.maze{ii}.user == 7);
distCane(:,ii) = dc.cane.maze{ii}.distance.raw(withTango);
end

ii = 4;
duraBelt(:,ii) = [NaN;dc.belt.maze{ii}.durationTango.raw];
duraCane(:,ii) = [NaN;dc.cane.maze{ii}.durationTango.raw];

contactsBelt(:,ii) = [NaN;dc.belt.maze{ii}.majorColl.raw];
contactsCane(:,ii) = [NaN;dc.cane.maze{ii}.wallTaps.raw];
withTango = ~(dc.belt.maze{ii}.user == 7);
distBelt(:,ii) = [NaN;dc.belt.maze{ii}.distance.raw(withTango)];
withTango = ~(dc.cane.maze{ii}.user == 7);
distCane(:,ii) = [NaN;dc.cane.maze{ii}.distance.raw(withTango)];