#! /usr/bin/python2

import time
import sys
import RPi.GPIO as GPIO
from hx711 import HX711

referenceUnit = 1

def cleanAndExit():
    print("Cleaning...")

    GPIO.cleanup()
        
    print("Bye!")
    sys.exit()

hx = HX711(5, 6)

hx.set_reading_format("MSB", "MSB")

# HOW TO CALCULATE THE REFFERENCE UNIT
# To set the reference unit to 1. Put 1kg on your sensor or anything you have and know exactly how much it weights.
# In this case, 92 is 1 gram because, with 1 as a reference unit I got numbers near 0 without any weight
# and I got numbers around 184000 when I added 2kg. So, according to the rule of thirds:
# If 2000 grams is 184000 then 1000 grams is 184000 / 2000 = 92.
#hx.set_reference_unit(113)
#hx.set_reference_unit(referenceUnit)

hx.reset()

hx.tare()

print("Tare done! Add weight now...")

readValues = True
valArray = []

while readValues:
    try:
        # Prints the weight
        val = max(0, int(hx.get_weight(5)))
        if len(valArray) != 20:
        	valArray.append(val)
        else:
        	# takes off edges and averages the middle weights taken
        	valArray = valArray[5:15]
        	sentWeight = sum(valArray) / float(len(valArray))
        	print("Sent Weight is: ",sentWeight)
        	valArray = []
        print("Read weight: ",val)

        hx.power_down()
        hx.power_up()
        time.sleep(0.1)

    except (KeyboardInterrupt, SystemExit):
        cleanAndExit()