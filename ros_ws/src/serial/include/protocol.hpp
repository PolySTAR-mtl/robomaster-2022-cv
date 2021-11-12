/** \file protocol.cpp
 * \brief Serial protocol definition
 *
 * \author Sébastien Darche <sebastien.darche@polymtl.ca>
 */

#ifndef _POLYSTAR_PROTOCOL_H
#define _POLYSTAR_PROTOCOL_H

// Std includes

#include <cstdint>

namespace serial {

// Constants

constexpr uint8_t START_FRAME = 0xFCu;

enum class cmd : uint16_t {
    SWITCH = 0x0001u,
    TARGET = 0x0002u,
    RUNE = 0x0003u,
    HP = 0x0004u
};

enum class target_switch : uint8_t {
    NOTHING = 0x00u,
    NEXT = 0x4Eu,
    RIGHT = 0x52u,
    LEFT = 0x4Cu
};

enum class located : uint8_t { YES = 0x59u, NO = 0x4E };

// Command structs

struct command {
    uint8_t start_byte;
    cmd cmd_id;
} __attribute__((packed));

struct coords {
    located is_located;
    uint16_t theta;
    int16_t phi;
    uint16_t dist;
} __attribute__((packed));

struct hp {
    uint16_t foe_hero;
    uint16_t foe_standard1;
    uint16_t foe_standard2;
    uint16_t foe_sentry;

    uint16_t ally_hero;
    uint16_t ally_standard1;
    uint16_t ally_standard2;
    uint16_t ally_sentry;
} __attribute__((packed));

}; // namespace serial

#endif
