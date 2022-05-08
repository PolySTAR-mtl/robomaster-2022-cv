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

    void callbackDetections(const detection::DetectionsConstPtr& dets) {
        auto distance = [](auto d1, auto d2) {
            return std::sqrt(std::pow(d1.x - d2.x, 2) +
                             std::pow(d1.y - d2.y, 2));
        };
        float best_dist = INFINITY;
        int index = -1;

        int i = 0;

        for (auto det : dets->detections) {
            auto dist = distance(last_det, det);
            if (dist < best_dist) {
                index = i;
                best_dist = dist;
            }

            ++i;
        }

        if (index != -1) {
            last_det = dets->detections[index];
            pub_target.publish(toTarget(last_det));
        }
    }

    serial::Target toTarget(detection::Detection& det) {
        serial::Target target;

        auto x_c = det.x + det.w / 2 - im_w;
        auto y_c = det.y + det.h / 2 - im_h;

        uint16_t theta = std::floor((y_c * alpha_y + M_PI_2)) * 20u;
        int16_t phi = std::floor(x_c * alpha_x) * 20u;

        target.theta = theta;
        target.phi = phi;
        target.dist = 2000u; // 2 m
        target.located = true;
        target.stamp = ros::Time::now();

        return target;
    }

  private:
    ros::NodeHandle& nh;
    ros::Subscriber sub_detections;
    ros::Publisher pub_target;

    detection::Detection last_det;

    float im_w = 1920 / 2;
    float im_h = 1080 / 2;

    // Scaling factor
    float alpha_y = 0.1;
    float alpha_x = 0.1;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "decision");
    ros::NodeHandle nh("~");

    SimpleTracker tracker(nh);

    ros::spin();
}
