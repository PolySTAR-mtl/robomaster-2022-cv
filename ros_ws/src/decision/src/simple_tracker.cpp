/** \file simple_tracker.cpp
 * \brief Simple targeting node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Std includes

#include <algorithm>

// ROS includes

#include <ros/ros.h>

#include "tracking/Tracklets.h"
#include "serial/Target.h"

class SimpleTracker {
  public:
    SimpleTracker(ros::NodeHandle& n) : nh(n) {
        sub_tracklets = nh.subscribe("tracking/tracklets", 1,
                                      &SimpleTracker::callbackTracklets, this);

        pub_target = nh.advertise<serial::Target>("target", 1);
    }

    void callbackTracklets(const tracking::TrackletsConstPtr& trks) {
        auto distance = [](auto d1, auto d2) {
            return std::sqrt(std::pow(d1.x - d2.x, 2) +
                             std::pow(d1.y - d2.y, 2));
        };
        float best_dist = INFINITY;
        int index = -1;

        int i = 0;

        for (auto trk : trks->tracklets) {
            auto dist = distance(last_trk, trk);
            if (dist < best_dist) {
                index = i;
                best_dist = dist;
            }
            ++i;
        }

        if (index != -1) {
            last_trk = trks->tracklets[index];
            pub_target.publish(toTarget(last_trk));
        }
    }

    serial::Target toTarget(tracking::Tracklet& trk) {
        serial::Target target;

	    std::cout << "Det : " << trk.x << " ( " << trk.w << " ) " << trk.y << " ( " << trk.h << " )\n";

        auto x_c = trk.x + trk.w / 2 - im_w / 2;
        auto y_c = trk.y + trk.h / 2 - im_h / 2;

	    std::cout << "x_c = " << x_c << " ; y_c = " << y_c << '\n';

        uint16_t theta = std::floor((y_c * alpha_y + M_PI_2) * 1000.f);
        int16_t phi = std::floor(x_c * alpha_x * 1000.f);

        target.theta = theta;
        target.phi = phi;
        target.dist = 2000u; // 2 m
        target.located = true;
        target.stamp = ros::Time::now();

        return target;
    }

  private:
    ros::NodeHandle& nh;
    ros::Subscriber sub_tracklets;
    ros::Publisher pub_target;

    tracking::Tracklet last_trk;

    float im_w = 416 / 2;
    float im_h = 416 / 2;

    // Scaling factor
    float alpha_y = 0.001;
    float alpha_x = 0.01;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "decision");
    ros::NodeHandle nh("~");

    SimpleTracker tracker(nh);

    ros::spin();
}
