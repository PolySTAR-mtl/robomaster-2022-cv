/** \file video_monitor.hpp
 * \brief Video monitor class
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#ifndef _POLYSTAR_VIDEO_MONITOR_H
#define _POLYSTAR_VIDEO_MONITOR_H

// Std includes

// Ros includes

#include <ros/ros.h>

#include "detection/Detections.h"
#include "sensor_msgs/Image.h"

class VideoMonitor {
  public:
    VideoMonitor(ros::NodeHandle& n);

    // ----- ROS Callbacks ----- //
    /** \fn callbackImage
     * \brief Callback for images from the camera
     */
    void callbackImage(const sensor_msgs::ImageConstPtr&);

    /** \fn callbackDetections
     * \brief Callback for detections coming from the detection node (NN)
     */
    void callbackDetections(const detection::DetectionsConstPtr&);

  private:
    // ROS
    ros::NodeHandle& nh;
    ros::Publisher pub_im;
    ros::Subscriber sub_cam, sub_detections;

    // Internals
};

#endif
