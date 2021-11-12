/** \file serial_spinner.cpp
 * \brief Serial spinner class to interface with the boards
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "serial_spinner.hpp"

// Std includes

// ROS includes

#include "serial/HP.h"
#include "serial/SwitchOrder.h"

// OS includes

#include <errno.h>
#include <fcntl.h>
#include <termios.h>
#include <unistd.h>

SerialSpinner::SerialSpinner(ros::NodeHandle& n, const std::string& device,
                             int _baud, int _len, int _stop, bool _parity,
                             double _freq)
    : nh(n), baud_rate(_baud), length(_len), stop_bits(_stop), parity(_parity),
      frequency(_freq) {
    initSerial(device);

    pub_hp = nh.advertise<serial::HP>("hp", 1);
    pub_switch = nh.advertise<serial::SwitchOrder>("switch", 1);

    sub_target =
        nh.subscribe("target", 1, &SerialSpinner::callbackTarget, this);

    sub_rune = nh.subscribe("rune", 1, &SerialSpinner::callbackRune, this);
}

SerialSpinner::~SerialSpinner() {
    if (fd != 0) {
        close(fd);
    }
}

void SerialSpinner::initSerial(const std::string& device) {
    fd = open(device.c_str(), O_RDWR);

    if (fd < 0) {
        throw std::runtime_error("Could not open device " + device +
                                 strerror(errno));
    }

    struct termios tty;
    if (tcgetattr(fd, &tty) != 0) {
        throw std::runtime_error("Could not get term info " + device +
                                 strerror(errno));
    }

    // Set parity
    if (parity) {
        tty.c_cflag |= PARENB;
    } else {
        tty.c_cflag &= ~PARENB;
    }

    // Clear CSTOPB if only one stop bit is used
    if (stop_bits == 1) {
        tty.c_cflag &= ~CSTOPB;
    } else {
        tty.c_cflag |= CSTOPB;
    }

    // Set length
    tty.c_cflag &= ~CSIZE;
    switch (length) {
    case 5:
        tty.c_cflag |= CS5;
        break;
    case 6:
        tty.c_cflag |= CS6;
        break;
    case 7:
        tty.c_cflag |= CS7;
        break;
    case 8:
        tty.c_cflag |= CS8;
        break;
    default:
        throw std::runtime_error("Unsupported byte length");
    }

    // Disable flow control
    tty.c_cflag &= ~CRTSCTS;

    // Disable modem features
    tty.c_cflag |= CREAD | CLOCAL;

    // Disable canonical mode (line-buffering) & signal char
    tty.c_lflag &= ~ICANON;
    tty.c_lflag &= ~ECHO;
    tty.c_lflag &= ~ECHOE;
    tty.c_lflag &= ~ECHONL;
    tty.c_lflag &= ~ISIG;

    // Disable input flow control
    tty.c_iflag &= ~(IXON | IXOFF | IXANY);
    tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL);

    // Disable output interpretation
    tty.c_oflag &= ~OPOST;
    tty.c_oflag &= ~ONLCR;

    // Non-blocking read
    tty.c_cc[VMIN] = 0;
    tty.c_cc[VTIME] = 0;

    // Set baud
    cfsetispeed(&tty, baud_rate);
    cfsetospeed(&tty, baud_rate);

    // Aaaand .. we're done ! Commit to the OS
    if (tcsetattr(fd, TCSANOW, &tty) != 0) {
        throw std::runtime_error(std::string("Could not set tty attributes") +
                                 strerror(errno));
    }
}

void SerialSpinner::spin() {
    ros::Rate rate(frequency);

    while (ros::ok()) {
        handleSerial();

        rate.sleep();
        ros::spinOnce();
    }
}

void SerialSpinner::handleSerial() {
    // TODO
}

void SerialSpinner::callbackTarget(const serial::TargetConstPtr&) {
    // TODO
}

void SerialSpinner::callbackRune(const serial::RuneConstPtr&) {
    // TODO
}
