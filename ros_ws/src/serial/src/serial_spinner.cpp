/** \file serial_spinner.cpp
 * \brief Serial spinner class to interface with the boards
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

// Local includes

#include "serial_spinner.hpp"
#include "protocol.hpp"

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
    int err = cfsetispeed(&tty, B230400);
    err += cfsetospeed(&tty, B230400);

    if(err != 0) { throw std::runtime_error("Could not set IOspeed"); }

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
    int bytes;
    serial::command cmd;

    // ROS messages have to be initialized outside of a switch statement
    serial::HP hp_msg;
    serial::SwitchOrder switch_msg;

    // Attempt to read a command
    bytes = read(fd, &cmd, sizeof(cmd));
    if (bytes < sizeof(cmd)) {
        // No incoming command, return immediatly
        return;
    }

    uint8_t* ptr = reinterpret_cast<uint8_t*>(&cmd);
    for(auto i = 0u; i < sizeof(cmd); ++i) {
	    std::cout << std::hex << static_cast<unsigned int>(ptr[i]) << ' ';
    }

    std::cout << '\n';

    if (cmd.start_byte != serial::START_FRAME) {
        ROS_ERROR("Start frame not recognized, dropping command");
        return;
    }

    switch (cmd.cmd_id) {
    case serial::cmd::SWITCH:
        serial::target_switch data_sw;

        // Check if data_len is coherent
        if (cmd.data_len != sizeof(data_sw)) {
            ROS_ERROR("Incoherent data_len / unexpected data length");
            return;
        }

        bytes = read(fd, &data_sw, sizeof(data_sw));
        if (bytes < sizeof(data_sw)) {
            ROS_ERROR("Incomplete read on target switch order");
            return;
        }

	std::cout << static_cast<unsigned int>(data_sw) << '\n';

        // Create ROS message
        switch (data_sw) {
        case serial::target_switch::NOTHING:
            switch_msg.order = serial::SwitchOrder::ORDER_NOTHING;
            break;
        case serial::target_switch::NEXT:
            switch_msg.order = serial::SwitchOrder::ORDER_NEXT;
            break;
        case serial::target_switch::RIGHT:
            switch_msg.order = serial::SwitchOrder::ORDER_RIGHT;
            break;
        case serial::target_switch::LEFT:
            switch_msg.order = serial::SwitchOrder::ORDER_LEFT;
            break;
        default:
            ROS_ERROR("Unsupported switch order");
            return;
        }

        // Publish to topic
        pub_switch.publish(switch_msg);

        break;
    case serial::cmd::HP:
        serial::hp data_hp;

        // Check if data_len is coherent
        if (cmd.data_len != sizeof(data_hp)) {
            ROS_ERROR("Incoherent data_len / unexpected data length");
            return;
        }

        bytes = read(fd, &data_hp, sizeof(data_hp));
        if (bytes < sizeof(data_hp)) {
            ROS_ERROR("Incomplete read on HP transfer");
            return;
        }

        // Create ROS message
        hp_msg.foe_hero = data_hp.foe_hero;
        hp_msg.foe_standard1 = data_hp.foe_standard1;
        hp_msg.foe_standard2 = data_hp.foe_standard2;
        hp_msg.foe_sentry = data_hp.foe_sentry;

        hp_msg.ally_hero = data_hp.ally_hero;
        hp_msg.ally_standard1 = data_hp.ally_standard1;
        hp_msg.ally_standard2 = data_hp.ally_standard2;
        hp_msg.ally_sentry = data_hp.ally_sentry;

        // Publish to topic
        pub_hp.publish(hp_msg);

        break;
    default:
        ROS_ERROR("Unrecognized/unhandled serial command");
        return;
    }
}

void SerialSpinner::callbackTarget(const serial::TargetConstPtr& target) {
    serial::coords msg;
    msg.is_located = serial::located::YES;
    msg.theta = target->theta;
    msg.phi = target->phi;
    msg.dist = target->dist;

    std::cout << "Target : " << msg.theta << ' ' << msg.phi << ' ' << msg.dist
              << '\n';

    uint8_t* ptr = reinterpret_cast<uint8_t*>(&msg);
    for(auto i = 0u; i < sizeof(msg); ++i) {
	    std::cout << std::hex << static_cast<unsigned int>(ptr[i]) << ' ';
    }
    std::cout << std::dec <<'\n';

    int bytes = write(fd, &msg, sizeof(msg));
    if (bytes != sizeof(msg)) {
        ROS_ERROR("Could not write to serial : %s", strerror(errno));
    }
}

void SerialSpinner::callbackRune(const serial::RuneConstPtr&) {
    ROS_DEBUG("Unimplemented callback (SerialSpinner::callBackRune");
}
