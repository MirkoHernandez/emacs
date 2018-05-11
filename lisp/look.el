;;@============================= DISABLE SCROLL, MENU AND  TOOLBAR
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;@============================= MAXIMIZE WINDOW ON STARTUP

;; (defun fullscreen ()
  ;; (interactive)
  ;; (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         ;; '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;; (fullscreen)
;; (if (display-graphic-p)
;; (fullscreen)))


;;@============================= CURSOR
(blink-cursor-mode 0) 

;;@============================= STARTUP
(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      echo-keystrokes 0.1
      linum-format " %d"
      initial-scratch-message "For a moment, nothing happened. Then,
      after a second or so, nothing continued to happen.\n")

(setq inhibit-startup-message t);; no startup message
(fset 'yes-or-no-p #'y-or-n-p)

;;@============================= HIGHLIGHT NOTES, TODOS
 (setq fixme-modes '(c++-mode c-mode emacs-lisp-mode go-mode
			      python-mode js2-mode html-mode))
 (make-face 'font-lock-fixme-face)
 (make-face 'font-lock-note-face)
 (mapc (lambda (mode)
	 (font-lock-add-keywords
	  mode
	  '(("\\<\\(TODO:\\)" 1 'font-lock-fixme-face t)
            ("\\<\\(NOTE:\\)" 1 'font-lock-note-face t))))
	fixme-modes)
 (modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
 (modify-face 'font-lock-note-face "Light Blue" nil nil t nil t nil nil)

;;@============================= THEME
(load-theme 'zenburn t)

;;@============================= HL-LINE
(global-hl-line-mode 1)
(set-face-background 'hl-line "midnight blue")
