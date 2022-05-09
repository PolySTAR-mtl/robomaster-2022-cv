;; Auto-generated. Do not edit!


(when (boundp 'detection::Detections)
  (if (not (find-package "DETECTION"))
    (make-package "DETECTION"))
  (shadow 'Detections (find-package "DETECTION")))
(unless (find-package "DETECTION::DETECTIONS")
  (make-package "DETECTION::DETECTIONS"))

(in-package "ROS")
;;//! \htmlinclude Detections.msg.html


(defclass detection::Detections
  :super ros::object
  :slots (_detections _timelapse ))

(defmethod detection::Detections
  (:init
   (&key
    ((:detections __detections) ())
    ((:timelapse __timelapse) 0)
    )
   (send-super :init)
   (setq _detections __detections)
   (setq _timelapse (round __timelapse))
   self)
  (:detections
   (&rest __detections)
   (if (keywordp (car __detections))
       (send* _detections __detections)
     (progn
       (if __detections (setq _detections (car __detections)))
       _detections)))
  (:timelapse
   (&optional __timelapse)
   (if __timelapse (setq _timelapse __timelapse)) _timelapse)
  (:serialization-length
   ()
   (+
    ;; detection/Detection[] _detections
    (apply #'+ (send-all _detections :serialization-length)) 4
    ;; uint32 _timelapse
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; detection/Detection[] _detections
     (write-long (length _detections) s)
     (dolist (elem _detections)
       (send elem :serialize s)
       )
     ;; uint32 _timelapse
       (write-long _timelapse s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; detection/Detection[] _detections
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _detections (let (r) (dotimes (i n) (push (instance detection::Detection :init) r)) r))
     (dolist (elem- _detections)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint32 _timelapse
     (setq _timelapse (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get detection::Detections :md5sum-) "5a80ac5cf722ceea32bf50e93318cacc")
(setf (get detection::Detections :datatype-) "detection/Detections")
(setf (get detection::Detections :definition-)
      "# Detections.msg
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
")



(provide :detection/Detections "5a80ac5cf722ceea32bf50e93318cacc")


