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



