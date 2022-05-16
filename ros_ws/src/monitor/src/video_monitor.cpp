/** \file video_monitor.cpp
 * \brief Video monitor class
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "video_monitor.hpp"

// Ros includes

#include <cv_bridge/cv_bridge.h>

// ----- Consts ----- //
// TODO : Move to parameters

constexpr int MONITOR_FONT_SIZE = 5;
constexpr auto MONITOR_FONT_FACE = cv::FONT_HERSHEY_SIMPLEX;
const static cv::Scalar MONITOR_FONT_COLOR(255., 255., 255.);
constexpr int MONITOR_FONT_PADDING = 5;

// ----- Methods ----- //

VideoMonitor::VideoMonitor(ros::NodeHandle& n, const std::string& class_name)
    : nh(n), default_name(class_name) {
    pub_im = nh.advertise<sensor_msgs::Image>("image_out", 1);

    sub_cam = nh.subscribe("image_in", 1, &VideoMonitor::callbackImage, this);
    sub_detections =
        nh.subscribe("detections", 1, &VideoMonitor::callbackDetections, this);

    // Load classmap from parameter server
    if (!nh.getParam("/classmap", classmap)) {
        std::cout << "No classmap found, using default name " << default_name
                  << '\n';
    }
}

void VideoMonitor::callbackImage(const sensor_msgs::ImageConstPtr& im) {
    auto img_bridged = cv_bridge::toCvShare(im);

    // Saving the last image to draw on top when receiving detections
    curr_image = img_bridged->image.clone();
}

cv::Scalar VideoMonitor::getColor(uint8_t cls) {
    auto search = colormap.find(cls);
    if (search != std::end(colormap)) {
        return search->second;
    } else {
        cv::Scalar new_color(randgen() % 255, randgen() % 255, randgen() % 255);
        colormap.insert({cls, new_color});
        return new_color;
    }
}

const std::string& VideoMonitor::getClassName(uint8_t cls) {
    if (cls >= classmap.size()) {
        return default_name;
    } else {
        return classmap[cls];
    }
}

void VideoMonitor::callbackDetections(
    const detection::DetectionsConstPtr& dets) {
    if (curr_image.empty()) {
        // No image saved yet
        return;
    }

    auto img_rects = curr_image.clone();
    for (auto& det : dets->detections) {
        auto color = getColor(det.clss);
        cv::Point p1{static_cast<int>(det.x - det.w / 2),
                     static_cast<int>(det.y - det.h / 2)};
        cv::Point p2{static_cast<int>(det.x + det.w / 2),
                     static_cast<int>(det.y + det.h / 2)};

        cv::rectangle(img_rects, p1, p2, color);

        // Print text
        p2 = {p2.x, p1.y};
        p1 = {p1.x, p1.y - 2 * MONITOR_FONT_PADDING - MONITOR_FONT_SIZE};
        cv::rectangle(img_rects, p1, p2, color, cv::FILLED);
        p1.y += MONITOR_FONT_PADDING + MONITOR_FONT_SIZE;

        cv::putText(img_rects, getClassName(det.clss), p1, MONITOR_FONT_FACE,
                    static_cast<double>(MONITOR_FONT_SIZE) / 12.,
                    cv::Scalar(MONITOR_FONT_COLOR));
    }

    auto out_msg =
        cv_bridge::CvImage(dets->header, sensor_msgs::image_encodings::BGR8,
                           img_rects)
            .toImageMsg();
    pub_im.publish(out_msg);
}
