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
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Tracklets {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.tracklets = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
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
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
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
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
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
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 21 * object.tracklets.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'tracking/Tracklets';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b9ec897e27b256c83b04eb795b1db40e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Tracklets.msg
    ## List of tracked bounding boxes
    
    Header header
    Tracklet[] tracklets
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
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
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

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
