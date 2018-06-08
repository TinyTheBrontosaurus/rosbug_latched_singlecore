#include <ros/ros.h>
#include <std_msgs/Bool.h>


#pragma GCC diagnostic ignored "-Wunused-parameter"

void callback(const std_msgs::Bool::ConstPtr& original) {
  static int count = 1;
  printf("In callback %d\n", count);
  fflush(0);
  count += 1;
}


int main(int argc, char **argv) {
  ros::init(argc, argv, "ReproLatchedSinglecore");

  ros::NodeHandle nh;
  ros::TransportHints hints;
  hints.udp().tcpNoDelay(true);
  ros::Subscriber sub = nh.subscribe("arbitrary", 10, callback, hints);

  ros::spin();

  return 0;
}
