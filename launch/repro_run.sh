#! /bin/bash

taskset -c 1 chrt --fifo 1 rosrun latched_singlecore repro&
NAV_PID=$@

cr=`echo $'\n.'`
cr=${cr%.}
read -p "Press enter to kill $cr"
echo -n "Killing..."
pkill -9 repro
echo "Killed"
