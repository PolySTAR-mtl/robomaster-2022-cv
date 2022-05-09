
(cl:in-package :asdf)

(defsystem "serial-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "HP" :depends-on ("_package_HP"))
    (:file "_package_HP" :depends-on ("_package"))
    (:file "Rune" :depends-on ("_package_Rune"))
    (:file "_package_Rune" :depends-on ("_package"))
    (:file "SwitchOrder" :depends-on ("_package_SwitchOrder"))
    (:file "_package_SwitchOrder" :depends-on ("_package"))
    (:file "Target" :depends-on ("_package_Target"))
    (:file "_package_Target" :depends-on ("_package"))
  ))