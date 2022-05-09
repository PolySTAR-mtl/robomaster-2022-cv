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

class Target {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.stamp = null;
      this.located = null;
      this.theta = null;
      this.phi = null;
      this.dist = null;
    }
    else {
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('located')) {
        this.located = initObj.located
      }
      else {
        this.located = false;
      }
      if (initObj.hasOwnProperty('theta')) {
        this.theta = initObj.theta
      }
      else {
        this.theta = 0;
      }
      if (initObj.hasOwnProperty('phi')) {
        this.phi = initObj.phi
      }
      else {
        this.phi = 0;
      }
      if (initObj.hasOwnProperty('dist')) {
        this.dist = initObj.dist
      }
      else {
        this.dist = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Target
    // Serialize message field [stamp]
    bufferOffset = _serializer.time(obj.stamp, buffer, bufferOffset);
    // Serialize message field [located]
    bufferOffset = _serializer.bool(obj.located, buffer, bufferOffset);
    // Serialize message field [theta]
    bufferOffset = _serializer.uint16(obj.theta, buffer, bufferOffset);
    // Serialize message field [phi]
    bufferOffset = _serializer.int16(obj.phi, buffer, bufferOffset);
    // Serialize message field [dist]
    bufferOffset = _serializer.uint16(obj.dist, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Target
    let len;
    let data = new Target(null);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [located]
    data.located = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [theta]
    data.theta = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [phi]
    data.phi = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [dist]
    data.dist = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 15;
  }

  static datatype() {
    // Returns string type for a message object
    return 'serial/Target';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '31aff261d89d039028ca56aec375fe72';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Target.msg
    ## From CV to CS : Coordinates of the current target
    
    # Message
    
    time stamp
    bool located
    
    uint16 theta    # milli-ad
    int16 phi       # millirad
    uint16 dist     # mm
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Target(null);
    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = {secs: 0, nsecs: 0}
    }

    if (msg.located !== undefined) {
      resolved.located = msg.located;
    }
    else {
      resolved.located = false
    }

    if (msg.theta !== undefined) {
      resolved.theta = msg.theta;
    }
    else {
      resolved.theta = 0
    }

    if (msg.phi !== undefined) {
      resolved.phi = msg.phi;
    }
    else {
      resolved.phi = 0
    }

    if (msg.dist !== undefined) {
      resolved.dist = msg.dist;
    }
    else {
      resolved.dist = 0
    }

    return resolved;
    }
};

module.exports = Target;
