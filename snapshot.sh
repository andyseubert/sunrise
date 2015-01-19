#! /bin/bash

# this will get run from crontab each day 

LIGHTTPD="/var/www/"
# make a folder with today's date in the lighttpd root dir
DATE=$(date +"%Y-%m-%d_%H%M")

# set that as destination for snapshots
DEST=$LIGHTTPD$(date +"%Y-%m-%d")
mkdir $DEST

# take snapshots once per minute for one hour
# name them with the time taken

raspistill -tl 60000 -t 7200000 -o $DEST/sunrise_%04d.jpg

# use ffmpeg to make a video
# store it in the root of the lighttpd directory
ffmpeg -r 12 -i $DEST/sunrise_%04d.jpg -sameq -s hd720 -vcodec libx264 -crf 25 $LIGHTTPD$DATE.MP4

## make an html page to contain the videos
IP=$(/sbin/ifconfig | grep "inet addr" | grep -v 127.0.0.1|cut -d ":" -f 2 | cut -d " " -f 1)
BODY="http://$IP/$DATE"
echo "$BODY" | mail -s "new sunrise ready" andys\@florapdx.com
