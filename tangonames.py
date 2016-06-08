import subprocess
import re
import os
import csv
from fnmatch import fnmatch

def getLength(filename):
  result = subprocess.Popen(["ffprobe", filename],
    stdout = subprocess.PIPE, stderr = subprocess.STDOUT)
  stdout, stderr = result.communicate()
  matches = re.search(r"Duration:\s{1}(?P<hours>\d+?):(?P<minutes>\d+?):(?P<seconds>\d+?).(?P<milliseconds>\d+?),", stdout, re.DOTALL).groupdict()
  #print matches['hours']
  #print matches['minutes']
  return (matches['hours'],matches['minutes'],matches['seconds'],matches['milliseconds'])
  #return [x for x in result.stdout.readlines() if "Duration" in x]

root = '/Users/rkk/Dropbox (MIT)/Robotics Research/Haptic Devices/Experiments/study may 2016'
pattern = "tango"

with open ('tango.csv', 'wb') as csvfile:
  datawriter = csv.writer(csvfile, delimiter=',')
  datawriter.writerow(['path','foldername'])
  for path, subdirs, files in os.walk(root):
    for name in subdirs:
      if fnmatch(name, pattern):
        subdirfilename = os.path.join(path, name)
	for deepersubdirs in os.walk(subdirfilename).next()[1]:
	  datawriter.writerow([path,deepersubdirs])
