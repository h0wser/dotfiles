#!/bin/bash

scrot -o -f /tmp/screendump.jpg
convert /tmp/screendump.jpg -blur 0x4 /tmp/lockscreen.jpg
feh --fullscreen -g 4000x2560 --no-xinerama -s /tmp/lockscreen.jpg &
FEHPID=$!
xtrlock
kill -15 $FEHPID

