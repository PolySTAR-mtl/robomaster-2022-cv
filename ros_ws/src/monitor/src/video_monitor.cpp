/** \file video_monitor.cpp
 * \brief Video monitor node executable
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// ROS includes

#include <ros/ros.h>


/** \brief This node shows the current video stream as well as the detected bounding boxes
 */
int main(int argc, char** argv) {
    ros::init(argc, argv, "video_monitor");
    ros::NodeHandle nh;

    ros::spin();
}

