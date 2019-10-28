;;@============================= DISABLE SCROLL, MENU AND  TOOLBAR
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;@============================= MAXIMIZE WINDOW ON STARTUP
;; (defun fullscreen ()
  ;; (interactive)
  ;; (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         ;; '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;; (if (display-graphic-p)
;; (fullscreen)))

;; (w32-send-sys-command 61488)
(toggle-frame-fullscreen)

;;@============================= CURSOR
(blink-cursor-mode 0) 


;;@============================= STARTUP
(setq initial-major-mode 'emacs-lisp-mode)
(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      echo-keystrokes 0.1
      linum-format " %d"
      initial-scratch-message ";; For a moment, nothing happened. Then, after a second or so, nothing continued to happen.\n")

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
;;@============================= CURSOR
(set-cursor-color "#40FF40")

;;@============================= FONT
(add-to-list 'default-frame-alist '(font . "Liberation Mono-11.5"))
(set-face-attribute 'default t :font "Liberation Mono-11.5")

;;@============================= FRINGES
(fringe-mode (quote (1 . 1))) ;; Set fringe style to 'minimal


;;@============================= ORG HEADERS
(defun org-prettify-headers ()
  "Adds strings of headrs to the list of symbols to prettify."
    (mapc (apply-partially 'add-to-list 'prettify-symbols-alist)
          (cl-reduce 'append
                     (mapcar (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                             `(("#+begin_src" . ?✎)
                               ("#+end_src"   . ?□)
			       ("#+name:"   . ?☰)
                               ("#+header:" . ?☰)
                               ("#+begin_quote" . ?»)
                               ("#+end_quote" . ?«)))))
    (turn-on-prettify-symbols-mode))

(add-hook 'org-mode-hook #'org-prettify-headers)



