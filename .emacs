;;@============================= STARTUP
(setq inhibit-startup-message t);; no startup message
(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      echo-keystrokes 0.1
      linum-format " %d"
      initial-scratch-message ";; For a moment, nothing happened. Then, after a second or so, nothing continued to happen.\n")
(setq initial-major-mode 'emacs-lisp-mode)

;;@============================= Set paths
(defvar emacs-root (if (or (eq system-type 'cygwin)
                           (eq system-type 'gnu/linux)
                           (eq system-type 'linux))
                       (concat "/home/" (getenv "USER") "/var/" )
                     (concat "c:/" (getenv "USERNAME") "/")))

(when  (getenv "EMACSROOT")
  (setq emacs-root (getenv "EMACSROOT"))) 

(require 'cl)
(cl-labels ((add-path (p)
		      (add-to-list 'load-path
				   (concat emacs-root p))))
  (add-path "emacs/settings"))

(package-initialize)

;;@============================= Install Packages
;; (load-library "packages-setup")

;;@============================= Load Emacs Setup

(load-library "setup-emacs")
(load-library "appereance")
(load-library "setup-org")
(load-library "setup-completion")
(load-library "setup-ediff")
(load-library "setup-engine")
(load-library "setup-html")
(load-library "setup-magit")
(load-library "setup-yasnippets")
(load-library "setup-perspective")
(load-library "setup-utils")

;;@============================= Programming Modes  Setup
(load-library "setup-prog")
(load-library "setup-elisp")
(load-library "setup-cc")
;; (load-library "setup-hydra")
;; (load-library "setup-go")
;; (load-library "setup-html")
;; (load-library "setup-phython")
;; (load-library "setup-javascript")

;;@============================= Load Key-bindings
(load-library "key-bindings")
(load-library "key-bindings-modes")
;; (load-library "keychords")
;;@============================= Load Defuns
(dolist (file (directory-files (expand-file-name "emacs/defuns" emacs-root) t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;;@============================= Misc
(load (concat emacs-root "emacs/misc.el"))

;;@============================= Shell
;; (shell)
