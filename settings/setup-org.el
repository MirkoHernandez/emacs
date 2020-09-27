;;@============================= Org
(setq org-modules '(org-bbdb
		    org-bibtex
		    org-docview
		    org-gnus
		    org-habit
		    org-drill
		    org-info
		    org-mhe
		    org-rmail
		    ;; org-irc
		    ;; org-w3m
		    ))
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
