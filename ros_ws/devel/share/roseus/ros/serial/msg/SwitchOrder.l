;; Auto-generated. Do not edit!


(when (boundp 'serial::SwitchOrder)
  (if (not (find-package "SERIAL"))
    (make-package "SERIAL"))
  (shadow 'SwitchOrder (find-package "SERIAL")))
(unless (find-package "SERIAL::SWITCHORDER")
  (make-package "SERIAL::SWITCHORDER"))

(in-package "ROS")
;;//! \htmlinclude SwitchOrder.msg.html


(intern "*ORDER_NOTHING*" (find-package "SERIAL::SWITCHORDER"))
(shadow '*ORDER_NOTHING* (find-package "SERIAL::SWITCHORDER"))
(defconstant serial::SwitchOrder::*ORDER_NOTHING* 0)
(intern "*ORDER_NEXT*" (find-package "SERIAL::SWITCHORDER"))
(shadow '*ORDER_NEXT* (find-package "SERIAL::SWITCHORDER"))
(defconstant serial::SwitchOrder::*ORDER_NEXT* 1)
(intern "*ORDER_RIGHT*" (find-package "SERIAL::SWITCHORDER"))
(shadow '*ORDER_RIGHT* (find-package "SERIAL::SWITCHORDER"))
(defconstant serial::SwitchOrder::*ORDER_RIGHT* 2)
(intern "*ORDER_LEFT*" (find-package "SERIAL::SWITCHORDER"))
(shadow '*ORDER_LEFT* (find-package "SERIAL::SWITCHORDER"))
(defconstant serial::SwitchOrder::*ORDER_LEFT* 3)

(defun serial::SwitchOrder-to-symbol (const)
  (cond
        ((= const 0) 'serial::SwitchOrder::*ORDER_NOTHING*)
        ((= const 1) 'serial::SwitchOrder::*ORDER_NEXT*)
        ((= const 2) 'serial::SwitchOrder::*ORDER_RIGHT*)
        ((= const 3) 'serial::SwitchOrder::*ORDER_LEFT*)
        (t nil)))

(defclass serial::SwitchOrder
  :super ros::object
  :slots (_stamp _order ))

(defmethod serial::SwitchOrder
  (:init
   (&key
    ((:stamp __stamp) (instance ros::time :init))
    ((:order __order) 0)
    )
   (send-super :init)
   (setq _stamp __stamp)
   (setq _order (round __order))
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:order
   (&optional __order)
   (if __order (setq _order __order)) _order)
  (:serialization-length
   ()
   (+
    ;; time _stamp
    8
    ;; uint8 _order
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; time _stamp
       (write-long (send _stamp :sec) s) (write-long (send _stamp :nsec) s)
     ;; uint8 _order
       (write-byte _order s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; time _stamp
     (send _stamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _stamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _order
     (setq _order (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get serial::SwitchOrder :md5sum-) "7c80d636f2699ea2200782ffddcd7acc")
(setf (get serial::SwitchOrder :datatype-) "serial/SwitchOrder")
(setf (get serial::SwitchOrder :definition-)
      "# SwitchOrder.msg
## From CS to CV : switch to a different target

# Constants

uint8 ORDER_NOTHING=0
uint8 ORDER_NEXT=1
uint8 ORDER_RIGHT=2
uint8 ORDER_LEFT=3

# Message

time stamp
uint8 order

")



(provide :serial/SwitchOrder "7c80d636f2699ea2200782ffddcd7acc")


