;; Auto-generated. Do not edit!


(when (boundp 'serial::HP)
  (if (not (find-package "SERIAL"))
    (make-package "SERIAL"))
  (shadow 'HP (find-package "SERIAL")))
(unless (find-package "SERIAL::HP")
  (make-package "SERIAL::HP"))

(in-package "ROS")
;;//! \htmlinclude HP.msg.html


(defclass serial::HP
  :super ros::object
  :slots (_foe_hero _foe_standard1 _foe_standard2 _foe_sentry _ally_hero _ally_standard1 _ally_standard2 _ally_sentry ))

(defmethod serial::HP
  (:init
   (&key
    ((:foe_hero __foe_hero) 0)
    ((:foe_standard1 __foe_standard1) 0)
    ((:foe_standard2 __foe_standard2) 0)
    ((:foe_sentry __foe_sentry) 0)
    ((:ally_hero __ally_hero) 0)
    ((:ally_standard1 __ally_standard1) 0)
    ((:ally_standard2 __ally_standard2) 0)
    ((:ally_sentry __ally_sentry) 0)
    )
   (send-super :init)
   (setq _foe_hero (round __foe_hero))
   (setq _foe_standard1 (round __foe_standard1))
   (setq _foe_standard2 (round __foe_standard2))
   (setq _foe_sentry (round __foe_sentry))
   (setq _ally_hero (round __ally_hero))
   (setq _ally_standard1 (round __ally_standard1))
   (setq _ally_standard2 (round __ally_standard2))
   (setq _ally_sentry (round __ally_sentry))
   self)
  (:foe_hero
   (&optional __foe_hero)
   (if __foe_hero (setq _foe_hero __foe_hero)) _foe_hero)
  (:foe_standard1
   (&optional __foe_standard1)
   (if __foe_standard1 (setq _foe_standard1 __foe_standard1)) _foe_standard1)
  (:foe_standard2
   (&optional __foe_standard2)
   (if __foe_standard2 (setq _foe_standard2 __foe_standard2)) _foe_standard2)
  (:foe_sentry
   (&optional __foe_sentry)
   (if __foe_sentry (setq _foe_sentry __foe_sentry)) _foe_sentry)
  (:ally_hero
   (&optional __ally_hero)
   (if __ally_hero (setq _ally_hero __ally_hero)) _ally_hero)
  (:ally_standard1
   (&optional __ally_standard1)
   (if __ally_standard1 (setq _ally_standard1 __ally_standard1)) _ally_standard1)
  (:ally_standard2
   (&optional __ally_standard2)
   (if __ally_standard2 (setq _ally_standard2 __ally_standard2)) _ally_standard2)
  (:ally_sentry
   (&optional __ally_sentry)
   (if __ally_sentry (setq _ally_sentry __ally_sentry)) _ally_sentry)
  (:serialization-length
   ()
   (+
    ;; uint16 _foe_hero
    2
    ;; uint16 _foe_standard1
    2
    ;; uint16 _foe_standard2
    2
    ;; uint16 _foe_sentry
    2
    ;; uint16 _ally_hero
    2
    ;; uint16 _ally_standard1
    2
    ;; uint16 _ally_standard2
    2
    ;; uint16 _ally_sentry
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _foe_hero
       (write-word _foe_hero s)
     ;; uint16 _foe_standard1
       (write-word _foe_standard1 s)
     ;; uint16 _foe_standard2
       (write-word _foe_standard2 s)
     ;; uint16 _foe_sentry
       (write-word _foe_sentry s)
     ;; uint16 _ally_hero
       (write-word _ally_hero s)
     ;; uint16 _ally_standard1
       (write-word _ally_standard1 s)
     ;; uint16 _ally_standard2
       (write-word _ally_standard2 s)
     ;; uint16 _ally_sentry
       (write-word _ally_sentry s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _foe_hero
     (setq _foe_hero (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _foe_standard1
     (setq _foe_standard1 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _foe_standard2
     (setq _foe_standard2 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _foe_sentry
     (setq _foe_sentry (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ally_hero
     (setq _ally_hero (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ally_standard1
     (setq _ally_standard1 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ally_standard2
     (setq _ally_standard2 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _ally_sentry
     (setq _ally_sentry (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get serial::HP :md5sum-) "2f1de7f65b9e758a9b89a73d0d3bd446")
(setf (get serial::HP :datatype-) "serial/HP")
(setf (get serial::HP :definition-)
      "# Rune.msg
## From CS to CV : Health points of all robots

# Message

uint16 foe_hero
uint16 foe_standard1
uint16 foe_standard2
uint16 foe_sentry

uint16 ally_hero
uint16 ally_standard1
uint16 ally_standard2
uint16 ally_sentry

")



(provide :serial/HP "2f1de7f65b9e758a9b89a73d0d3bd446")


