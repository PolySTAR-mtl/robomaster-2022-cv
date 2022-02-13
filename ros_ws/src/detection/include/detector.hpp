/** \file detector.hpp
 * \brief Detection node
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#ifndef _POLYSTAR_DETECTOR_HPP
#define _POLYSTAR_DETECTOR_HPP

// ROS includes

#include <ros/ros.h>
#include <sensor_msgs/Image.h>

/** \class Detector
 */
class Detector {
  public:
    /** ctor
     * \brief Main constructor. Loads the weights
     */
    Detector(ros::NodeHandle& nh, const std::string& datacfg,
             const std::string& config_path, const std::string& weights_path);

    ~Detector();

    /** \fn imageCallback
     * \brief Callback for incoming images (from camera)
     */
    void imageCallback(const sensor_msgs::ImagePtr& img);

  private:
    void setupNet(const std::string& datacfg, const std::string& config_path,
                  const std::string& weights_path);

    void loadLabels();

    ros::NodeHandle& nh;

    ros::Subscriber sub_img;
    ros::Publisher pub_detections;

    /** PIml idiom
     * \brief Not a fan of PImpl, but in this case it prevents Darknet from
     * leaking a horrendous amount of symbols in the default namespace ...
     * (Thanks, C)
     */
    struct impl;
    std::unique_ptr<impl> p;
};

#endif
