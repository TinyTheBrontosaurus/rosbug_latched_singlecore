# Bug Report

## Description
This ROS project serves as a minimal reproducible test case for a bug.

The bug occurs when all of the following conditions exist:
* Subscribe done with udp().tcpNoDelay(true)
* A Latched message waiting at subscribe time
* Process set at SCHED_FIFO
* Single core available

If this happens, then one of the threads (not the thread that did the subscribing) gets stuck at 100% CPU and there appears
to be no way out.


## Reproduction steps

### First Terminal
This terminal can simply monitor CPU usage.
```
top
```

### Second Terminal
This terminal publishes a latched message. This can be left up.
```
. devel/setup.bash
roslaunch latched_singlecore repro_setup.launch

```

### Third Terminal
This terminal run the basic ROS node that exhibits the issue.
```
. devel/setup.bash
rosrun latched_singlecore repro_run.sh
```


### Observed Behavior
Once run, you will notice in the `top` window that CPU for `repro` is pegged at 100%. Simply press `<enter>` in the
third terminal to kill the process. This command can be run repeatedly without resetting the other terminals.


### Expected behavior
To see the expected behavior, run `nominal_run.sh` instead.

```
> rosrun latched_singlecore nominal_run.sh
Press enter to kill
In callback 1

Killing...Killed
```


### Other oddities
Running the following should create several messages that are received by `nominal_run.sh`
```
rostopic pub -r 1 /arbitrary std_msgs/Bool 1
```
However, these don't seem to make it though and end up with the following from `roswtf`
```
ERROR The following nodes should be connected but aren't:
 * /rostopic_20612_1528488154903->/ReproLatchedSinglecore (/arbitrary)
```

Creating a simple C++ program that forwards that renames and forward that message seems to workaround that. Note this
goes away if the line `hints.udp().tcpNoDelay(true);` is removed from `repro.cpp`




## Environment
* ROS Kinetic
* Ubuntu 16.04


## Appendix: Very Basic ROS Setup
This assumes a ROS workspace is setup, but can be setup using the following steps

```
mkdir -p ros_workspace/src
cd ros_workspace/src
git clone <this repo>
cd ..
catkin build
```
