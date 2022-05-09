;; Auto-generated. Do not edit!


(when (boundp 'serial::Target)
  (if (not (find-package "SERIAL"))
    (make-package "SERIAL"))
  (shadow 'Target (find-package "SERIAL")))
(unless (find-package "SERIAL::TARGET")
  (make-package "SERIAL::TARGET"))

(in-package "ROS")
;;//! \htmlinclude Target.msg.html


(defclass serial::Target
  :super ros::object
  :slots (_stamp _located _theta _phi _dist ))

(defmethod serial::Target
  (:init
   (&key
    ((:stamp __stamp) (instance ros::time :init))
    ((:located __located) nil)
    ((:theta __theta) 0)
    ((:phi __phi) 0)
    ((:dist __dist) 0)
    )
   (send-super :init)
   (setq _stamp __stamp)
   (setq _located __located)
   (setq _theta (round __theta))
   (setq _phi (round __phi))
   (setq _dist (round __dist))
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:located
   (&optional (__located :null))
   (if (not (eq __located :null)) (setq _located __located)) _located)
  (:theta
   (&optional __theta)
   (if __theta (setq _theta __theta)) _theta)
  (:phi
   (&optional __phi)
   (if __phi (setq _phi __phi)) _phi)
  (:dist
   (&optional __dist)
   (if __dist (setq _dist __dist)) _dist)
  (:serialization-length
   ()
   (+
    ;; time _stamp
    8
    ;; bool _located
    1
    ;; uint16 _theta
    2
    ;; int16 _phi
    2
    ;; uint16 _dist
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; time _stamp
       (write-long (send _stamp :sec) s) (write-long (send _stamp :nsec) s)
     ;; bool _located
       (if _located (write-byte -1 s) (write-byte 0 s))
     ;; uint16 _theta
       (write-word _theta s)
     ;; int16 _phi
       (write-word _phi s)
     ;; uint16 _dist
       (write-word _dist s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; time _stamp
     (send _stamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _stamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _located
     (setq _located (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint16 _theta
     (setq _theta (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _phi
     (setq _phi (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _dist
     (setq _dist (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get serial::Target :md5sum-) "31aff261d89d039028ca56aec375fe72")
(setf (get serial::Target :datatype-) "serial/Target")
(setf (get serial::Target :definition-)
      "# Target.msg
## From CV to CS : Coordinates of the current target

# Message

time stamp
bool located

uint16 theta    # milli-ad
int16 phi       # millirad
uint16 dist     # mm

")



(provide :serial/Target "31aff261d89d039028ca56aec375fe72")


