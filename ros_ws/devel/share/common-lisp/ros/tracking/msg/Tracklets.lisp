; Auto-generated. Do not edit!


(cl:in-package tracking-msg)


;//! \htmlinclude Tracklets.msg.html

(cl:defclass <Tracklets> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (tracklets
    :reader tracklets
    :initarg :tracklets
    :type (cl:vector tracking-msg:Tracklet)
   :initform (cl:make-array 0 :element-type 'tracking-msg:Tracklet :initial-element (cl:make-instance 'tracking-msg:Tracklet))))
)

(cl:defclass Tracklets (<Tracklets>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Tracklets>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Tracklets)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tracking-msg:<Tracklets> is deprecated: use tracking-msg:Tracklets instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Tracklets>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:header-val is deprecated.  Use tracking-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'tracklets-val :lambda-list '(m))
(cl:defmethod tracklets-val ((m <Tracklets>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:tracklets-val is deprecated.  Use tracking-msg:tracklets instead.")
  (tracklets m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Tracklets>) ostream)
  "Serializes a message object of type '<Tracklets>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tracklets))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tracklets))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Tracklets>) istream)
  "Deserializes a message object of type '<Tracklets>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tracklets) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tracklets)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'tracking-msg:Tracklet))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Tracklets>)))
  "Returns string type for a message object of type '<Tracklets>"
  "tracking/Tracklets")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Tracklets)))
  "Returns string type for a message object of type 'Tracklets"
  "tracking/Tracklets")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Tracklets>)))
  "Returns md5sum for a message object of type '<Tracklets>"
  "b9ec897e27b256c83b04eb795b1db40e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Tracklets)))
  "Returns md5sum for a message object of type 'Tracklets"
  "b9ec897e27b256c83b04eb795b1db40e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Tracklets>)))
  "Returns full string definition for message of type '<Tracklets>"
  (cl:format cl:nil "# Tracklets.msg~%## List of tracked bounding boxes~%~%Header header~%Tracklet[] tracklets~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: tracking/Tracklet~%# Tracklet.msg~%## Bounding box with class~%~%# Constants~%~%# TODO~%# uint8 car~%# uint8 armor_module~%# ...~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 cls~%~%float32 confidence~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Tracklets)))
  "Returns full string definition for message of type 'Tracklets"
  (cl:format cl:nil "# Tracklets.msg~%## List of tracked bounding boxes~%~%Header header~%Tracklet[] tracklets~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: tracking/Tracklet~%# Tracklet.msg~%## Bounding box with class~%~%# Constants~%~%# TODO~%# uint8 car~%# uint8 armor_module~%# ...~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 cls~%~%float32 confidence~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Tracklets>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tracklets) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Tracklets>))
  "Converts a ROS message object to a list"
  (cl:list 'Tracklets
    (cl:cons ':header (header msg))
    (cl:cons ':tracklets (tracklets msg))
))
