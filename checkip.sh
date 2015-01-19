#!/bin/bash

LOCALIPFILE="/usr/local/sunrise/localip"
REPORTTO="andys@florapdx.com"

# check local ip address
CURRENTIP=$(/sbin/ifconfig | grep "inet addr" | grep -v 127.0.0.1 | awk {'print $2'})
#echo "$CURRENTIP"

# if old ip was recorded earlier then
if [ -f $LOCALIPFILE ]
then 
	OLDIP=$(<$LOCALIPFILE)
	#echo "$OLDIP"
	if [ "$CURRENTIP" != "$OLDIP" ]
	then
		echo "new $CURRENTIP" | mail -s "$(hostname) local addr changed" $REPORTTO
		echo "$CURRENTIP" > $LOCALIPFILE
	fi
else
	echo "$CURRENTIP" > $LOCALIPFILE
	echo "new $CURRENTIP" | mail -s "$(hostname) local addr changed" $REPORTTO

fi

## check my public ip address

PUBIPADDRFILE="/usr/local/sunrise/publicip"
PUBIP=$(/usr/bin/wget http://ifconfig.me/ip -O - -q)
# if old ip was recorded earlier then
if [ -f $PUBIPADDRFILE ]
then
	OLDIP=$(<$PUBIPADDRFILE)
	echo "previous public ip addr: $OLDIP"
	if [ "$PUBIP" != "$OLDIP" ]
	then
		echo "new public addr: $PUBIP" | mail -s "$(hostname) public ip changed" $REPORTTO
		echo "$PUBIP" > $PUBIPADDRFILE
	fi
else
	echo "$PUBIP" > $PUBIPADDRFILE
	echo "new public addr: $PUBIP" | mail -s "$(hostname) public ip changed" $REPORTTO
fi


exit 0