/** \file serial_testing.cpp
 * \brief Serial interface integration test
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Std includes

#include <cmath>

// ROS includes

#include <ros/ros.h>

// Local includes

#include "serial/Target.h"

constexpr uint16_t rewrap_pi_millirad(uint16_t angle) {
    uint16_t circle_millirad = 2 * M_PI * 1000;
    if (angle > circle_millirad) {
        return angle % circle_millirad;
    } else {
        return angle;
    }
}

/** \brief This node sends dummy orders to the serial port at a specified
 * frequency
 */
int main(int argc, char** argv) {
    ros::init(argc, argv, "serial_testing");
    ros::NodeHandle nh("serial_testing");

    constexpr float amplitude = M_PI / 3;
    constexpr uint16_t dist = 100u;
    float freq, increment;

    nh.param("freq", freq, 1.f);
    nh.param("increment", increment, .1f);

    auto pub = nh.advertise<serial::Target>("target", 1);

    ros::Rate rate(freq);

    while (ros::ok()) {
        for (float alpha = 0.f; alpha < 2 * M_PI; alpha += increment) {
            serial::Target msg;

            uint16_t theta = std::floor(std::sin(alpha) * amplitude * 1000);
            int16_t phi = std::floor(std::cos(alpha) * amplitude * 1000);

            msg.located = true;
            msg.theta = rewrap_pi_millirad(theta);
            msg.phi = phi;
            msg.dist = dist;

            pub.publish(msg);

            rate.sleep();
            ros::spinOnce();
        }
    }
}
