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

class SwitchOrder {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.stamp = null;
      this.order = null;
    }
    else {
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('order')) {
        this.order = initObj.order
      }
      else {
        this.order = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SwitchOrder
    // Serialize message field [stamp]
    bufferOffset = _serializer.time(obj.stamp, buffer, bufferOffset);
    // Serialize message field [order]
    bufferOffset = _serializer.uint8(obj.order, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SwitchOrder
    let len;
    let data = new SwitchOrder(null);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [order]
    data.order = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'serial/SwitchOrder';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7c80d636f2699ea2200782ffddcd7acc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # SwitchOrder.msg
    ## From CS to CV : switch to a different target
    
    # Constants
    
    uint8 ORDER_NOTHING=0
    uint8 ORDER_NEXT=1
    uint8 ORDER_RIGHT=2
    uint8 ORDER_LEFT=3
    
    # Message
    
    time stamp
    uint8 order
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SwitchOrder(null);
    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = {secs: 0, nsecs: 0}
    }

    if (msg.order !== undefined) {
      resolved.order = msg.order;
    }
    else {
      resolved.order = 0
    }

    return resolved;
    }
};

// Constants for message
SwitchOrder.Constants = {
  ORDER_NOTHING: 0,
  ORDER_NEXT: 1,
  ORDER_RIGHT: 2,
  ORDER_LEFT: 3,
}

module.exports = SwitchOrder;
