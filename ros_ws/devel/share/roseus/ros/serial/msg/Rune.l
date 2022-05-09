;; Auto-generated. Do not edit!


(when (boundp 'serial::Rune)
  (if (not (find-package "SERIAL"))
    (make-package "SERIAL"))
  (shadow 'Rune (find-package "SERIAL")))
(unless (find-package "SERIAL::RUNE")
  (make-package "SERIAL::RUNE"))

(in-package "ROS")
;;//! \htmlinclude Rune.msg.html


(defclass serial::Rune
  :super ros::object
  :slots (_stamp ))

(defmethod serial::Rune
  (:init
   (&key
    ((:stamp __stamp) (instance ros::time :init))
    )
   (send-super :init)
   (setq _stamp __stamp)
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:serialization-length
   ()
   (+
    ;; time _stamp
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; time _stamp
       (write-long (send _stamp :sec) s) (write-long (send _stamp :nsec) s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; time _stamp
     (send _stamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _stamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get serial::Rune :md5sum-) "84d365d08d5fc49dde870daba1c7992c")
(setf (get serial::Rune :datatype-) "serial/Rune")
(setf (get serial::Rune :definition-)
      "# Rune.msg
## From CV to CS : Rune coordinates
## DEPRECATED

# Message

time stamp

")



(provide :serial/Rune "84d365d08d5fc49dde870daba1c7992c")


