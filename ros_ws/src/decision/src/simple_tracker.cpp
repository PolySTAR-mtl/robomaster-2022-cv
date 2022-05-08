/** \file simple_tracker.cpp
 * \brief Simple targeting node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Std includes

#include <algorithm>

// ROS includes

#include <ros/ros.h>

#include "detection/Detections.h"
#include "serial/Target.h"

class SimpleTracker {
  public:
    SimpleTracker(ros::NodeHandle& n) : nh(n) {
        sub_detections = nh.subscribe("detections", 1,
                                      &SimpleTracker::callbackDetections, this);

        pub_target = nh.advertise<serial::Target>("target", 1);
    }

    void callbackDetections(const detection::DetectionsConstPtr& dets) {}

  private:
    ros::NodeHandle& nh;
    ros::Subscriber sub_detections;
    ros::Publisher pub_target;

    detection::Detection last_det;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "decision");
    ros::NodeHandle nh("~");

    SimpleTracker tracker(nh);

    ros::spin();
}
