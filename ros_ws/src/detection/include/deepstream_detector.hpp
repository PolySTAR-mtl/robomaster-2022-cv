/** \file detector.hpp
 * \brief Detection node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#ifndef _POLYSTAR_DEEPSTREAM_DETECTOR_HPP
#define _POLYSTAR_DEEPSTREAM_DETECTOR_HPP

// ROS includes

#include <ros/ros.h>
#include <sensor_msgs/Image.h>

#include "detection/Detections.h"

extern "C" {
void deepstreamCallback(void*, void*);
}

/** \class Detector
 */
class DeepstreamDetector {
  public:
    /** ctor
     * \brief Main constructor. Loads the weights
     */
    DeepstreamDetector(ros::NodeHandle& nh,
                       const std::string& deepstream_config);

    ~DeepstreamDetector() = default;

    /** \fn run
     * \brief Launch the gstreamer pipeline
     */
    void run();

    /** \fn callback
     * \brief Function to call to publish detections
     */
    void callback(detection::Detections&);

  private:
    void setupNet(const std::string& deepstream_config);

    ros::NodeHandle& nh;

    ros::Publisher pub_detections;

    int fake_argc;
    std::vector<const char*> fake_argv;
};

#endif
