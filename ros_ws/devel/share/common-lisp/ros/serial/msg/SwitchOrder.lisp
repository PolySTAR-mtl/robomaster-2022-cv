; Auto-generated. Do not edit!


(cl:in-package serial-msg)


;//! \htmlinclude SwitchOrder.msg.html

(cl:defclass <SwitchOrder> (roslisp-msg-protocol:ros-message)
  ((stamp
    :reader stamp
    :initarg :stamp
    :type cl:real
    :initform 0)
   (order
    :reader order
    :initarg :order
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SwitchOrder (<SwitchOrder>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SwitchOrder>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SwitchOrder)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name serial-msg:<SwitchOrder> is deprecated: use serial-msg:SwitchOrder instead.")))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <SwitchOrder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:stamp-val is deprecated.  Use serial-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'order-val :lambda-list '(m))
(cl:defmethod order-val ((m <SwitchOrder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:order-val is deprecated.  Use serial-msg:order instead.")
  (order m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SwitchOrder>)))
    "Constants for message type '<SwitchOrder>"
  '((:ORDER_NOTHING . 0)
    (:ORDER_NEXT . 1)
    (:ORDER_RIGHT . 2)
    (:ORDER_LEFT . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SwitchOrder)))
    "Constants for message type 'SwitchOrder"
  '((:ORDER_NOTHING . 0)
    (:ORDER_NEXT . 1)
    (:ORDER_RIGHT . 2)
    (:ORDER_LEFT . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SwitchOrder>) ostream)
  "Serializes a message object of type '<SwitchOrder>"
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'stamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'stamp) (cl:floor (cl:slot-value msg 'stamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'order)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SwitchOrder>) istream)
  "Deserializes a message object of type '<SwitchOrder>"
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'stamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'order)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SwitchOrder>)))
  "Returns string type for a message object of type '<SwitchOrder>"
  "serial/SwitchOrder")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SwitchOrder)))
  "Returns string type for a message object of type 'SwitchOrder"
  "serial/SwitchOrder")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SwitchOrder>)))
  "Returns md5sum for a message object of type '<SwitchOrder>"
  "7c80d636f2699ea2200782ffddcd7acc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SwitchOrder)))
  "Returns md5sum for a message object of type 'SwitchOrder"
  "7c80d636f2699ea2200782ffddcd7acc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SwitchOrder>)))
  "Returns full string definition for message of type '<SwitchOrder>"
  (cl:format cl:nil "# SwitchOrder.msg~%## From CS to CV : switch to a different target~%~%# Constants~%~%uint8 ORDER_NOTHING=0~%uint8 ORDER_NEXT=1~%uint8 ORDER_RIGHT=2~%uint8 ORDER_LEFT=3~%~%# Message~%~%time stamp~%uint8 order~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SwitchOrder)))
  "Returns full string definition for message of type 'SwitchOrder"
  (cl:format cl:nil "# SwitchOrder.msg~%## From CS to CV : switch to a different target~%~%# Constants~%~%uint8 ORDER_NOTHING=0~%uint8 ORDER_NEXT=1~%uint8 ORDER_RIGHT=2~%uint8 ORDER_LEFT=3~%~%# Message~%~%time stamp~%uint8 order~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SwitchOrder>))
  (cl:+ 0
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SwitchOrder>))
  "Converts a ROS message object to a list"
  (cl:list 'SwitchOrder
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':order (order msg))
))
