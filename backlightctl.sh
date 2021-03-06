#!/usr/bin/env bash

# AUTHOR:		Trevor Bautista
# CREATED:		23 May 2018
# LAST UPDATED:	4 June 2018
# VERSION:		0.1
# DESCRIPTION:
# 	This script is used to adjust screen brightness 
# 	using native Linux files; indended for the
# 	Lenovo Thinkpad x220t
###############################################################

INTERVAL=4


BASEDIR="/sys/class/backlight"
DEVICE=$(ls $BASEDIR)
BASEDIR="$BASEDIR/$DEVICE"


#current brightness
OLD_BRIGHTNESS=$(cat $BASEDIR/brightness)

#max brightness
MAX_BRIGHTNESS=$(cat $BASEDIR/max_brightness)

#current prightness percentage
OLD_BRIGHTNESS_PERCENT=$(( 100 * $OLD_BRIGHTNESS / $MAX_BRIGHTNESS ))



case $1 in
	"up")
		#calculate new brightness
		NEW_BRIGHTNESS_PERCENT=$(( $OLD_BRIGHTNESS_PERCENT +$INTERVAL ))
		NEW_BRIGHTNESS=$(( $MAX_BRIGHTNESS * $NEW_BRIGHTNESS_PERCENT / 100 ))

		#set brightness
		echo $NEW_BRIGHTNESS | tee $BASEDIR/brightness
		;;
	
	"down")

		#calculate new brightness
		NEW_BRIGHTNESS_PERCENT=$(( $OLD_BRIGHTNESS_PERCENT -$INTERVAL ))
		NEW_BRIGHTNESS=$(( $MAX_BRIGHTNESS * $NEW_BRIGHTNESS_PERCENT / 100 ))

		#set brightness
		echo $NEW_BRIGHTNESS | tee  $BASEDIR/brightness
		;;
	*)
		echo "Please specify either 'up' or 'down'."
		;;
esac

