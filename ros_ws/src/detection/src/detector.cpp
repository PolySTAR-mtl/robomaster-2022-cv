/** \file detector.cpp
 * \brief Detection node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#include "detector.hpp"

// Std includes

#include <fstream>
#include <vector>

// Darknet

#include "darknet.h"
#include "parser.h"

// ROS Includes

#include <cv_bridge/cv_bridge.h>

struct Detector::impl {
    // TODO : fetch from parameter server
    float nms = 0.45f;
    float tresh = 0.24f;
    float hier_tresh = 0.5f;

    std::vector<std::string> labels;
    network net;
};

Detector::Detector(ros::NodeHandle& n, const std::string& datacfg,
                   const std::string& config_path,
                   const std::string& weights_path)
    : nh(n), p(std::make_unique<impl>()) {
    setupNet(datacfg, config_path, weights_path);

    sub_img = nh.subscribe("image_in", 1, &Detector::imageCallback, this);
}

Detector::~Detector() = default;

void Detector::setupNet(const std::string& datacfg,
                        const std::string& config_path,
                        const std::string& weights_path) {
    loadLabels();

    // Load network
    // const_casts because the API is pretty badly designed -_-
    p->net =
        parse_network_cfg_custom(const_cast<char*>(config_path.c_str()), 1, 1);
    load_weights(&p->net, const_cast<char*>(weights_path.c_str()));
    fuse_conv_batchnorm(p->net);
    calculate_binary_weights(p->net);

    if (p->net.layers[p->net.n - 1].classes != p->labels.size()) {
        throw std::runtime_error(
            "Different number of classes between network and label file");
    }

    std::cout << "Detector : Ready\n";
}

void Detector::loadLabels() {
    std::string path;
    if (!nh.getParam("net/labels", path)) {
        return;
    }

    std::ifstream labels_file(path);

    std::string buffer;
    while (std::getline(labels_file, buffer)) {
        p->labels.emplace_back(buffer);
        buffer = "";
    }
}

void Detector::imageCallback(const sensor_msgs::ImagePtr& img) {
    constexpr float ratio = 1.f / 256.f;

    auto img_opencv = cv_bridge::toCvCopy(img);
    cv::Mat img_float;

    // TODO : check conversion
    img_opencv->image.convertTo(img_float, CV_32F, ratio);

    image im;
    im.c = p->net.c;
    im.data = reinterpret_cast<float*>(img_opencv->image.data);
    im.w = img_opencv->image.rows;
    im.h = img_opencv->image.cols;

    image sized = resize_image(im, p->net.w, p->net.h);

    // Run inference
    network_predict(p->net, sized.data);

    // Fetch boxes
    int nboxes;
    detection* dets = get_network_boxes(&p->net, im.w, im.h, p->tresh,
                                        p->hier_tresh, 0, 1, &nboxes, 0);

    // Construct ROS message
    for (auto i = 0; i < nboxes; ++i) {
        std::cout << dets[i].best_class_idx;
    }

    free_detections(dets, nboxes);
    free_image(sized);
}
