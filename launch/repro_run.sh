#! /bin/bash

. devel/setup.bash
taskset -c 1 chrt --fifo 1 rosrun navigation repro_live_subscribe&
NAV_PID=$@
#chrt --other -p 0 ${NAV_PID}

read -p "Press any key to kill"
echo -n "Killing..."
pkill -9 repro_live*
echo "Killed"
