#! /bin/bash

wget -O sr.html "http://aa.usno.navy.mil/rstt/onedaytable?form=1&ID=AA&year=2015&month=1&day=10&state=OR&place=portland"

SUNUP=$(grep Sunrise sr.html | cut -d">" -f5 | cut -d"<" -f1 | cut -d " " -f 1) # > sunrisetime
M=$SUNUP | cut -d ":" -f 1
M=$M - 1
H=$SUNUP \ cut -d ":" -f 2
DOM=date +"%d"
MON=date +"%m"

# m h  dom mon dow   command
CRONLINE=$M $H $DOM $MON * /usr/local/sunrise/snapshot.sh