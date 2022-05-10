; Auto-generated. Do not edit!


(cl:in-package detection-msg)


;//! \htmlinclude Detections.msg.html

(cl:defclass <Detections> (roslisp-msg-protocol:ros-message)
  ((detections
    :reader detections
    :initarg :detections
    :type (cl:vector detection-msg:Detection)
   :initform (cl:make-array 0 :element-type 'detection-msg:Detection :initial-element (cl:make-instance 'detection-msg:Detection))))
)

(cl:defclass Detections (<Detections>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Detections>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Detections)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name detection-msg:<Detections> is deprecated: use detection-msg:Detections instead.")))

(cl:ensure-generic-function 'detections-val :lambda-list '(m))
(cl:defmethod detections-val ((m <Detections>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader detection-msg:detections-val is deprecated.  Use detection-msg:detections instead.")
  (detections m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Detections>) ostream)
  "Serializes a message object of type '<Detections>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'detections))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'detections))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Detections>) istream)
  "Deserializes a message object of type '<Detections>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detections) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detections)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'detection-msg:Detection))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Detections>)))
  "Returns string type for a message object of type '<Detections>"
  "detection/Detections")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detections)))
  "Returns string type for a message object of type 'Detections"
  "detection/Detections")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Detections>)))
  "Returns md5sum for a message object of type '<Detections>"
  "cafb60d89a040a540def8d31f5cdc037")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Detections)))
  "Returns md5sum for a message object of type 'Detections"
  "cafb60d89a040a540def8d31f5cdc037")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Detections>)))
  "Returns full string definition for message of type '<Detections>"
  (cl:format cl:nil "# Detections.msg~%## List of detected bounding boxes~%~%# Header header~%Detection[] detections~%================================================================================~%MSG: detection/Detection~%# Detection.msg~%## Bounding box with class and confidence~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 clss~%~%float32 score~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Detections)))
  "Returns full string definition for message of type 'Detections"
  (cl:format cl:nil "# Detections.msg~%## List of detected bounding boxes~%~%# Header header~%Detection[] detections~%================================================================================~%MSG: detection/Detection~%# Detection.msg~%## Bounding box with class and confidence~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 clss~%~%float32 score~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Detections>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detections) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Detections>))
  "Converts a ROS message object to a list"
  (cl:list 'Detections
    (cl:cons ':detections (detections msg))
))
