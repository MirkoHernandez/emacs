(package-initialize)

;;@============================= Emacs root

(defvar emacs-root (if (or (eq system-type 'cygwin)
                           (eq system-type 'gnu/linux)
                           (eq system-type 'linux))
                       (concat "/home/" (getenv "USER") "/" )
                     (concat "c:/" (getenv "USERNAME") "/")))

       
;;@============================= Set paths
(cl-labels ((add-path (p)
		      (add-to-list 'load-path
				   (concat emacs-root p))))
  (add-path "emacs/lisp")
  (add-path "emacs/site-lisp"))


;;@============================= Load Config 
(load-library "settings")
(load-library "keybinding")

;;@============================= Install Packages
(load-library "packages-setup")

;;@============================= Load Modes config
(load-library "look")
(load-library "modes-config")
(load-library "c-config")
(load-library "c-compilation-config")
(load-library "go-config")
(load-library "efuncs")
(load-library "site-efuncs")
(load-library "keybinding_mode_specific")
(load-library "keychords")
;;@============================= Misc
(load-library "misc")
;;@============================= Shell
;; (shell)

