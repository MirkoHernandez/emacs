;;@============================= HELPERS
(defun load-if-exists (f)
  (if (file-readable-p f)
      (load-file f)))

;;@============================= GENERAL SETTINGS
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)
(global-auto-revert-mode t)

(setq create-lockfiles nil) ;; prevent the automatic creation of symbolic links
(setq default-input-method 'programmer-dvorak)

;;@============================= WINDOWS 
(if (string-equal system-type "windows-nt")
    (progn
      ;; in case GNU utils is not installed for global use.
      (setq gnu-bin (getenv "GNUBIN"))
      ;; Prevent slow scroll in Windows (buffers with unicode characters)
      (setq inhibit-compacting-font-caches t) 
      (load "server")
      (unless (server-running-p)
	(server-start))))

;;@============================= EXEC-PATH-FROM-SHELL
(when (memq window-system '(mac ns x))
 (exec-path-from-shell-initialize))


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
(setq ido-auto-merge-work-directories-length -1)

;;@============================= Ignored * buffers
(set-frame-parameter (selected-frame) 'buffer-predicate #'buffer-file-name)

;@============================= EDITING CONFIG

(set-default 'truncate-lines t)
(show-paren-mode)
(setq abbrev-file-name (concat emacs-root "emacs/lisp/abbrevs"))
(setq default-justification 'full)
(setq kill-whole-line t)
(delete-selection-mode 1)
(setq transient-mark-mode t)

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


;;@============================= TEMPLATES
(auto-insert-mode) 
;; (setq auto-insert-directory (concat emacs-root "emacs/templates/"))
;; (setq auto-insert-query t) 
;; (define-auto-insert "\.c" "main.c")

