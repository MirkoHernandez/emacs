;;@============================= DIRED
(add-hook 'dired-mode-hook (lambda ()
			     (put 'dired-find-alternate-file 'disabled nil)
			     (dired-hide-details-mode)
			     (dired-sort-toggle-or-edit)))
