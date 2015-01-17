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

raspistill -vf -hf -o $DEST/$DATE.jpg
