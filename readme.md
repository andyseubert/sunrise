Mostly written in bash 
using the built in camera of raspberry pi
every day get the sunrise time
start taking photos one hour before sunrise and continue every minute until one hour after sunrise
make those photos into a short movie - 10 seconds long?
send a link to the movie to me 
or post the movie somewhere

requires 
 * ssmtp
 - send email relay through gmail
  apt-get install ssmtp -y
 vi /etc/ssmtp/ssmtp.conf
 http://rpi.tnet.com/project/faqs/smtp
 - lighttpd
 - git
 - raspi-config - enable the camera
 
Setup:

 - /root/bootalert.py : from other projects, sends ip address to me on boot
 - /root/sendsms.py : from other projects - to text me something.. on boot
 
 
 - ffmpeg http://notes.theorbis.net/2010/05/creating-time-lapse-with-ffmpeg.html
 - disable camera LED
echo  "disable_camera_led=1" >> /boot/config.txt

- determine sunrise/sunset from shell script  - run from crontab every day at 1 am
get_sunrise.sh
crontab -l > /usr/local/sunrise/rawcron.file 

- capture every minute or two from one hour before to one hour after sunrise and sunset
snapshot.sh
raspistill -tl 60000 -t 7200000 -o $DEST/sunrise_%04d.jpg


 - store in date folders
- ffmpeg change stills into movies 
http://notes.theorbis.net/2010/05/creating-time-lapse-with-ffmpeg.html

ffmpeg -r 12 -i test_%04d.jpg -sameq -s hd720 -vcodec libx264 -crf 25 $LIGHTTPD$DATE.MP4


- upload to owncloud or some such, and send links via email or post links to blog or twitter automatically