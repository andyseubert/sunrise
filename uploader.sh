#! /bin/bash
#/root/sendsms.py "starting uploader"
#echo "starting upload" | mail -s "starting upload" andys@florapdx.com


mkdir /tmp/sunrises
cd /tmp/sunrises

# get today's avi from the server
wget -nH -rA "$(date +"%Y-%m-%d")*.avi" http://mythingonthe.net
if [ -e $(date +"%Y-%m-%d")*.avi ]
 then echo "exists"
# rename them
for X in $(ls); do
FILE=$(echo $X|cut -d "_" -f 1)
echo "$FILE.avi"
mv $X $FILE.avi
done

## upload to youtube
for X in $(ls); do
TEXT=$(date -d $(echo $X|cut -d "." -f 1) +"%B %d %Y")
/usr/local/bin/youtube-upload -m andys@florapdx.com -p $PASS -t "Portland Oregon sunrise $TEXT" -c "Entertainment" -d "https://github.com/andyseubert/sunrise" $X


else
 echo "boo hoo"
 echo "failed to pull down video for today $(date +"%Y-%m-%d") "| mail -s "failed upload" andys@florapdx.com
fi

cd /root

sleep 90
rm -rf /tmp/sunrises
done
