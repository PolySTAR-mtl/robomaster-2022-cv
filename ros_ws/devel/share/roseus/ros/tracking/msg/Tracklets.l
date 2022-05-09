;; Auto-generated. Do not edit!


(when (boundp 'tracking::Tracklets)
  (if (not (find-package "TRACKING"))
    (make-package "TRACKING"))
  (shadow 'Tracklets (find-package "TRACKING")))
(unless (find-package "TRACKING::TRACKLETS")
  (make-package "TRACKING::TRACKLETS"))

(in-package "ROS")
;;//! \htmlinclude Tracklets.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tracking::Tracklets
  :super ros::object
  :slots (_header _tracklets ))

(defmethod tracking::Tracklets
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:tracklets __tracklets) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _tracklets __tracklets)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:tracklets
   (&rest __tracklets)
   (if (keywordp (car __tracklets))
       (send* _tracklets __tracklets)
     (progn
       (if __tracklets (setq _tracklets (car __tracklets)))
       _tracklets)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; tracking/Tracklet[] _tracklets
    (apply #'+ (send-all _tracklets :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; tracking/Tracklet[] _tracklets
     (write-long (length _tracklets) s)
     (dolist (elem _tracklets)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; tracking/Tracklet[] _tracklets
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tracklets (let (r) (dotimes (i n) (push (instance tracking::Tracklet :init) r)) r))
     (dolist (elem- _tracklets)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get tracking::Tracklets :md5sum-) "b9ec897e27b256c83b04eb795b1db40e")
(setf (get tracking::Tracklets :datatype-) "tracking/Tracklets")
(setf (get tracking::Tracklets :definition-)
      "# Tracklets.msg
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
")



(provide :tracking/Tracklets "b9ec897e27b256c83b04eb795b1db40e")


