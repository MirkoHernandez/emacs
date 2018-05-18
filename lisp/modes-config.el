;;@=============================IDO-UBIQUITOUS
(ido-ubiquitous-mode 1)

;;@============================= SMEX
;;; smex, remember recently and most frequently used commands
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(require 'smex)

;;@============================= PROJECTILE
(projectile-global-mode t)

;;@============================= YASNIPEPTS
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs
	     (concat emacs-root "emacs/snippets"))
(yas-global-mode 1)

;;@============================= COMPANY
(require 'company)                                   
(require 'company-web-html)                          ; load company mode html backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;;@============================= HTML
(add-hook 'html-mode-hook (lambda ()
                           (set (make-local-variable 'company-backends) '(company-web-html))
                           (company-mode t)
                           (emmet-mode t)))

;;@============================= COMMON LISP
(setq inferior-lisp-program "sbcl")

;;@=============================  KEYCHORD
(key-chord-mode 1)
(defvar key-chord-two-keys-delay 0.1)   ; 0.05 or 0.1
(defvar key-chord-one-key-delay 0.08)

;;@============================= JAVASCRIPT
(require 'js-comint)
(add-hook 'js2-mode-hook (lambda ()
			   (abbrev-mode t)
			   (ac-js2-mode t)
			   (hs-minor-mode t)))

(setq inferior-js-program-command "node")
(setq inferior-js-program-arguments '("--interactive"))

;;@============================= GIMP
;; git clone git://github.com/pft/gimpmode.git
(load-if-exists (concat emacs-root  "emacs/packages/gimpmode/gimp-init.el"))

;;@============================= PYTHON
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(setq flymake-python-pyflakes-executable "flake8")

(add-hook 'python-mode-hook (lambda ()
			   (abbrev-mode t)
			   (hs-minor-mode t)))
