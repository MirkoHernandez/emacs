;;@============================= WHICH-KEY
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)
(setq which-key-sort-order 'which-key-prefix-then-key-order)


;;@============================= KEYFREQ
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(setq keyfreq-excluded-commands
      '(self-insert-command
        org-self-insert-command
	dired))

;;@============================= PROJECTILE
(require 'projectile)
(projectile-mode +1)
;; (counsel-projectile-mode nil)
(setq projectile-sort-order 'default)

;;@============================= TREEMACS

;; (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)

(with-eval-after-load 'treemacs
  (defun treemacs-ignore-some-files (file _)
    (string= file "node_modules"))
  (push #'treemacs-ignore-some-files treemacs-ignored-file-predicates))



;;@============================= IBUFFER
(setq ibuffer-default-sorting-mode 'major-mode)

