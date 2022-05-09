
(cl:in-package :asdf)

(defsystem "tracking-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Tracklet" :depends-on ("_package_Tracklet"))
    (:file "_package_Tracklet" :depends-on ("_package"))
    (:file "Tracklets" :depends-on ("_package_Tracklets"))
    (:file "_package_Tracklets" :depends-on ("_package"))
  ))