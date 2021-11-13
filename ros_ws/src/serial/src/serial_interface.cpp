/** \file serial_interface.cpp
 * \brief Serial interface node executable
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// ROS includes

#include <ros/ros.h>

// Local includes

#include "serial_spinner.hpp"

/** \brief This node serves as the main interface to the serial port
 */
int main(int argc, char** argv) {
    ros::init(argc, argv, "serial");
    ros::NodeHandle nh("serial");

    std::string device;
    int baud, length, stop;
    bool parity;

    if (!nh.getParam("device", device)) {
        throw std::runtime_error("No serial device specified");
    }
    nh.param("length", length, 8);
    nh.param("baud", baud, 115200);
    nh.param("stop", stop, 1);
    nh.param("parity", parity, false);

    SerialSpinner ser(nh, device, baud, length, stop, parity);

    ser.spin();
}
