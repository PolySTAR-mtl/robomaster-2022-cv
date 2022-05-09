;; Auto-generated. Do not edit!


(when (boundp 'tracking::Tracklet)
  (if (not (find-package "TRACKING"))
    (make-package "TRACKING"))
  (shadow 'Tracklet (find-package "TRACKING")))
(unless (find-package "TRACKING::TRACKLET")
  (make-package "TRACKING::TRACKLET"))

(in-package "ROS")
;;//! \htmlinclude Tracklet.msg.html


(defclass tracking::Tracklet
  :super ros::object
  :slots (_x _y _w _h _cls _confidence ))

(defmethod tracking::Tracklet
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:w __w) 0.0)
    ((:h __h) 0.0)
    ((:cls __cls) 0)
    ((:confidence __confidence) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _w (float __w))
   (setq _h (float __h))
   (setq _cls (round __cls))
   (setq _confidence (float __confidence))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:w
   (&optional __w)
   (if __w (setq _w __w)) _w)
  (:h
   (&optional __h)
   (if __h (setq _h __h)) _h)
  (:cls
   (&optional __cls)
   (if __cls (setq _cls __cls)) _cls)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _w
    4
    ;; float32 _h
    4
    ;; uint8 _cls
    1
    ;; float32 _confidence
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _w
       (sys::poke _w (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _h
       (sys::poke _h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _cls
       (write-byte _cls s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _w
     (setq _w (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _h
     (setq _h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _cls
     (setq _cls (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get tracking::Tracklet :md5sum-) "b6ef12160302895f4532528b12bd7ec3")
(setf (get tracking::Tracklet :datatype-) "tracking/Tracklet")
(setf (get tracking::Tracklet :definition-)
      "# Tracklet.msg
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



(provide :tracking/Tracklet "b6ef12160302895f4532528b12bd7ec3")


