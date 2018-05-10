;;@============================= MISC

(delete-selection-mode 1)
(transient-mark-mode 1)
(blink-cursor-mode 1)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      echo-keystrokes 0.1
      linum-format " %d"
      initial-scratch-message "For a moment, nothing happened. Then, after a second or so, nothing continued to happen.\n")
(fset 'yes-or-no-p #'y-or-n-p)
(fset 'display-startup-echo-area-message #'ignore)


;; xcscope
;; (require 'xcscope)
;; (cscope-setup)
;; (setq cscope-program "cscope")


