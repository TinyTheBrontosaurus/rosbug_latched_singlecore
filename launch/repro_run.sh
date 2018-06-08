#! /bin/bash

. devel/setup.bash
taskset -c 1 chrt --fifo 1 rosrun latched_singlecore repro&
NAV_PID=$@

read -p "Press any key to kill"
echo -n "Killing..."
pkill -9 repro
echo "Killed"
