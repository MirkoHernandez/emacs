;;@============================= IDO-UBIQUITOUS
(ido-ubiquitous-mode 1)

;;@============================= SMEX
;; smex, remember recently and most frequently used commands
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

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
(setq org-directory (concat emacs-root "emacs/org"))
(setq org-modules '(org-bbdb org-bibtex org-docview org-gnus org-habit org-drill org-info org-irc org-mhe org-rmail org-w3m))

(eval-after-load "org" '(add-to-list 'org-modules 'org-timer))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files (list  (concat org-directory)))

(setq org-capture-templates
      '(
	("n"
	 "Note"
	 entry
	 (file+headline (concat org-directory "/notes.org") "Notes")
	 "*  %?\n")
	("t"
	 "Daily task"
	 entry
	 (file+headline (concat org-directory "/daily-tasks.org") "Tasks")
	 "* TODO %?\n %U\n")
	("p"
	 "Practice"
	 entry
	 (file+headline (concat org-directory "/practice.org") "Practice")
	 "\n\n* ZERO %? :practice:\nSCHEDULED:<%(org-read-date nil nil \"+1d\")  +1d>\n:PROPERTIES:\n:STYLE: habit\n:LOGGING: 3TIMES(!) 6TIMES(!) 10TIMES(!) FINISHED(!)\n:END:")
	("7"
	 "Practice a few days during the week."
	 entry
	 (file+headline (concat org-directory "/practice.org") "Practice")
	 "\n\n* TODO  %? :practice:\nSCHEDULED:<%(org-read-date nil nil \"+1d\")  .+2d/3d>")
	("j"
	 "Journal"
	 entry
	 (file+olp+datetree  (concat org-directory "/journal.org"))
	 "* %?\nEntered on %U\n ")))

(setq org-agenda-custom-commands
      '(("p" "Practice"
	 ((agenda ""))
	 ((org-agenda-show-log t)
	  (org-agenda-ndays 7)
	  (org-agenda-log-mode-items '(state))
	  (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregex ":practice:"))))))

(setq org-todo-keywords ;; with utf8 characters.
      '((sequence "☛ TODO" "|" "✔ DONE")
	(sequence "⚑ WAITING(w)" "|")
	(sequence "ε 3" "|" "ε 6" "|" "ε 10" "|" "FINISHED")
	(sequence "|" "✘ CANCELED")))

(setq org-log-into-drawer t)

(add-hook 'org-mode-hook (lambda ()
			   (setq default-justification 'full)
			   (turn-on-auto-fill)
			   ;; LOOKS
			   (set-face-attribute 'org-level-1 t :height 1.9 )
			   (set-face-attribute 'org-level-2 t :height 1.3 )
			   (org-bullets-mode 1)))
;; LOOKS
(set-face-attribute 'bold nil :height 130 :foreground "deep sky blue")

;;@============================= KEYFREQ
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)



;;@============================= HELM
(setf helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*helm-mode"
				       "\\*Help" "\\*Buffer " 
                                       "\\*Echo Area" "\\*Minibuf" "\\*monky-cmd-process\\*"
                                       "\\*epc con" "\\*Compile-Log\\*" "\\*monky-process\\*"
                                       "\\*CEDET CScope\\*" "\\*Messages\\*" "\\*Flycheck error"
                                       "\\*.+(.+)" "elpa/.+" "tramp/.+"
                                       "\\*Gofmt Errors\\*" "\\*autopep8"
                                       "\\*magit-process:" "\\*magit-diff:" "\\*anaconda-mode\\*"))
