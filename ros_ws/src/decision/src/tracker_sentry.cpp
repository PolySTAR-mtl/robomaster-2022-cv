/** \file tracker_sentry.cpp
 * \brief Simple targeting node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Std includes

#include <algorithm>

// ROS includes
// changer les 1
#include <ros/ros.h>
#include <cmath>

#include "serial/Target.h"
#include "tracking/Tracklets.h"

class SentryTracker {
  public:
    SentryTracker(ros::NodeHandle& n, int _enemy_color, float freq)
        : nh(n), enemy_color(_enemy_color), freq_(freq) {
        sub_tracklets = nh.subscribe("tracklets", 1,
                                     &SentryTracker::callbackTracklets, this); // a chaque fois que tracklets recoit un message, callbackTracklets() est appellee

        pub_target = nh.advertise<serial::Target>("target", 1);
        std::cout << "Enemy color set to be: "
                  << (enemy_color == 0 ? "red" : "blue") << "\n";
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
            if (dist < best_dist && enemy_color == int(trk.clss)) {
                index = i;
                best_dist = dist;
            }
            ++i;
        }

        if (index != -1) {
            last_trk = trks->tracklets[index];
            pub_target.publish(toTarget(last_trk));
        }
        hasDetected_ = true;
    }

    bool hasDetected() 
    { 
        if (hasDetected_) {
            hasDetected_ = false;
            return true;
        }
        return false;
    }

    serial::Target toTarget(tracking::Tracklet& trk) {
        serial::Target target;

        std::cout << "Det : " << trk.x << " ( " << trk.w << " ) " << trk.y
                  << " ( " << trk.h << " )\n";

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

    float degToRad(float deg) { 
        return deg * M_PI / 180.;
    }

    void search() { 
        count_++;
        theta_ = degToRad(sin(static_cast<float>(count_)/ freq_) * maxAngle);
   
        serial::Target target;

        target.theta = theta_;
        pub_target.publish(target);
    }
  private:
    ros::NodeHandle& nh;
    ros::Subscriber sub_tracklets;
    ros::Publisher pub_target;
    int enemy_color;
    float maxAngle = 1;
    float freq_;
    int count_ = 0;

    tracking::Tracklet last_trk;

    bool hasDetected_ = false;

    float im_w = 416 / 2;
    float im_h = 416 / 2;

    // Scaling factor
    float alpha_y = 0.001;
    float alpha_x = 0.01;
    float theta_ = 0;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "decision");
    ros::NodeHandle nh("~");

    int enemy_color;

    if (!nh.getParam("enemy_color", enemy_color)) {
        throw std::runtime_error("Enemy color not specified");
    }
    if (enemy_color != 0 and enemy_color != 1) {
        throw std::runtime_error("Enemy color should be 0 (red) or 1 (blue)");
    }
    float rate = 30;
    SentryTracker tracker(nh, enemy_color, rate);

    ros::Rate loop_rate(rate);

    while (ros::ok()) 
    {
        ros::spinOnce(); //spinOnce() fait que tu verifies si entre mtn et le dernier spinOnce() il sest passe qqchose
        if (!tracker.hasDetected()) //il faut trouver une maniere de lui dire "if tu ne vois/track rien et que tu as pas atteind ta limite de rotation"
        {   
           tracker.search();
        }

        loop_rate.sleep();
    }
}
