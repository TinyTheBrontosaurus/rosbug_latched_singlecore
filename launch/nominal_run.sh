#! /bin/bash

# Run it, nothing special
rosrun latched_singlecore repro&

# Make it easy to kill this
cr=`echo $'\n.'`
cr=${cr%.}
read -p "Press enter to kill $cr"
echo -n "Killing..."
pkill -9 repro
echo "Killed"
