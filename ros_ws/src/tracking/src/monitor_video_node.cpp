/** \file monitor_video.cpp
 * \brief Video monitor node executable
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// ROS includes

#include <ros/ros.h>

// Local includes

#include "video_monitor.hpp"

/** \brief This node shows the current video stream as well as the detected
 * bounding boxes, tracklets and current target
 */
int main(int argc, char** argv) {
    ros::init(argc, argv, "monitor_video");
    ros::NodeHandle nh("~");

    VideoMonitor monitor(nh);

    ros::spin();
}
