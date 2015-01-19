SUNRISE TIMELAPSE CAPTURE
======

 * mostly written in bash.

using the built in camera of raspberry pi, every day get the sunrise time,
start taking photos one hour before sunrise and continue every minute until one hour after sunrise
make those photos into a short movie - 10 seconds long?
send a link to the movie to me or post the movie somewhere

requires 
-------
 * ssmtp
send email relay through gmail http://rpi.tnet.com/project/faqs/smtp
```
apt-get install ssmtp -y
vi /etc/ssmtp/ssmtp.conf
```
 - lighttpd - allow file browsing
 - git
 - raspi-config - enable the camera
 
Setup:
-----
 * in order to know when the raspberry boots up I do this to all my raspberry pis:
   * add to /etc/init.d/rc.local
```
echo "awake" | mail -s "SunriseRaspberry-BootedUpJustNow" 1234567890\@yourtext.yoursms.com >> /var/log/rc.local.log 2>&1
```
   * Add this to check the ip address on boot
```
/usr/local/sunrise/checkip.sh > /var/log/rc.local.log 2>&1
```
   * Add this to send a photo of what it "sees" on boot
```
/usr/local/sunrise/showmenow.sh
```
 * ffmpeg http://notes.theorbis.net/2010/05/creating-time-lapse-with-ffmpeg.html
 * disable camera LED
```
echo  "disable_camera_led=1" >> /boot/config.txt
```
 * determine sunrise/sunset from shell script  - run from crontab every day at 1 am
   * get_sunrise.sh
 * begin before running that script by capturing the existing crontab with this * 
```
crontab -l > /usr/local/sunrise/rawcron.file 
```
  * then get_sunrise.sh will daily replace  one line to the user crontab based on sunrise time of "today"
* capture every minute or two from one hour before to one hour after sunrise and sunset
  * snapshot.sh is essentially running this:
```
raspistill -tl 60000 -t 7200000 -o $DEST/sunrise_%04d.jpg
```
  * store in date folders
  * ffmpeg change stills into movies 
http://notes.theorbis.net/2010/05/creating-time-lapse-with-ffmpeg.html
```
ffmpeg -r 12 -i test_%04d.jpg -sameq -s hd720 -vcodec libx264 -crf 25 $LIGHTTPD$DATE.MP4
```

FILES
----
 * <strong>checkip.sh</strong> run every 30 minutes from cron. email any changes to ip address to me.
 * <strong>get_sunrise.sh</strong> run daily at 1AM from cron. create crontab line to launch snapshots at the right time.
 * <strong>localip</strong> contains local ip address for comparison by checkip.sh
 * <strong>publicip</strong> contains public ip address for comparison by checkip.sh
 * <strong>rawcron.file</strong> contains original unmolested crontab entries. UPDATE THIS IF YOU CHANGE YOUR CRON OUTSIDE OF THIS STUFF
 * <strong>readme.md</strong> this file
 * <strong>showmenow.sh</strong> take a snapshot and email it to me. For troubleshooting. also done on bootup.
 * <strong>snapshot.sh</strong> this does the timelapse "work" - take photos, create movie, notify, email, upload, etc
 * <strong>sr.html</strong> this is the file pulled from NOAA daily which is parsed to get the sunrise time. It also contains a cool image of the phase of the moon!



TODO 
----
 * upload to owncloud or some such, and send links via email or post links to blog or twitter automatically
