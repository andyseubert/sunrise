#!/bin/bash

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
#ffmpeg -i $DEST/sunrise_%04d.jpg -r 10 -vcodec libx264 -crf 25 $LIGHTTPD$DATE.MP4
ffmpeg -r 10 -f image2 -i $DEST/sunrise_%04d.jpg -vcodec mjpeg -qscale 1 -pix_fmt yuv420p $LIGHTTPD$DATE.avi

## make an html page to contain the videos
IP=$(/sbin/ifconfig | grep "inet addr" | grep -v 127.0.0.1|cut -d ":" -f 2 | cut -d " " -f 1)
BODY="http://$IP/$DATE"
echo "$BODY" | mail -s "new sunrise ready" andys\@florapdx.com

## scp the file 
HOST="floraportland.com"
DST="public_html/mythingonthe/"
echo "<a href=$DATE>$DATE</a>" >> index.html
scp -i /home/andys/.ssh/tunnel-id $LIGHTTPD$DATE.avi florapor@floraportland.com:$DST
scp -i /home/andys/.ssh/tunnel-id index.html florapor@floraportland.com:$DST
echo "http://mythingonthe.net/$DATE.avi" | mail -s "new sunrise video link ready" andys\@florapdx.com

