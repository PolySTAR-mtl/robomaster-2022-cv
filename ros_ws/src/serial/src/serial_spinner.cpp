/** \file serial_spinner.cpp
 * \brief Serial spinner class to interface with the boards
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "serial_spinner.hpp"

// Std includes

// ROS includes

// OS includes

#include <errno.h>
#include <fcntl.h>
#include <termios.h>
#include <unistd.h>

SerialSpinner::SerialSpinner(const std::string& device, unsigned int _baud,
                             unsigned int _len, unsigned int _stop,
                             bool _parity, double _freq = 100.)
    : baud_rate(_baud), length(_len), stop_bits(_stop), parity(_parity),
      frequency(_freq) {
    initSerial(device);
    // TODO : Set-up pub/sub
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
