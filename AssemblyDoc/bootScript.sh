#!/bin/sh

sleep 15

sudo lxterminal -e python /home/pi/Documents/scaleForGood/AssemblyDoc/readWeight.py &
sudo lxterminal -e node /home/pi/Documents/scaleForGood/AssemblyDoc/bleno/script.js &
#sudo node /home/pi/Documents/scaleForGood/AssemblyDoc/bleno/script.js
