; Auto-generated. Do not edit!


(cl:in-package serial-msg)


;//! \htmlinclude HP.msg.html

(cl:defclass <HP> (roslisp-msg-protocol:ros-message)
  ((foe_hero
    :reader foe_hero
    :initarg :foe_hero
    :type cl:fixnum
    :initform 0)
   (foe_standard1
    :reader foe_standard1
    :initarg :foe_standard1
    :type cl:fixnum
    :initform 0)
   (foe_standard2
    :reader foe_standard2
    :initarg :foe_standard2
    :type cl:fixnum
    :initform 0)
   (foe_sentry
    :reader foe_sentry
    :initarg :foe_sentry
    :type cl:fixnum
    :initform 0)
   (ally_hero
    :reader ally_hero
    :initarg :ally_hero
    :type cl:fixnum
    :initform 0)
   (ally_standard1
    :reader ally_standard1
    :initarg :ally_standard1
    :type cl:fixnum
    :initform 0)
   (ally_standard2
    :reader ally_standard2
    :initarg :ally_standard2
    :type cl:fixnum
    :initform 0)
   (ally_sentry
    :reader ally_sentry
    :initarg :ally_sentry
    :type cl:fixnum
    :initform 0))
)

(cl:defclass HP (<HP>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HP>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HP)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name serial-msg:<HP> is deprecated: use serial-msg:HP instead.")))

(cl:ensure-generic-function 'foe_hero-val :lambda-list '(m))
(cl:defmethod foe_hero-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:foe_hero-val is deprecated.  Use serial-msg:foe_hero instead.")
  (foe_hero m))

(cl:ensure-generic-function 'foe_standard1-val :lambda-list '(m))
(cl:defmethod foe_standard1-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:foe_standard1-val is deprecated.  Use serial-msg:foe_standard1 instead.")
  (foe_standard1 m))

(cl:ensure-generic-function 'foe_standard2-val :lambda-list '(m))
(cl:defmethod foe_standard2-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:foe_standard2-val is deprecated.  Use serial-msg:foe_standard2 instead.")
  (foe_standard2 m))

(cl:ensure-generic-function 'foe_sentry-val :lambda-list '(m))
(cl:defmethod foe_sentry-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:foe_sentry-val is deprecated.  Use serial-msg:foe_sentry instead.")
  (foe_sentry m))

(cl:ensure-generic-function 'ally_hero-val :lambda-list '(m))
(cl:defmethod ally_hero-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:ally_hero-val is deprecated.  Use serial-msg:ally_hero instead.")
  (ally_hero m))

(cl:ensure-generic-function 'ally_standard1-val :lambda-list '(m))
(cl:defmethod ally_standard1-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:ally_standard1-val is deprecated.  Use serial-msg:ally_standard1 instead.")
  (ally_standard1 m))

(cl:ensure-generic-function 'ally_standard2-val :lambda-list '(m))
(cl:defmethod ally_standard2-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:ally_standard2-val is deprecated.  Use serial-msg:ally_standard2 instead.")
  (ally_standard2 m))

(cl:ensure-generic-function 'ally_sentry-val :lambda-list '(m))
(cl:defmethod ally_sentry-val ((m <HP>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial-msg:ally_sentry-val is deprecated.  Use serial-msg:ally_sentry instead.")
  (ally_sentry m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HP>) ostream)
  "Serializes a message object of type '<HP>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_hero)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_hero)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_standard1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_standard1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_standard2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_standard2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_sentry)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_sentry)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_hero)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_hero)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_standard1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_standard1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_standard2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_standard2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_sentry)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_sentry)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HP>) istream)
  "Deserializes a message object of type '<HP>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_hero)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_hero)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_standard1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_standard1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_standard2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_standard2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'foe_sentry)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'foe_sentry)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_hero)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_hero)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_standard1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_standard1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_standard2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_standard2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ally_sentry)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ally_sentry)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HP>)))
  "Returns string type for a message object of type '<HP>"
  "serial/HP")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HP)))
  "Returns string type for a message object of type 'HP"
  "serial/HP")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HP>)))
  "Returns md5sum for a message object of type '<HP>"
  "2f1de7f65b9e758a9b89a73d0d3bd446")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HP)))
  "Returns md5sum for a message object of type 'HP"
  "2f1de7f65b9e758a9b89a73d0d3bd446")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HP>)))
  "Returns full string definition for message of type '<HP>"
  (cl:format cl:nil "# Rune.msg~%## From CS to CV : Health points of all robots~%~%# Message~%~%uint16 foe_hero~%uint16 foe_standard1~%uint16 foe_standard2~%uint16 foe_sentry~%~%uint16 ally_hero~%uint16 ally_standard1~%uint16 ally_standard2~%uint16 ally_sentry~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HP)))
  "Returns full string definition for message of type 'HP"
  (cl:format cl:nil "# Rune.msg~%## From CS to CV : Health points of all robots~%~%# Message~%~%uint16 foe_hero~%uint16 foe_standard1~%uint16 foe_standard2~%uint16 foe_sentry~%~%uint16 ally_hero~%uint16 ally_standard1~%uint16 ally_standard2~%uint16 ally_sentry~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HP>))
  (cl:+ 0
     2
     2
     2
     2
     2
     2
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HP>))
  "Converts a ROS message object to a list"
  (cl:list 'HP
    (cl:cons ':foe_hero (foe_hero msg))
    (cl:cons ':foe_standard1 (foe_standard1 msg))
    (cl:cons ':foe_standard2 (foe_standard2 msg))
    (cl:cons ':foe_sentry (foe_sentry msg))
    (cl:cons ':ally_hero (ally_hero msg))
    (cl:cons ':ally_standard1 (ally_standard1 msg))
    (cl:cons ':ally_standard2 (ally_standard2 msg))
    (cl:cons ':ally_sentry (ally_sentry msg))
))
