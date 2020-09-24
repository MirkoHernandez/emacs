;;@============================= DABBREV
;; (setq dabbrev-case-replace t)
;; (setq dabbrev-case-fold-search t)
;; (setq dabbrev-upcase-means-case-search t)

;;@============================= DIRED

(add-hook 'dired-mode-hook (lambda ()
			     (put 'dired-find-alternate-file 'disabled nil)
			     (dired-hide-details-mode)
			     (dired-sort-toggle-or-edit)
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

;;@============================= AVY
;; (funcall  avy-translate-char-function (read-key))

;; (defvar avy-translate-char-function #'my-read-char)

;; Replace original avy-read with version that respects input method.
(defun avy-read (tree display-fn cleanup-fn)
  "Select a leaf from TREE using consecutive `read-key'.

DISPLAY-FN should take CHAR and LEAF and signify that LEAFs
associated with CHAR will be selected if CHAR is pressed.  This is
commonly done by adding a CHAR overlay at LEAF position.

CLEANUP-FN should take no arguments and remove the effects of
multiple DISPLAY-FN invocations."
  
  (catch 'done
    (setq avy-current-path "")
    (while tree
      (let ((avy--leafs nil))
        (avy-traverse tree
                      (lambda (path leaf)
                        (push (cons path leaf) avy--leafs)))
        (dolist (x avy--leafs)
          (funcall display-fn (car x) (cdr x))))
      ;; (let ((char (funcall avy-translate-char-function (read-key)))
      (let ((char (read-char "char: " t))
            window
            branch)
        (funcall cleanup-fn)
        (if (setq window (avy-mouse-event-window char))
            (throw 'done (cons char window))
          (if (setq branch (assoc char tree))
              (progn
                ;; Ensure avy-current-path stores the full path prior to
                ;; exit so other packages can utilize its value.
                (setq avy-current-path
                      (concat avy-current-path (string (avy--key-to-char char))))
                (if (eq (car (setq tree (cdr branch))) 'leaf)
                    (throw 'done (cdr tree))))
            (funcall avy-handler-function char)))))))


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
(setq snippets-values-table
      #s(hash-table size 20 test equal
		    data (
			  ""  "")))

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
				  (setq outline-regexp ";;@+")
				  (diff-hl-mode t)))
(add-hook 'slime-mode-hook 'set-up-slime-ac)

;;@============================= RACKET
(add-hook 'racket-mode-hook (lambda ()
			      (outline-minor-mode)
			      (setq outline-regexp ";;@")
			      (diff-hl-mode t)))

;;@============================= KEYCHORD
;; (key-chord-mode 1)
;; (defvar key-chord-two-keys-delay 0.1)   ; 0.05 or 0.1
;; (defvar key-chord-one-key-delay 0.08)

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


;;@============================= Org
(setq org-modules '(org-bbdb org-bibtex org-docview org-gnus org-habit org-drill org-info org-irc org-mhe org-rmail org-w3m))
(eval-after-load "org" '(add-to-list 'org-modules 'org-timer))
(setq org-src-tab-acts-natively t)

(setq org-edit-src-content-indentation 0) ;; source block indentation

;; Exporting
(setq org-latex-packages-alist '(("margin=1cm" "geometry" nil))) 

(setq org-babel-default-header-args '())

;; add default arguments to use when evaluating a source block
(add-to-list 'org-babel-default-header-args
             '(:noweb . "yes"))


(setq org-todo-keywords ;; with utf8 characters.
      '((sequence "☛ TODO" "|" "✔ DONE")
	(sequence "⚑ WAITING(w)" "|")
	(sequence "ε 3" "|" "ε 6" "|" "ε 10" "|" "FINISHED")
	(sequence "|" "✘ CANCELED")))

(setq org-log-into-drawer t)

(add-hook 'org-mode-hook (lambda ()
			   (setq org-list-end-re "^[ 	]*
")

			   (setq default-justification 'full)
			   (turn-on-auto-fill)
			   ;; (smartparens-mode)
			   (electric-pair-mode)
			   ;; (toggle-input-method)
			   ;; LOOKS
			   ;; (set-face-attribute 'org-level-1 t :height 1.9 )
			   ;; (set-face-attribute 'org-level-2 t :height 1.3 )
			   (org-bullets-mode 1)))
;; Refile
(setq org-refile-targets '((org-agenda-files :maxlevel . 2)))

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



;;@============================= XREF
(add-to-list 'xref-backend-functions 'gxref-xref-backend)
;;@============================= MAGIT
(custom-theme-set-faces 'user
			`(magit-diff-file-heading-highlight ((t (:foreground "lightskyblue"  :weight bold))))
			`(magit-diff-file-heading ((t (:foreground "lightskyblue" ))))
			)
;;@============================= EDIFF
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-diff-options "-w ")
(setq ediff-keep-variants nil)
;;@============================= ENGINE
(require 'engine-mode)
(engine-mode t)
(setq engine/browser-function 'eww-browse-url)

;; Wikipedia
(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w"
  :docstring "Search Wikipedia!")
;; 
(defengine project-gutenberg
  "http://www.gutenberg.org/ebooks/search/?query=%s"
  :keybinding "g"
  :docstring "Search Project Gutenberg"
  )

(defengine rfc
  "http://pretty-rfc.herokuapp.com/search?q=%s"
:keybinding "r"
  :docstring "RFC")

(defengine stack-overflow
  "https://stackoverflow.com/search?q=%s"
  :keybinding "s"
  :docstring "Search Stack-Overflow")
;;@============================= EWW
(setq browse-url-browser-function 'eww-browse-url)
(setq shr-inhibit-images t)

;;@============================= SHRFACE

(with-eval-after-load 'shr ; lazy load is very important, it can save you a lot of boot up time
  (require 'shrface)
  (shrface-basic) ; enable shrfaces, must be called before loading eww/dash-docs/nov.el
  (shrface-trial) ; enable shrface experimental face(s), must be called before loading eww/dash-docs/nov.el
  (setq shrface-href-versatile t) ; enable versatile URL faces support
                                  ; (http/https/ftp/file/mailto/other), if
                                  ; `shrface-href-versatile' is nil, default
                                  ; face `shrface-href-face' would be used.
  (setq shrface-toggle-bullets nil) ; Set t if you do not like headline bullets
)
;; eww support
(with-eval-after-load 'eww
  (add-hook 'eww-after-render-hook 'shrface-mode))

