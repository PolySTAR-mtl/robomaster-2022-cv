/** \file detection_node.cpp
 * \brief Main detection node, executable
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "detector.hpp"

int main(int argc, char** argv) {
    ros::init(argc, argv, "detector");
    ros::NodeHandle nh("~");

    std::string datacfg, config_path, weights_path;
    if (!nh.getParam("net/datacfg", datacfg)) {
        throw std::runtime_error("Network datacfg path not specified");
    }

    if (!nh.getParam("net/config_path", config_path)) {
        throw std::runtime_error("Network config path not specified");
    }

    if (!nh.getParam("net/weights", weights_path)) {
        throw std::runtime_error("Network weights path not specified");
    }

    Detector detector(nh, datacfg, config_path, weights_path);

    ros::spin();

    return 0;
}
