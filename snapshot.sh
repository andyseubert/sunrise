#! /bin/bash

# check if it's sunrise now
# if not exit
LIGHTTPD="/var/www/"
# make a folder with today's date in the lighttpd root dir
DATE=$(date +"%Y-%m-%d_%H%M")

# set that as destination for snapshots
DEST=$LIGHTTPD$(date +"%Y-%m-%d")
mkdir $DEST

# take snapshots once per minute for one hour
# name them with the time taken

raspistill -tl 60000 -t 7200000 -o $DEST/sunrise_%04d.jpg

