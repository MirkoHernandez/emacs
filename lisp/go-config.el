;;; go-config.el --- Configuratin for golang         -*- lexical-binding: t; -*-

(provide 'go-config)
;;@============================= GO
(defun go-compile ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (let ((file  (buffer-name-no-extension   ))
         (concat
          "go build " file )))))

;; Autoindentation and check errors on save.
(add-hook 'before-save-hook 'gofmt-before-save)

;; https://github.com/dougm/goflymake
(add-to-list 'load-path (concat emacs-root "emacs/packages/goflymake2/"))

(if (not (require 'go-flycheck nil t))
    (message "`goflymake' not found"))

(require 'go-flymake)

;; NOTE: Remember to install gocode and set the path of the go
;; binaries e.i. export PATH=${PATH}:${GOPATH}/bin)
;; Remember also to compile ctags with go support.

(require 'go-eldoc) 
(setq go-eldoc-gocode "gocode" ) 

(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'auto-complete-mode)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(require 'go-autocomplete)
(require 'auto-complete-config)
;;; go-config.el ends here


