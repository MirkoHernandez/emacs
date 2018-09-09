;;@============================= HELPERS
(defun load-if-exists (f)
  (if (file-readable-p f)
      (load-file f)))
;;@============================= GENERAL SETTINGS
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)
(global-auto-revert-mode t)

(setq create-lockfiles nil) ;; prevent the automatic creation of symbolic links

;;@============================= EMACS SPECIFIC FOLDERS
(setq temporary-file-directory (concat emacs-root "emacs/tmp"))
(setq my-backup-dir (concat emacs-root "emacs/tmp/backup"))

(setq backup-directory-alist
      `((".*" . ,my-backup-dir)))

(setq auto-save-file-name-transforms
      `((".*" ,my-backup-dir t)))

(setq auto-save-list-file-prefix
      (concat my-backup-dir "/.auto-saves-"))


;;@============================= EMACS CUSTOMIZE FILE
(setq custom-file (concat emacs-root "emacs/lisp/custom.el"))
(load-if-exists custom-file)

;;@============================= HS-MINOR-MODE
(add-hook 'prog-mode-hook #'hs-minor-mode)
;;@============================= AUTO-FILL-MODE  
(defun my-prog-mode-hook ()
  (setq default-justification 'full))
(add-hook 'prog-mode-hook #'my-prog-mode-hook)

;;@============================= IDO
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq ido-file-extensions-order '(".org" ".c" ".cpp"  ".py" ".go" ".emacs" ".js" ".html" ".txt" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;;@============================= ORG MODE
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

(setq org-todo-keywords
'((sequence "TODO" "|" "DONE")
  (sequence "ZERO" "3TIMES" "6TIMES" "10TIMES" "|" "FINISHED")
  (sequence "|" "CANCELED")))



(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-log-into-drawer t)

;;@============================= Ignored * buffers
(set-frame-parameter (selected-frame) 'buffer-predicate #'buffer-file-name)

;@============================= EDITING CONFIG

(set-default 'truncate-lines t)
(show-paren-mode)
(setq abbrev-file-name (concat emacs-root "emacs/lisp/abbrevs"))
(setq default-justification 'full)
(setq kill-whole-line t)

;; Emacs  defaults  (In  order  to remember  the  default  values  and
;; experiment with variations)
(delete-selection-mode 1)
(transient-mark-mode 1)

;;@============================= DESKTOP
;; (desktop-change-dir (concat emacs-root "emacs/tmp/desktop"))
(setq desktop-dirname             (concat emacs-root "emacs/desktop") 
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" 
      desktop-load-locked-desktop nil
      desktop-auto-save-timeout   30)

(desktop-save-mode 0)

(defun load-my-desktop ()
  (interactive)
  (let ((desktop-load-locked-desktop "ask"))
    (desktop-read)
    (desktop-save-mode 1)))
(desktop-read)

;;@============================= TERMINAL
;; (unless  (display-graphic-p)
;; (enable-theme  'wombat))
;;(send-string-to-terminal "\033]12;red\007")
;; Make it so that emacsclient can talk to this Emacs instance
;; (unless (daemonp) (server-mode 1))

;;@============================= GPG
(require 'epa-file)
(epa-file-enable)

;;@============================= WINDOWS COMPATIBILITY
(when (string-equal system-type "windows-nt")
  (setq gnu-bin (getenv "GNUBIN")))

;;@============================= TEMPLATES
(auto-insert-mode) 
;; (setq auto-insert-directory (concat emacs-root "emacs/templates/"))
;; (setq auto-insert-query t) 
;; (define-auto-insert "\.c" "main.c")

