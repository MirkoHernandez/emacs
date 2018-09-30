;;@============================= MELPA

(require 'package)

;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    ;; (not (gnutls-available-p))))
       ;; (proto (if no-ssl "http" "https")))
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    ;; (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;;@============================= PACKAGE LIST

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (Add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(setq package-selected-packages
      '(
	;; general
	yasnippet
	company
	key-chord
	ido-completing-read+
	projectile
	expand-region
	flycheck
	smex
	helm
	magit
	move-text
	ag
	helm-ag
	diff-hl
	keyfreq
	iedit
	smartscan
	;; C
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
	;; looks
	org-bullets
	beacon
	zenburn-theme
	))

(package-refresh-contents)
(package-install-selected-packages)
