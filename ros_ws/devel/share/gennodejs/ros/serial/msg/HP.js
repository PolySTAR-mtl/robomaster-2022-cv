// Auto-generated. Do not edit!

// (in-package serial.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class HP {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.foe_hero = null;
      this.foe_standard1 = null;
      this.foe_standard2 = null;
      this.foe_sentry = null;
      this.ally_hero = null;
      this.ally_standard1 = null;
      this.ally_standard2 = null;
      this.ally_sentry = null;
    }
    else {
      if (initObj.hasOwnProperty('foe_hero')) {
        this.foe_hero = initObj.foe_hero
      }
      else {
        this.foe_hero = 0;
      }
      if (initObj.hasOwnProperty('foe_standard1')) {
        this.foe_standard1 = initObj.foe_standard1
      }
      else {
        this.foe_standard1 = 0;
      }
      if (initObj.hasOwnProperty('foe_standard2')) {
        this.foe_standard2 = initObj.foe_standard2
      }
      else {
        this.foe_standard2 = 0;
      }
      if (initObj.hasOwnProperty('foe_sentry')) {
        this.foe_sentry = initObj.foe_sentry
      }
      else {
        this.foe_sentry = 0;
      }
      if (initObj.hasOwnProperty('ally_hero')) {
        this.ally_hero = initObj.ally_hero
      }
      else {
        this.ally_hero = 0;
      }
      if (initObj.hasOwnProperty('ally_standard1')) {
        this.ally_standard1 = initObj.ally_standard1
      }
      else {
        this.ally_standard1 = 0;
      }
      if (initObj.hasOwnProperty('ally_standard2')) {
        this.ally_standard2 = initObj.ally_standard2
      }
      else {
        this.ally_standard2 = 0;
      }
      if (initObj.hasOwnProperty('ally_sentry')) {
        this.ally_sentry = initObj.ally_sentry
      }
      else {
        this.ally_sentry = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HP
    // Serialize message field [foe_hero]
    bufferOffset = _serializer.uint16(obj.foe_hero, buffer, bufferOffset);
    // Serialize message field [foe_standard1]
    bufferOffset = _serializer.uint16(obj.foe_standard1, buffer, bufferOffset);
    // Serialize message field [foe_standard2]
    bufferOffset = _serializer.uint16(obj.foe_standard2, buffer, bufferOffset);
    // Serialize message field [foe_sentry]
    bufferOffset = _serializer.uint16(obj.foe_sentry, buffer, bufferOffset);
    // Serialize message field [ally_hero]
    bufferOffset = _serializer.uint16(obj.ally_hero, buffer, bufferOffset);
    // Serialize message field [ally_standard1]
    bufferOffset = _serializer.uint16(obj.ally_standard1, buffer, bufferOffset);
    // Serialize message field [ally_standard2]
    bufferOffset = _serializer.uint16(obj.ally_standard2, buffer, bufferOffset);
    // Serialize message field [ally_sentry]
    bufferOffset = _serializer.uint16(obj.ally_sentry, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HP
    let len;
    let data = new HP(null);
    // Deserialize message field [foe_hero]
    data.foe_hero = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [foe_standard1]
    data.foe_standard1 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [foe_standard2]
    data.foe_standard2 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [foe_sentry]
    data.foe_sentry = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ally_hero]
    data.ally_hero = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ally_standard1]
    data.ally_standard1 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ally_standard2]
    data.ally_standard2 = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [ally_sentry]
    data.ally_sentry = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'serial/HP';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2f1de7f65b9e758a9b89a73d0d3bd446';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Rune.msg
    ## From CS to CV : Health points of all robots
    
    # Message
    
    uint16 foe_hero
    uint16 foe_standard1
    uint16 foe_standard2
    uint16 foe_sentry
    
    uint16 ally_hero
    uint16 ally_standard1
    uint16 ally_standard2
    uint16 ally_sentry
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HP(null);
    if (msg.foe_hero !== undefined) {
      resolved.foe_hero = msg.foe_hero;
    }
    else {
      resolved.foe_hero = 0
    }

    if (msg.foe_standard1 !== undefined) {
      resolved.foe_standard1 = msg.foe_standard1;
    }
    else {
      resolved.foe_standard1 = 0
    }

    if (msg.foe_standard2 !== undefined) {
      resolved.foe_standard2 = msg.foe_standard2;
    }
    else {
      resolved.foe_standard2 = 0
    }

    if (msg.foe_sentry !== undefined) {
      resolved.foe_sentry = msg.foe_sentry;
    }
    else {
      resolved.foe_sentry = 0
    }

    if (msg.ally_hero !== undefined) {
      resolved.ally_hero = msg.ally_hero;
    }
    else {
      resolved.ally_hero = 0
    }

    if (msg.ally_standard1 !== undefined) {
      resolved.ally_standard1 = msg.ally_standard1;
    }
    else {
      resolved.ally_standard1 = 0
    }

    if (msg.ally_standard2 !== undefined) {
      resolved.ally_standard2 = msg.ally_standard2;
    }
    else {
      resolved.ally_standard2 = 0
    }

    if (msg.ally_sentry !== undefined) {
      resolved.ally_sentry = msg.ally_sentry;
    }
    else {
      resolved.ally_sentry = 0
    }

    return resolved;
    }
};

module.exports = HP;
