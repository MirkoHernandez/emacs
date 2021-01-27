;;@============================= MELPA

(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

;;@============================= PACKAGE LIST
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)


(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (Add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))


(setq package-selected-packages
      '(
	;; smex
	;; iedit
	;; linum-relative
	;; ido-completing-read+
	;; general
;	key-chord
	hydra
	crux
;; Completion
	ivy
	counsel
	flx
	helm
;;@ Utilities	
	which-key
	keyfreq
;;@ Workspaces
	persp-mode
	perspective
	projectile
	counsel-projectile
	treemacs
	treemacs-projectile
;;@ Navegation
	avy
	smartscan
	swiper
	neotree 
	ag
	helm-ag
	peep-dired
;;@ Misc
	typing
	darkroom
	exec-path-from-shell
;;@ Documentation
	markdown-mode
	engine-mode
	shrface
;;@ Programming
	skeletor
	rainbow-mode
	flycheck
	expand-region
	diff-hl
	company
	yasnippet
	multiple-cursors
	move-text
	magit
	fix-word
	smartparens
;;@ Languages	
	;; C
	helm-cscope 
	ggtags
	xcscope
	gxref
	realgud 
	;; lisp
	ac-slime
	paredit
	racket-mode
	;; go
	go-mode
	go-eldoc
	go-autocomplete
	;; html
	company-web
	emmet-mode
	;; python
	flymake-python-pyflakes
	;; javascript
	js-comint
	ac-js2
	json-mode
	;; elm
	elm-mode
;;@ Appereance
	org-bullets
	beacon
	zenburn-theme
	gruvbox-theme
	moody
	))

(package-refresh-contents)
(package-install-selected-packages)
