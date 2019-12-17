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
	;;
	;;
	;; general
	yasnippet
	company
	key-chord
	projectile
	expand-region
	flycheck
	ivy
	counsel
	counsel-projectile
	swiper
	avy
	which-key
	helm
	magit
	move-text
	ag
	helm-ag
	diff-hl
	smartscan
	speed-type
	keyfreq
	exec-path-from-shell
	multiple-cursors
	ranger
	hydra
	fix-word
	smartparens
	;; C
	helm-cscope 
	ggtags
	xcscope
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
	;; looks
	org-bullets
	beacon
	zenburn-theme
	))

(package-refresh-contents)
(package-install-selected-packages)
