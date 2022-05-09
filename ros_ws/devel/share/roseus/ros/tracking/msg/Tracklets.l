;; Auto-generated. Do not edit!


(when (boundp 'tracking::Tracklets)
  (if (not (find-package "TRACKING"))
    (make-package "TRACKING"))
  (shadow 'Tracklets (find-package "TRACKING")))
(unless (find-package "TRACKING::TRACKLETS")
  (make-package "TRACKING::TRACKLETS"))

(in-package "ROS")
;;//! \htmlinclude Tracklets.msg.html


(defclass tracking::Tracklets
  :super ros::object
  :slots (_tracklets ))

(defmethod tracking::Tracklets
  (:init
   (&key
    ((:tracklets __tracklets) ())
    )
   (send-super :init)
   (setq _tracklets __tracklets)
   self)
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
    ;; tracking/Tracklet[] _tracklets
    (apply #'+ (send-all _tracklets :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; tracking/Tracklet[] _tracklets
     (write-long (length _tracklets) s)
     (dolist (elem _tracklets)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
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

(setf (get tracking::Tracklets :md5sum-) "eaf004b7dd6cb035732a86956a387ae0")
(setf (get tracking::Tracklets :datatype-) "tracking/Tracklets")
(setf (get tracking::Tracklets :definition-)
      "# Tracklets.msg
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
")



(provide :tracking/Tracklets "eaf004b7dd6cb035732a86956a387ae0")


