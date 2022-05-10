; Auto-generated. Do not edit!


(cl:in-package tracking-msg)


;//! \htmlinclude Tracklets.msg.html

(cl:defclass <Tracklets> (roslisp-msg-protocol:ros-message)
  ((tracklets
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

(cl:ensure-generic-function 'tracklets-val :lambda-list '(m))
(cl:defmethod tracklets-val ((m <Tracklets>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:tracklets-val is deprecated.  Use tracking-msg:tracklets instead.")
  (tracklets m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Tracklets>) ostream)
  "Serializes a message object of type '<Tracklets>"
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
  "09e49bce30706a9a7b107c52941becdc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Tracklets)))
  "Returns md5sum for a message object of type 'Tracklets"
  "09e49bce30706a9a7b107c52941becdc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Tracklets>)))
  "Returns full string definition for message of type '<Tracklets>"
  (cl:format cl:nil "# Tracklets.msg~%## List of tracked bounding boxes~%~%# Header header~%Tracklet[] tracklets~%================================================================================~%MSG: tracking/Tracklet~%# Tracklet.msg~%## Bounding box with class~%~%# ID~%uint8 id~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 clss~%~%float32 score~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Tracklets)))
  "Returns full string definition for message of type 'Tracklets"
  (cl:format cl:nil "# Tracklets.msg~%## List of tracked bounding boxes~%~%# Header header~%Tracklet[] tracklets~%================================================================================~%MSG: tracking/Tracklet~%# Tracklet.msg~%## Bounding box with class~%~%# ID~%uint8 id~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 clss~%~%float32 score~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Tracklets>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tracklets) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Tracklets>))
  "Converts a ROS message object to a list"
  (cl:list 'Tracklets
    (cl:cons ':tracklets (tracklets msg))
))
