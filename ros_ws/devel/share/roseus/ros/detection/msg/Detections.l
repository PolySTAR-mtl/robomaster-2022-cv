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
  :slots (_detections ))

(defmethod detection::Detections
  (:init
   (&key
    ((:detections __detections) ())
    )
   (send-super :init)
   (setq _detections __detections)
   self)
  (:detections
   (&rest __detections)
   (if (keywordp (car __detections))
       (send* _detections __detections)
     (progn
       (if __detections (setq _detections (car __detections)))
       _detections)))
  (:serialization-length
   ()
   (+
    ;; detection/Detection[] _detections
    (apply #'+ (send-all _detections :serialization-length)) 4
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
   ;;
   self)
  )

(setf (get detection::Detections :md5sum-) "cafb60d89a040a540def8d31f5cdc037")
(setf (get detection::Detections :datatype-) "detection/Detections")
(setf (get detection::Detections :definition-)
      "# Detections.msg
## List of detected bounding boxes

# Header header
Detection[] detections
================================================================================
MSG: detection/Detection
# Detection.msg
## Bounding box with class and confidence

# Bounding box
float32 x
float32 y
float32 w
float32 h

# class
uint8 clss

float32 score
")



(provide :detection/Detections "cafb60d89a040a540def8d31f5cdc037")


