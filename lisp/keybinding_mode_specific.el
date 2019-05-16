;;@============================= HELM
(global-set-key (kbd "M-i") 'helm-imenu)
(global-set-key (kbd "M-b") 'helm-buffers-list)

;; MULTIPLE CURSORS:

;;@============================= YASNIPPETS
(global-set-key (kbd "C-x y v") 'yas-visit-snippet-file)
(global-set-key (kbd "C-x y n") 'yas-new-snippet)
(global-set-key (kbd "C-x y r") 'yas-reload-all)
(global-set-key (kbd "C-x y y") 'yas-expand)
;; AutoYasnippets
(global-set-key (kbd "C-x y a") 'aya-create)
(global-set-key (kbd "C-x y e") 'aya-expand)
;;@============================= Expand Region
(global-set-key (kbd "C-;") 'er/expand-region)
;; (global-set-key (kbd "C") 'er/contract-region)

;;@============================= iedit
;; (define-key global-map (kbd "C-;") 'iedit-mode)

;;@============================= smartscan
(define-key global-map (kbd "M-p") 'smartscan-symbol-go-backward)
(define-key global-map (kbd "M-n") 'smartscan-symbol-go-forward)

;;@============================= autocomplete
(define-key ac-menu-map (kbd "M-n") 'ac-next)
(define-key ac-menu-map (kbd "M-p") 'ac-previous)

;;(define-key ac-menu-map (kbd "<tab>") nil)
;;(define-key ac-menu-map (kbd "<S-tab>") nil)
;;(define-key ac-complete-mode-map (kbd "<tab>") 'yas-next-field)

;;@============================= Racket
(add-hook 'racket-mode-hook
          (lambda ()
	    (paredit-mode 1)
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)
            (define-key racket-mode-map (kbd "C-x e") 'racket-send-last-sexp)))

;;@============================= Scheme
(defun scheme-outline-bindings ()
  "sets shortcut bindings for outline minor mode"
  (interactive)
  (local-set-key [C-S-backspace] 'delete-backward-char)
  (local-set-key [C-S-return] 'org-insert-heading-respect-content)
  (local-set-key [C-return] 'end-of-line-and-indented-new-line)
  (local-set-key [?\C-,] 'hide-sublevels)
  (local-set-key [?\C-.] 'show-all)
  ;; (local-set-key [?\M-p] 'outline-previous-visible-heading)
  ;; (local-set-key [?\M-n] 'outline-next-visible-heading)
  (local-set-key [M-S-up] 'outline-move-subtree-up)    
  (local-set-key [M-S-down] 'outline-move-subtree-down)
  (local-set-key [C-S-left] 'hide-subtree)
  (local-set-key [C-S-right] 'show-onelevel)
  (local-set-key [M-up] 'outline-backward-same-level   )
  (local-set-key [M-down] 'outline-forward-same-level)
  (local-set-key [M-left] 'hide-subtree)
  (local-set-key [C-S-backspace] 'delete)  (local-set-key [M-right] 'show-subtree))
;;@============================= ORG
(add-hook 'org-mode-hook (lambda ()
			   (define-key org-mode-map (kbd "C-c b") (lambda ()  (interactive)
								    (org-emphasize ?\*)))))

;;@============================= JAVASCRIPT
(add-hook 'js2-mode-hook (lambda ()
                           (define-key js2-mode-map  (kbd "C-x C-e") 'js-send-last-sexp)))
;;@============================= PYTHON
(add-hook 'python-mode-hook (lambda ()
                           (define-key python-mode-map  (kbd "C-x C-e") 'python-shell-send-defun)))
;;@============================= C-MODE

(add-hook 'c-mode-common-hook (lambda ()
				(define-key c-mode-base-map  (kbd "C-<tab>") 'c-indent-defun)
				(define-key c-mode-base-map  (kbd "C-j") 'newline)
				(define-key c-mode-base-map  (kbd "M-/") 'c-mark-function)
				(define-key c-mode-base-map  (kbd "<C-return>") 'electric-newline-and-maybe-indent)
                                (define-key c-mode-base-map  (kbd "C-<backspace>") 'backward-kill-word-or-selection)))
;; (add-hook 'compilation-mode-hook (lambda ()
				;; (define-key compilation-mode-map  "q" 'kill-buffer-and-window )))

;;@============================= GO-MODE
(add-hook 'c-mode-common-hook (lambda ()
                                (define-key c-mode-base-map  (kbd "C-<backspace>") 'backward-kill-word-or-selection)))

;;@============================= DIRED
;;(define-key dired-mode-map (kbd "C-q") 'dired-toggle-read-only)

;;@============================= COMPANY MODE 

;; (global-set-key (kbd "C-c /") 'company-files)        ; Force complete file names on "C-c /" key
;; (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
;; (define-key company-active-map (kbd "C-P") 'company-select-previous-or-abort)
;; (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
;; (define-key company-active-map (kbd "C-N") 'company-select-next-or-abort)
;; (define-key html-mode-map (kbd "C-'") 'company-web-html)

