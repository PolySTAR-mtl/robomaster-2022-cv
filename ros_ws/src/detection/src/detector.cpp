/** \file detector.cpp
 * \brief Detection node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#include "detector.hpp"

// Darknet

#include "darknet.h"

struct Detector::impl {
    network net;
};

Detector::Detector(ros::NodeHandle& n, const std::string& datacfg,
                   const std::string& config_path,
                   const std::string& weights_path)
    : nh(n), p(std::make_unique<impl>()) {
    setupNet(datacfg, config_path, weights_path);
}

void Detector::setupNet(const std::string& datacfg,
                        const std::string& config_path,
                        const std::string& weights_path) {}

void Detector::imageCallback(const sensor_msgs::ImagePtr& img) {}
