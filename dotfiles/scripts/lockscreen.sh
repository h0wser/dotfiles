#!/bin/bash

scrot -o -f /tmp/screendump.png
convert /tmp/screendump.png -blur 0x4 /tmp/lockscreen.png
feh --fullscreen -g 4000x2560 --no-xinerama -s /tmp/lockscreen.png &
FEHPID=$!
xtrlock
kill -15 $FEHPID

