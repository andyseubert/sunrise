#! /bin/bash

# cd to temp dir
cd /tmp

# get today's avi from the server
wget -nH -rA "$(date +"%Y-%m-%d")*.avi" http://yourthingonthe.net

#get all avis from the server
#wget -nH -rA "*.avi" http://yourthingonthe.net

# rename it or them (the sunrise capture adds hour and minute to the filename)
for X in $(ls); do
FILE=$(echo $X|cut -d "_" -f 1)
echo "$FILE.avi"
mv $X $FILE.avi
done

## upload to youtube
for X in $(ls); do
TEXT=$(date -d $(echo $X|cut -d "." -f 1) +"%B %d %Y")
youtube-upload -m you@you.com -p ********** -t "sunrise $TEXT" -c "Entertainment" $X
sleep 90
rm -f $X
done




