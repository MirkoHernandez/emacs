
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
(global-hl-line-mode 1)
(set-face-background 'hl-line "midnight blue")
;;@============================= BEACON
(beacon-mode 1)

;;@============================= CURSOR
(set-cursor-color "#40FF40")

;;@============================= FONT
(add-to-list 'default-frame-alist '(font . "Liberation Mono-11.5"))
(set-face-attribute 'default t :font "Liberation Mono-11.5")
;;@============================= MOUSE


;;@============================= MODELINE
(when (display-graphic-p)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

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

;; Org Headers
(custom-theme-set-faces 'user
			`(org-default ((t (:foreground "lightskyblue"))))
                        `(org-level-2 ((t (:foreground "lightskyblue"))))
			`(org-tag ((t (:foreground "#2ec09c")))))

;; Org markers
(setq org-hide-emphasis-markers t)

;; hide link  "<< >>" characters 
(defcustom org-hidden-links-additional-re "\\(<<\\)[[:alnum:]]+\\(>>\\)"
  "Regular expression that matches strings where the invisible-property of the sub-matches 1 and 2 is set to org-link."
  :type '(choice (const :tag "Off" nil) regexp)
  :group 'org-link)

(make-variable-buffer-local 'org-hidden-links-additional-re)

(defun org-activate-hidden-links-additional (limit)
  "Put invisible-property org-link on strings matching `org-hide-links-additional-re'."
  (if org-hidden-links-additional-re
      (re-search-forward org-hidden-links-additional-re limit t)
    (goto-char limit)
    nil))

(defun org-hidden-links-hook-function ()
  "Add rule for `org-activate-hidden-links-additional' to `org-font-lock-extra-keywords'.
You can include this function in `org-font-lock-set-keywords-hook'."
  (add-to-list 'org-font-lock-extra-keywords
	       '(org-activate-hidden-links-additional
		 (1 '(face org-target invisible org-link))
                (2 '(face org-target invisible org-link)))))

(add-hook 'org-font-lock-set-keywords-hook #'org-hidden-links-hook-function)


