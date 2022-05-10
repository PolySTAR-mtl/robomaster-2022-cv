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
  :slots (_id _x _y _w _h _clss _score ))

(defmethod tracking::Tracklet
  (:init
   (&key
    ((:id __id) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:w __w) 0.0)
    ((:h __h) 0.0)
    ((:clss __clss) 0)
    ((:score __score) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _w (float __w))
   (setq _h (float __h))
   (setq _clss (round __clss))
   (setq _score (float __score))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
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
  (:clss
   (&optional __clss)
   (if __clss (setq _clss __clss)) _clss)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:serialization-length
   ()
   (+
    ;; uint8 _id
    1
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _w
    4
    ;; float32 _h
    4
    ;; uint8 _clss
    1
    ;; float32 _score
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _id
       (write-byte _id s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _w
       (sys::poke _w (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _h
       (sys::poke _h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _clss
       (write-byte _clss s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _w
     (setq _w (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _h
     (setq _h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _clss
     (setq _clss (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get tracking::Tracklet :md5sum-) "59fcd37fcd586a2228c557986fc973a2")
(setf (get tracking::Tracklet :datatype-) "tracking/Tracklet")
(setf (get tracking::Tracklet :definition-)
      "# Tracklet.msg
## Bounding box with class

# ID
uint8 id

# Bounding box
float32 x
float32 y
float32 w
float32 h

# class
uint8 clss

float32 score
")



(provide :tracking/Tracklet "59fcd37fcd586a2228c557986fc973a2")


