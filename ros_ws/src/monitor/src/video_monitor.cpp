/** \file video_monitor.cpp
 * \brief Video monitor class
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "video_monitor.hpp"

VideoMonitor::VideoMonitor(ros::NodeHandle& n) : nh(n) {
    pub_im = nh.advertise<sensor_msgs::Image>("image_out", 1);

    sub_cam = nh.subscribe("image_in", 1, &VideoMonitor::callbackImage, this);
    sub_detections =
        nh.subscribe("detections", 1, &VideoMonitor::callbackDetections, this);
}

void VideoMonitor::callbackImage(const sensor_msgs::ImageConstPtr& im) {}

void VideoMonitor::callbackDetections(
    const detection::DetectionsConstPtr& dets) {}
