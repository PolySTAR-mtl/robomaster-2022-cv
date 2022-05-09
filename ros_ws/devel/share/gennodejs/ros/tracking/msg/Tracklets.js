// Auto-generated. Do not edit!

// (in-package tracking.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Tracklet = require('./Tracklet.js');

//-----------------------------------------------------------

class Tracklets {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.tracklets = null;
    }
    else {
      if (initObj.hasOwnProperty('tracklets')) {
        this.tracklets = initObj.tracklets
      }
      else {
        this.tracklets = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Tracklets
    // Serialize message field [tracklets]
    // Serialize the length for message field [tracklets]
    bufferOffset = _serializer.uint32(obj.tracklets.length, buffer, bufferOffset);
    obj.tracklets.forEach((val) => {
      bufferOffset = Tracklet.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Tracklets
    let len;
    let data = new Tracklets(null);
    // Deserialize message field [tracklets]
    // Deserialize array length for message field [tracklets]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.tracklets = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.tracklets[i] = Tracklet.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 21 * object.tracklets.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'tracking/Tracklets';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eaf004b7dd6cb035732a86956a387ae0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Tracklets.msg
    ## List of tracked bounding boxes
    
    # Header header
    Tracklet[] tracklets
    ================================================================================
    MSG: tracking/Tracklet
    # Tracklet.msg
    ## Bounding box with class
    
    # Constants
    
    # TODO
    # uint8 car
    # uint8 armor_module
    # ...
    
    # Bounding box
    float32 x
    float32 y
    float32 w
    float32 h
    
    # class
    uint8 cls
    
    float32 confidence
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Tracklets(null);
    if (msg.tracklets !== undefined) {
      resolved.tracklets = new Array(msg.tracklets.length);
      for (let i = 0; i < resolved.tracklets.length; ++i) {
        resolved.tracklets[i] = Tracklet.Resolve(msg.tracklets[i]);
      }
    }
    else {
      resolved.tracklets = []
    }

    return resolved;
    }
};

module.exports = Tracklets;
