; Auto-generated. Do not edit!


(cl:in-package tracking-msg)


;//! \htmlinclude Tracklet.msg.html

(cl:defclass <Tracklet> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (w
    :reader w
    :initarg :w
    :type cl:float
    :initform 0.0)
   (h
    :reader h
    :initarg :h
    :type cl:float
    :initform 0.0)
   (clss
    :reader clss
    :initarg :clss
    :type cl:fixnum
    :initform 0)
   (score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0))
)

(cl:defclass Tracklet (<Tracklet>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Tracklet>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Tracklet)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tracking-msg:<Tracklet> is deprecated: use tracking-msg:Tracklet instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:id-val is deprecated.  Use tracking-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:x-val is deprecated.  Use tracking-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:y-val is deprecated.  Use tracking-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'w-val :lambda-list '(m))
(cl:defmethod w-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:w-val is deprecated.  Use tracking-msg:w instead.")
  (w m))

(cl:ensure-generic-function 'h-val :lambda-list '(m))
(cl:defmethod h-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:h-val is deprecated.  Use tracking-msg:h instead.")
  (h m))

(cl:ensure-generic-function 'clss-val :lambda-list '(m))
(cl:defmethod clss-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:clss-val is deprecated.  Use tracking-msg:clss instead.")
  (clss m))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <Tracklet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracking-msg:score-val is deprecated.  Use tracking-msg:score instead.")
  (score m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Tracklet>) ostream)
  "Serializes a message object of type '<Tracklet>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'w))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'h))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'clss)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Tracklet>) istream)
  "Deserializes a message object of type '<Tracklet>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'w) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'h) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'clss)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Tracklet>)))
  "Returns string type for a message object of type '<Tracklet>"
  "tracking/Tracklet")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Tracklet)))
  "Returns string type for a message object of type 'Tracklet"
  "tracking/Tracklet")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Tracklet>)))
  "Returns md5sum for a message object of type '<Tracklet>"
  "59fcd37fcd586a2228c557986fc973a2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Tracklet)))
  "Returns md5sum for a message object of type 'Tracklet"
  "59fcd37fcd586a2228c557986fc973a2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Tracklet>)))
  "Returns full string definition for message of type '<Tracklet>"
  (cl:format cl:nil "# Tracklet.msg~%## Bounding box with class~%~%# ID~%uint8 id~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 clss~%~%float32 score~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Tracklet)))
  "Returns full string definition for message of type 'Tracklet"
  (cl:format cl:nil "# Tracklet.msg~%## Bounding box with class~%~%# ID~%uint8 id~%~%# Bounding box~%float32 x~%float32 y~%float32 w~%float32 h~%~%# class~%uint8 clss~%~%float32 score~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Tracklet>))
  (cl:+ 0
     1
     4
     4
     4
     4
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Tracklet>))
  "Converts a ROS message object to a list"
  (cl:list 'Tracklet
    (cl:cons ':id (id msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':w (w msg))
    (cl:cons ':h (h msg))
    (cl:cons ':clss (clss msg))
    (cl:cons ':score (score msg))
))
