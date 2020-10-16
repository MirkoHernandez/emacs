;;@============================= PROG-MODE
(require 'smartparens-config)
(add-hook 'prog-mode-hook (lambda ()
			    ;; (smartparens-mode)
			    (electric-pair-mode)
			    ;; (toggle-input-method)
			    ))

;;@============================= COMPANY
(require 'company)                                   
(require 'company-web-html)                          ; load company mode html backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing


;;@============================= HS-MINOR-MODE
(add-hook 'prog-mode-hook #'hs-minor-mode)

;;@============================= AUTO-FILL-MODE  
(defun my-prog-mode-hook ()
  (setq default-justification 'full))
(add-hook 'prog-mode-hook #'my-prog-mode-hook)

(set-default 'truncate-lines t)
(show-paren-mode)

(setq default-justification 'full)
(setq kill-whole-line t)
(delete-selection-mode 1)

;;@============================= TRANSIENT MARK
(setq transient-mark-mode nil)
(defadvice set-mark-command (after no-bloody-t-m-m activate)
  "Prevent consecutive marks activating bloody `transient-mark-mode'."
  (if transient-mark-mode (setq transient-mark-mode nil) ))

(defadvice mouse-set-region-1 (after no-bloody-t-m-m activate)
  "Prevent mouse commands activating bloody `transient-mark-mode'."
  (if transient-mark-mode (setq transient-mark-mode nil))) 
(setq set-mark-command-repeat-pop t)


;;@============================= WHICH FUNCTION
(require 'which-func)
(which-func-mode 1)

;;@============================= TEMPLATES
(auto-insert-mode) 
;; (setq auto-insert-directory (concat emacs-root "emacs/templates/"))
;; (setq auto-insert-query t) 
;; (define-auto-insert "\.c" "main.c")

