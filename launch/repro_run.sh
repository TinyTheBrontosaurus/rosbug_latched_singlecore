#! /bin/bash

# taskset limits to one core
# chrt sets priority to FIFO
taskset -c 1 chrt --fifo 1 rosrun latched_singlecore repro&

# Make it easy to kill this, as it will take up 100% of one core
cr=`echo $'\n.'`
cr=${cr%.}
read -p "Press enter to kill $cr"
echo -n "Killing..."
pkill -9 repro
echo "Killed"
