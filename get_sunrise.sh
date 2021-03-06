#!/bin/bash


DOM=$(date +"%-d")
MON=$(date +"%-m")
YEAR=$(date +"%Y")

wget -O sr.html "http://aa.usno.navy.mil/rstt/onedaytable?form=1&ID=AA&year=$YEAR&month=$MON&day=$DOM&state=OR&place=portland"
cp sr.html /var/www/

SUNUP=$(grep Sunrise sr.html | cut -d">" -f5 | cut -d"<" -f1 | cut -d " " -f 1) # > sunrisetime
# get the hour and minute
# subtract one from the hour
H=$(echo $SUNUP | cut -d ":" -f 1)
let "H=$H-1"

M=$(echo $SUNUP | cut -d ":" -f 2)

RUNTIME="$H:$M AM"

## schedule the job
at $RUNTIME -f /usr/local/sunrise/snapshot.sh 

MOONIMG=$(grep image sr.html |cut -d "<" -f 3 | cut -d ">" -f 1 )
IFS=$'\n' read -d '' -r -a LINK <<< "$MOONIMG"
HREF=$(echo $MOONIMG | cut -d "\"" -f 2)
MOONPHASE="<a href="$HREF"<"$LINK" /></a>"

echo "$HREF" | mail -s "moon phase" andys\@florapdx.com
