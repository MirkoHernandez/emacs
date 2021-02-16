;;@============================= CURSOR
(blink-cursor-mode 0) 

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
(load-theme 'gruvbox-dark-medium t)

;;@============================= HL-LINE
(global-hl-line-mode t)
(set-face-background 'hl-line "midnight blue")
;;@============================= BEACON
(beacon-mode 1)

;;@============================= CURSOR
(set-cursor-color "#40FF40")

;;@============================= FONT
(when (member "Liberation Mono" (font-family-list))
  (add-to-list 'default-frame-alist '(font . "Liberation Mono-11.5"))
  (set-face-attribute 'default nil :font "Liberation Mono-11.5"))

;;@============================= MOUSE


;;@============================= MODELINE
(when (display-graphic-p)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(setq mode-line-cleaner-alist
  `((auto-complete-mode . "")
    (yas-minor-mode-major-mode . "")
    (yas-minor-mode . "")
    (ivy-mode . "")
    (rainbow-mode . "")
    (paredit-mode . " π")
    (outline-mode . "")
    (outline-minor-mode . "")
    (hs-minor-mode . "")
    (which-key-mode . "")
    (eldoc-mode . "")
    (abbrev-mode . "")
    ;; Major modes
    (lisp-interaction-mode . "λ")
    (hi-lock-mode . "")
    (python-mode . "Py")
    (emacs-lisp-mode . "EL")
    (nxhtml-mode . "nx")))


(defun clean-mode-line ()
  (interactive)
  (cl-loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
	       (setq mode-name mode-str)))))
(add-hook 'after-change-major-mode-hook 'clean-mode-line)



;;@============================= FRINGES
(when (display-graphic-p)
  (fringe-mode (quote (9 . 1)))) ;; Set fringe style to 'minimal

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
(setq org-ellipsis "⤵")
(add-hook 'org-mode-hook 'org-prettify-headers)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; Org Headers
(custom-theme-set-faces 'user
			`(org-default ((t (:foreground "lightskyblue"))))
                        `(org-level-2 ((t (:foreground "lightskyblue"))))
			`(org-target ((t (:foreground "#fe8019"))))
			`(org-tag ((t (:foreground "#2ec09c")))))


;; Different noweb markers. 
;; org-babel-noweb-wrap-start: "<<<"
;; org-babel-noweb-wrap-end: ">>>"

;; Org markers
(setq org-hide-emphasis-markers t)
;; hide target  "<< >>" characters (different font for  noweb references  in  code blocks).
(defun org-add-my-extra-fonts ()
  "Add alert and overdue fonts."
  (add-to-list 'org-font-lock-extra-keywords
	       '("\\(<<\\)\\([^\n\r\t]+\\)\\(>>\\)"
		 (1 '(face org-target invisible t))
		 (2 'org-target t) (3 '(face org-target invisible t))) t)
  (add-to-list 'org-font-lock-extra-keywords
	       '("^\\(<<\\)\\([^\n\r\t]+\\)\\(>>\\)$"
		 (1 '(face org-default visible t))
		 (2 'org-default t) (3 '(face org-default visible t))) t)
  
  
  )
(add-hook 'org-font-lock-set-keywords-hook #'org-add-my-extra-fonts)
