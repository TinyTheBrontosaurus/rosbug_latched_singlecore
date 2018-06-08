#! /bin/bash

. devel/setup.bash
rosrun latched_singlecore repro&
NAV_PID=$@

read -p "Press any key to kill"
echo -n "Killing..."
pkill -9 repro_live*
echo "Killed"
