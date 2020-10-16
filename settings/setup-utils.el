;;@============================= WHICH-KEY
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)
(setq which-key-sort-order 'which-key-prefix-then-key-order)


;;@============================= HELM
(setf helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*helm-mode"
				       "\\*Help" "\\*Buffer " 
                                       "\\*Echo Area" "\\*Minibuf" "\\*monky-cmd-process\\*"
                                       "\\*epc con" "\\*Compile-Log\\*" "\\*monky-process\\*"
                                       "\\*CEDET CScope\\*" "\\*Messages\\*" "\\*Flycheck error"
                                       "\\*.+(.+)" "elpa/.+" "tramp/.+"
                                       "\\*Gofmt Errors\\*" "\\*autopep8"
                                       "\\*magit-process:" "\\*magit-diff:" "\\*anaconda-mode\\*"))

;;@============================= KEYFREQ
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(setq keyfreq-excluded-commands
      '(self-insert-command
        org-self-insert-command
	dired))

;;@============================= PROJECTILE
(projectile-mode +1)
(counsel-projectile-mode t)
(setq projectile-sort-order 'default)


;;@============================= IBUFFER
(setq ibuffer-default-sorting-mode 'major-mode)

