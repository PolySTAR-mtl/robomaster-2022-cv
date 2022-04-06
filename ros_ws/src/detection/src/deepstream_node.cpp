/** \file deepstream_node.cpp
 * \brief Main detection node for the deepstream-app, executable
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "deepstream_detector.hpp"

int main(int argc, char** argv) {
    ros::init(argc, argv, "detector");
    ros::NodeHandle nh("~");

    std::string deepstream_conf;
    if (!nh.getParam("net/deepstream", deepstream_conf)) {
        throw std::runtime_error("Deepstream configuration path not specified");
    }

    DeepstreamDetector detector(nh, deepstream_conf);

    detector.run();

    return 0;
}
