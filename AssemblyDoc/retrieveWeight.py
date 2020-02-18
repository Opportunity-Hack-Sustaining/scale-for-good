#! /usr/bin/python2

import time
import sys
import RPi.GPIO as GPIO
import statistics
from hx711 import HX711


referenceUnit = 1

def cleanAndExit():
    print("Cleaning...")

    GPIO.cleanup()
        
    print("Bye!")
    sys.exit()

#Truncates longs to 2 decimal points
def truncate(n, decimals=0):
    multiplier = 10 ** decimals
    return int(n * multiplier) / multiplier

#given an array returns the trimmed mean
def calcWeights(weightsArray):
    trimmed = []
    sdev = statistics.stdev(weightsArray)
    mean = statistics.mean(weightsArray)
    trimVal1 = truncate(mean - sdev, 2)
    trimVal2 = truncate(mean + sdev, 2)
    for x in weightsArray:
        if(x<trimVal1 or x>trimVal2):
            trimmed.append(x)
    for x in trimmed:
        weightsArray.remove(x)

    avgWeight = statistics.mean(weightsArray)
    return avgWeight

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
        val = max(0, int(hx.get_weight(1)))
        if len(valArray) != 19:
        	valArray.append(val)
        else:
        	sentWeight = calcWeights(valArray)
        	print("Sent Weight is: ",sentWeight)
        	valArray = []
        print("Read weight: ",val)

        hx.power_down()
        hx.power_up()
        time.sleep(0.1)

    except (KeyboardInterrupt, SystemExit):
        cleanAndExit()
