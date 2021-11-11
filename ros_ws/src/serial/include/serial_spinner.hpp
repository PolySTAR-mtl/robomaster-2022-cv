/** \file serial_spinner.hpp
 * \brief Serial spinner class to interface with the boards
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#ifndef _POLYSTAR_SERIAL_SPINNER_H
#define _POLYSTAR_SERIAL_SPINNER_H

// Std includes

#include <string>

// ROS includes

#include <ros/ros.h>

#include "serial/Rune.h"
#include "serial/Target.h"

/** \class SerialSpinner
 */
class SerialSpinner {
  public:
    /** \brief Constructor
     */
    SerialSpinner(const std::string& device, unsigned int baud_rate,
                  unsigned int length, unsigned int stop_bits, bool parity,
                  double frequency = 100.);

    /** \brief Destructor
     */
    ~SerialSpinner();

    /** \fn callbackTarget
     * \brief Callback for new target coordinates
     */
    void callbackTarget(const serial::TargetConstPtr&);

    /** \fn callbackRune
     * \brief Callback for rune coordinates
     * \deprecated This feature is not used as of today
     */
    void callbackRune(const serial::RuneConstPtr&);

    /** \fn spin
     * \brief Spins, waiting for requests and listens to the serial port
     */
    void spin();

  private:
    /** \fn initSerial
     * \brief Initializes the serial file descriptor. To be called by the
     * constructor
     */
    void initSerial(const std::string& device);

    int fd = -1;
    unsigned int baud_rate, length, stop_bits;
    bool parity;
    double frequency;
};

#endif
