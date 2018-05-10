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
