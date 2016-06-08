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
pattern = "*.mp4"

with open ('videolengths.csv', 'wb') as csvfile:
  datawriter = csv.writer(csvfile, delimiter=',')
  datawriter.writerow(['path','filename','hours','minutes','seconds','milliseconds','time'])
  for path, subdirs, files in os.walk(root):
    for name in files:
      if fnmatch(name, pattern):
        filename = os.path.join(path, name)
        print name
	duration = getLength(filename)
	print duration
	timeString = str(duration[0])+':'+str(duration[1])+':'+str(duration[2])+'.'+str(duration[3])
	datawriter.writerow([path,name,duration[0],duration[1],duration[2],duration[3], timeString])
