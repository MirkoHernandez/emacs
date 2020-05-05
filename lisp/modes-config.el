;;@============================= DABBREV
;; (setq dabbrev-case-replace t)
;; (setq dabbrev-case-fold-search t)
;; (setq dabbrev-upcase-means-case-search t)

;;@============================= DIRED

(add-hook 'dired-mode-hook (lambda ()
			     (put 'dired-find-alternate-file 'disabled nil)
			     (dired-hide-details-mode)
			     (dired-sort-toggle-or-edit)
			     (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) 
			     (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
			     ))

;;@============================= PROG-MODE
(require 'smartparens-config)
(add-hook 'prog-mode-hook (lambda ()
			    ;; (smartparens-mode)
			    (electric-pair-mode)
			    ;; (toggle-input-method)
			    ))

;;@============================= MINIBUFFER
;; M-x
(add-hook 'minibuffer-setup-hook (lambda ()
					   ;; (toggle-input-method)
					   ))
(add-hook 'helm-minor-mode-hook (lambda ()
					   ;; (toggle-input-method)
					   ))

(add-hook 'helm-minor-mode-hook (lambda ()
					   ;; (toggle-input-method)
					   ))


;;@============================= IBUFFER
(setq ibuffer-default-sorting-mode 'major-mode)

;;@============================= IDO-UBIQUITOUS
;; (ido-ubiquitous-mode 1)

;;@============================= SMEX

;; smex, remember recently and most frequently usedr commands

;; (require   'smex)
;; (smex-initialize)

;;@============================= IVY
(ivy-mode)

(setq ivy-use-virtual-buffers nil) 
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-height 15)
;; No regex 
;; (setq ivy-initial-inputs-alist nil)

(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
	(swiper-isearch . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))

(setq ivy-display-style 'fancy)

(ivy-set-actions
 'counsel-find-file
 '(("j" find-file-other-window "other window")
   ("b" counsel-find-file-cd-bookmark-action "cd bookmark")
   ("x" counsel-find-file-extern "open externally")
   ("d" delete-file "delete")
   ("r" counsel-find-file-as-root "open as root")))

(ivy-set-actions
 'ivy-switch-buffer
 '(("j" switch-to-buffer-other-window "other window")
   ("k" kill-buffer "kill")
   ("r" ivy--rename-buffer-action "rename")))

(with-eval-after-load 'counsel
  (let ((done (where-is-internal #'ivy-done     ivy-minibuffer-map t)))
    (define-key ivy-minibuffer-map done #'ivy-alt-done)))


;;@============================= PROJECTILE
(projectile-global-mode t)

;;@============================= YASNIPEPTS
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs
	     (concat emacs-root "emacs/snippets"))
(yas-global-mode 1)

;;@============================= COMPANY
(require 'company)                                   
(require 'company-web-html)                          ; load company mode html backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;;@============================= HTML
(add-hook 'html-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-web-html))
			    (hs-minor-mode t)
                            (company-mode t)
                            (emmet-mode t)))
(setq emmet-preview-default nil)

;; Fix XML folding
(add-to-list 'hs-special-modes-alist
             (list 'nxml-mode
                   "<!--\\|<[^/>]*[^/]>"
                   "-->\\|</[^/>]*[^/]>"
                   "<!--"
                   'nxml-forward-element
                   nil))

;; Fix HTML folding
(dolist (mode '(sgml-mode
                html-mode
                html-erb-mode))
  (add-to-list 'hs-special-modes-alist
               (list mode
                     "<!--\\|<[^/>]*[^/]>"
                     "-->\\|</[^/>]*[^/]>"
                     "<!--"
                     'sgml-skip-tag-forward
                     nil)))

;;@============================= COMMON LISP
(setq inferior-lisp-program "sbcl")


;;@============================= EMACS LISP
(require 'ac-slime)
(add-hook 'emacs-lisp-mode-hook (lambda ()
				  ;; enable autocomplete
				  (require 'auto-complete-config)
				  (ac-config-default)
				  (global-auto-complete-mode t)
				  (auto-complete-mode t)
				  (outline-minor-mode)
				  (rainbow-mode)
				  (setq outline-regexp ";;@")
				  (diff-hl-mode t)))
(add-hook 'slime-mode-hook 'set-up-slime-ac)
;;@============================= RACKET
(add-hook 'racket-mode-hook (lambda ()
			      (outline-minor-mode)
			      (setq outline-regexp ";;@")
			      (diff-hl-mode t)))

;;@============================= KEYCHORD
(key-chord-mode 1)
(defvar key-chord-two-keys-delay 0.1)   ; 0.05 or 0.1
(defvar key-chord-one-key-delay 0.08)

;;@============================= JAVASCRIPT
(require 'js-comint)
(add-hook 'js2-mode-hook (lambda ()
			   (abbrev-mode t)
			   (ac-js2-mode t)
			   (hs-minor-mode t)))

(setq inferior-js-program-command "node")
(setq inferior-js-program-arguments '("--interactive"))
;;@============================= TYPESCRIPT
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (company-mode t)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)


;;@============================= GIMP
;; git clone git://github.com/pft/gimpmode.git
(load-if-exists (concat emacs-root  "emacs/packages/gimpmode/gimp-init.el"))

;;@============================= PYTHON
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(setq flymake-python-pyflakes-executable "flake8")

(setq python-shell-interpreter "python3.5")

(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      ;; (skip-chars-forward "    ")
       (skip-chars-forward "\t ")
      ;; (skip-chars-forward "@")
      (current-column))))


(defun python-outline-level ()
  (or
   ;; Commented outline heading
   (and (string-match (rx
               (* space)
               (one-or-more (syntax comment-start))
               (one-or-more space)
               (group (one-or-more "\*"))
               (one-or-more space))
              (match-string 0))
    (- (match-end 0) (match-beginning 0)))

   ;; Python keyword heading, set by number of indentions
   ;; Add 8 (the highest standard outline level) to every Python keyword heading
   (+ 8 (- (match-end 0) (match-beginning 0)))))


(add-hook 'python-mode-hook (lambda ()
			      ;; (setq outline-regexp python-outline-regexp)
			      (setq outline-level 'py-outline-level)
			      (outline-minor-mode)
			      (setq outline-regexp "###")
			      (abbrev-mode t)
			      (hs-minor-mode t)))
(setq python-mode-hook nil)


;;@============================= ORG
(setq org-modules '(org-bbdb org-bibtex org-docview org-gnus org-habit org-drill org-info org-irc org-mhe org-rmail org-w3m))
(eval-after-load "org" '(add-to-list 'org-modules 'org-timer))

(setq org-todo-keywords ;; with utf8 characters.
      '((sequence "☛ TODO" "|" "✔ DONE")
	(sequence "⚑ WAITING(w)" "|")
	(sequence "ε 3" "|" "ε 6" "|" "ε 10" "|" "FINISHED")
	(sequence "|" "✘ CANCELED")))

(setq org-log-into-drawer t)

(add-hook 'org-mode-hook (lambda ()
			   (setq default-justification 'full)
			   (turn-on-auto-fill)
			   ;; (smartparens-mode)
			   (electric-pair-mode)
			   ;; (toggle-input-method)
			   ;; LOOKS
			   ;; (set-face-attribute 'org-level-1 t :height 1.9 )
			   ;; (set-face-attribute 'org-level-2 t :height 1.3 )
			   (org-bullets-mode 1)))

;; LOOKS
(set-face-attribute 'bold nil :height 130 :foreground "deep sky blue")

;;@============================= KEYFREQ
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(setq keyfreq-excluded-commands
      '(self-insert-command
        org-self-insert-command
	dired
	))
;;@============================= WHICH-KEY
(require 'which-key)
(which-key-mode)

;;@============================= FLYCHECK
;; (set-face-attribute 'flycheck-error
                    ;; nil
		    ;; :underline
		    ;; '(:color "red" :style line))
;; (set-face-attribute 'flycheck-warning
		    ;; nil
		    ;; :underline
		    ;; '(:color "orange" :style line))

;;@============================= HELM
(setf helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*helm-mode"
				       "\\*Help" "\\*Buffer " 
                                       "\\*Echo Area" "\\*Minibuf" "\\*monky-cmd-process\\*"
                                       "\\*epc con" "\\*Compile-Log\\*" "\\*monky-process\\*"
                                       "\\*CEDET CScope\\*" "\\*Messages\\*" "\\*Flycheck error"
                                       "\\*.+(.+)" "elpa/.+" "tramp/.+"
                                       "\\*Gofmt Errors\\*" "\\*autopep8"
                                       "\\*magit-process:" "\\*magit-diff:" "\\*anaconda-mode\\*"))



;;@============================= HYDRA
(defvar rectangle-mark-mode)
(defun hydra-ex-point-mark ()
  "Exchange point and mark."
  (interactive)
  (if rectangle-mark-mode
      (rectangle-exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(defhydra hydra-bookmarks (:color blue :hint nil)
 "
^Set^                                      ^Jump^                         ^Insert^          
-------------------------------------------------------------------------------------
_m_ Set Bookmark                        _j_ Jump to Register         _i_ Insert Register
_w_ Window Configuration to Register    _b_ Jump to Bookmark 
_x_ Copy to Register
_r_ Point to Register
"
  ("b" counsel-bookmark)
  ("i" insert-register)
  ("j" jump-to-register)
  ("r" point-to-register)
  ("m" bookmark-set)
  ("w" window-configuration-to-register)
  ("x" copy-to-register))

(defhydra hydra-replace (:color orange)
  "Replace"
  ("r" query-replace-in-region "Replace in region without moving point")
  ("."  (lambda () (interactive)
	  (setq current-prefix-arg '(4)) ; C-u
	  (call-interactively 'smartscan-symbol-replace)) "Replace Symbol in defun")
  ("," smartscan-symbol-replace "Replace symbol in buffer")
  ("b" query-replace-regexp "Replace regexp in buffer or region")
  ("q" nil "cancel"))

(defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
				     :color pink
				     :post (deactivate-mark))
  "Rectangle"
  ("h" rectangle-backward-char nil)
  ("l" rectangle-forward-char nil)
  ("k" rectangle-previous-line nil)
  ("j" rectangle-next-line nil)
  ("e" hydra-ex-point-mark "hydra-ex-point-mark")
  ("n" copy-rectangle-as-kill "copy-rectangle-as-kill")
  ("d" delete-rectangle "delete-rectangle")
  ("r" (if (region-active-p)
	   (deactivate-mark)
	 (rectangle-mark-mode 1)) "Deactivate Region")
  ("y" yank-rectangle "yank-rectangle")
  ("u" undo "undo")
  ("s" string-rectangle "string-rectangle")
  ("x" kill-rectangle "kill-rectangle")
  ("o" nil "" ))
 
(defhydra hydra-navigation (:pre (set-cursor-color "#40e0d0")
				 :post (progn
					 (message
					  "NAVIGATION MODE" )))
  "navigation"
  ("l" avy-goto-word-1)  
  ("h" left-word)
  ("J" next-line)
  ("K" previous-line)
  ("k" backward-paragraph)
  ("j" forward-paragraph)
  ("m" mark-sexp)
  ("p" beginning-of-defun)
  ("n" end-of-defun)
  ("d" kill-sexp)
  ("D" sp-kill-hybrid-sexp)
  ("s" avy-goto-word-or-subword-1)

  ("u" backward-up-list)
  ("U" down-list)

  ("g" beginning-of-buffer)
  ("G" end-of-buffer)
  
  ("C-h" hs-hide-level)
  ("C-l" recenter-top-bottom)
  
  ("C-j" my-hs-toggle-hiding)
  ("5" paredit-open-round)
  ("a" crux-move-beginning-of-line)
  ("e" move-end-of-line)
  ("i" helm-imenu)
  ("SPC" nil "quit"))

(defhydra hydra-ibuffer-main (:color pink :hint nil)
  "
 ^Navigation^ | ^Mark^        | ^Actions^        | ^View^
-^----------^-+-^----^--------+-^-------^--------+-^----^-------
  _k_:    ʌ   | _m_: mark     | _D_: delete      | _g_: refresh
 _RET_: visit | _u_: unmark   | _S_: save        | _s_: sort
  _j_:    v   | _*_: specific | _a_: all actions | _/_: filter
-^----------^-+-^----^--------+-^-------^--------+-^----^-------
"
  ("j" ibuffer-forward-line)
  ("RET" ibuffer-visit-buffer :color blue)
  ("k" ibuffer-backward-line)

  ("m" ibuffer-mark-forward)
  ("u" ibuffer-unmark-forward)
  ("*" hydra-ibuffer-mark/body :color blue)

  ("D" ibuffer-do-delete)
  ("S" ibuffer-do-save)
  ("a" hydra-ibuffer-action/body :color blue)

  ("g" ibuffer-update)
  ("s" hydra-ibuffer-sort/body :color blue)
  ("/" hydra-ibuffer-filter/body :color blue)

  ("o" ibuffer-visit-buffer-other-window "other window" :color blue)
  ("q" quit-window "quit ibuffer" :color blue)
  ("." nil "toggle hydra" :color blue))

(defhydra hydra-ibuffer-mark (:color teal :columns 5
                              :after-exit (hydra-ibuffer-main/body))
  "Mark"
  ("*" ibuffer-unmark-all "unmark all")
  ("M" ibuffer-mark-by-mode "mode")
  ("m" ibuffer-mark-modified-buffers "modified")
  ("u" ibuffer-mark-unsaved-buffers "unsaved")
  ("s" ibuffer-mark-special-buffers "special")
  ("r" ibuffer-mark-read-only-buffers "read-only")
  ("/" ibuffer-mark-dired-buffers "dired")
  ("e" ibuffer-mark-dissociated-buffers "dissociated")
  ("h" ibuffer-mark-help-buffers "help")
  ("z" ibuffer-mark-compressed-file-buffers "compressed")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-action (:color teal :columns 4
                                :after-exit
                                (if (eq major-mode 'ibuffer-mode)
                                    (hydra-ibuffer-main/body)))
  "Action"
  ("A" ibuffer-do-view "view")
  ("E" ibuffer-do-eval "eval")
  ("F" ibuffer-do-shell-command-file "shell-command-file")
  ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
  ("H" ibuffer-do-view-other-frame "view-other-frame")
  ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
  ("M" ibuffer-do-toggle-modified "toggle-modified")
  ("O" ibuffer-do-occur "occur")
  ("P" ibuffer-do-print "print")
  ("Q" ibuffer-do-query-replace "query-replace")
  ("R" ibuffer-do-rename-uniquely "rename-uniquely")
  ("T" ibuffer-do-toggle-read-only "toggle-read-only")
  ("U" ibuffer-do-replace-regexp "replace-regexp")
  ("V" ibuffer-do-revert "revert")
  ("W" ibuffer-do-view-and-eval "view-and-eval")
  ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
  ("b" nil "back"))

(defhydra hydra-ibuffer-sort (:color amaranth :columns 3)
  "Sort"
  ("i" ibuffer-invert-sorting "invert")
  ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
  ("v" ibuffer-do-sort-by-recency "recently used")
  ("s" ibuffer-do-sort-by-size "size")
  ("f" ibuffer-do-sort-by-filename/process "filename")
  ("m" ibuffer-do-sort-by-major-mode "mode")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-filter (:color amaranth :columns 4)
  "Filter"
  ("m" ibuffer-filter-by-used-mode "mode")
  ("M" ibuffer-filter-by-derived-mode "derived mode")
  ("n" ibuffer-filter-by-name "name")
  ("c" ibuffer-filter-by-content "content")
  ("e" ibuffer-filter-by-predicate "predicate")
  ("f" ibuffer-filter-by-filename "filename")
  (">" ibuffer-filter-by-size-gt "size")
  ("<" ibuffer-filter-by-size-lt "size")
  ("/" ibuffer-filter-disable "disable")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(add-hook 'ibuffer-hook #'hydra-ibuffer-main/body)
;;@============================= XREF
(add-to-list 'xref-backend-functions 'gxref-xref-backend)
;;@============================= MAGIT
(setq vc-handled-backends nil)
(custom-theme-set-faces 'user
			`(magit-diff-file-heading-highlight ((t (:foreground "lightskyblue"  :weight bold))))
			`(magit-diff-file-heading ((t (:foreground "lightskyblue" ))))
			)

