// Auto-generated. Do not edit!

// (in-package detection.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Detection = require('./Detection.js');

//-----------------------------------------------------------

class Detections {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.detections = null;
      this.timelapse = null;
    }
    else {
      if (initObj.hasOwnProperty('detections')) {
        this.detections = initObj.detections
      }
      else {
        this.detections = [];
      }
      if (initObj.hasOwnProperty('timelapse')) {
        this.timelapse = initObj.timelapse
      }
      else {
        this.timelapse = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Detections
    // Serialize message field [detections]
    // Serialize the length for message field [detections]
    bufferOffset = _serializer.uint32(obj.detections.length, buffer, bufferOffset);
    obj.detections.forEach((val) => {
      bufferOffset = Detection.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [timelapse]
    bufferOffset = _serializer.uint32(obj.timelapse, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Detections
    let len;
    let data = new Detections(null);
    // Deserialize message field [detections]
    // Deserialize array length for message field [detections]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.detections = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.detections[i] = Detection.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [timelapse]
    data.timelapse = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 21 * object.detections.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'detection/Detections';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5a80ac5cf722ceea32bf50e93318cacc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Detections.msg
    ## List of detected bounding boxes
    
    # Header header
    Detection[] detections
    
    uint32 timelapse
    ================================================================================
    MSG: detection/Detection
    # Detection.msg
    ## Bounding box with class and confidence
    
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
    const resolved = new Detections(null);
    if (msg.detections !== undefined) {
      resolved.detections = new Array(msg.detections.length);
      for (let i = 0; i < resolved.detections.length; ++i) {
        resolved.detections[i] = Detection.Resolve(msg.detections[i]);
      }
    }
    else {
      resolved.detections = []
    }

    if (msg.timelapse !== undefined) {
      resolved.timelapse = msg.timelapse;
    }
    else {
      resolved.timelapse = 0
    }

    return resolved;
    }
};

module.exports = Detections;
