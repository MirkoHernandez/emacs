;;@============================= DISABLE SCROLL, MENU AND  TOOLBAR
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(package-initialize)

;;@============================= MAXIMIZE WINDOW ON STARTUP
;; (defun fullscreen ()
  ;; (interactive)
  ;; (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         ;; '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;; (if (display-graphic-p)
;; (fullscreen)))

;; (w32-send-sys-command 61488)

(setq inhibit-startup-message t)
(toggle-frame-fullscreen)

;;@============================= Set paths

(defvar emacs-root (if (or (eq system-type 'cygwin)
                           (eq system-type 'gnu/linux)
                           (eq system-type 'linux))
                       (concat "/home/" (getenv "USER") "/" )
                     (concat "c:/" (getenv "USERNAME") "/")))

(cl-labels ((add-path (p)
		      (add-to-list 'load-path
				   (concat emacs-root p))))
  (add-path "emacs/lisp")
  (add-path "emacs/site-lisp"))

;;@============================= Install Packages
;; (load-library "packages-setup")

;;@============================= Load Config 
(load-library "settings")

;;@============================= Load Modes config
(load-library "look")
(load-library "modes-config")
;;(load-library "efuncs")
(load-library "site-efuncs")
(load-library "c-config")
;;(load-library "c-compilation-config")
;; (load-library "go-config")
(load-library "hydras")

;;@============================= Load Key-bindings
(load-library "keys-modes")
(load-library "keys")
;; (load-library "keychords")
;;@============================= Load Defuns
(dolist (file (directory-files (expand-file-name "emacs/defuns" emacs-root) t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;;@============================= Misc
(load-library "misc")
;;@============================= Shell
;; (shell)

