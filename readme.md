
requires 
 - checkip.pl
 - bootalert.py
 - sendsms.py
 - send email relay through gmail
  apt-get install ssmtp -y
 vi /etc/ssmtp/ssmtp.conf
 http://rpi.tnet.com/project/faqs/smtp
 
 - lighttpd
 - git
 - raspi-config
 - ffmpeg http://notes.theorbis.net/2010/05/creating-time-lapse-with-ffmpeg.html
 - disable camera LED
echo  "disable_camera_led=1" >> /boot/config.txt

- determine sunrise/sunset from shell script  - run from crontab every day at 1 am
get_sunrise.sh
crontab -l > /usr/local/sunrise/rawcron.file 

- capture every minute or two from 30 minutes before to 30 minutes after sunrise and sunset
snapshot.sh
raspistill -tl 60000 -t 3600000 -o $DEST/sunrise_%04d.jpg


 - store in date folders
- ffmpeg? change stills into movies 
http://notes.theorbis.net/2010/05/creating-time-lapse-with-ffmpeg.html

ffmpeg -r 12 -i test_%04d.jpg -sameq -s hd720 -vcodec libx264 -crf 25 $LIGHTTPD$DATE.MP4


- upload to owncloud or some such, and send links via email or post links to blog or twitter automatically