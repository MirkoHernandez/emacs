;;@============================= HELM
(global-set-key (kbd "M-i") 'helm-imenu)

;; MULTIPLE CURSORS:
(global-set-key "\C-o" 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-S-o") 'mc/mark-next-word-like-this)

;;@============================= YASNIPPETS
(global-set-key (kbd "C-x y v") 'yas-visit-snippet-file)
(global-set-key (kbd "C-x y n") 'yas-new-snippet)
(global-set-key (kbd "C-x y r") 'yas-reload-all)
(global-set-key (kbd "C-x y y") 'yas-expand)
;; AutoYasnippets
(global-set-key (kbd "C-x y a") 'aya-create)
(global-set-key (kbd "C-x y e") 'aya-expand)
;;@============================= Expand Region
(global-set-key (kbd "C-ñ") 'er/expand-region)
(global-set-key (kbd "C-Ñ") 'er/contract-region)
;;@============================= Multiple Cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;;@============================= iedit
(define-key global-map (kbd "C-;") 'iedit-mode)
;;@============================= autocomplete

;; (define-key ac-menu-map (kbd "M-n") 'ac-next)
;; (define-key ac-menu-map (kbd "M-p") 'ac-previous)

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
  (local-set-key [?\M-p] 'outline-previous-visible-heading)
  (local-set-key [M-S-up] 'outline-move-subtree-up)    
  (local-set-key [M-S-down] 'outline-move-subtree-down)
  (local-set-key [?\M-n] 'outline-next-visible-heading)
  (local-set-key [C-S-left] 'hide-subtree)
  (local-set-key [C-S-right] 'show-onelevel)
  (local-set-key [M-up] 'outline-backward-same-level   )
  (local-set-key [M-down] 'outline-forward-same-level)
  (local-set-key [M-left] 'hide-subtree)
  (local-set-key [C-S-backspace] 'delete)  (local-set-key [M-right] 'show-subtree))

;;@============================= JAVASCRIPT

(add-hook 'js2-mode-hook (lambda ()
                           (define-key js2-mode-map  (kbd "C-x C-e") 'js-send-last-sexp)))

;;@============================= PYTHON

(add-hook 'python-mode-hook (lambda ()
                           (define-key python-mode-map  (kbd "C-x C-e") 'python-shell-send-defun)))
;;@============================= C-MODE

(add-hook 'c-mode-common-hook (lambda ()
                                (define-key c-mode-base-map  (kbd "C-<backspace>") 'backward-kill-word-or-selection)))
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


;;@============================= MY  FUNCTIONS 
(global-set-key (kbd "C-S-l") 'kill-whole-line)
(global-set-key (kbd "<backtab>") 'yas-expand-indent)
(global-set-key  "\C-c+" 'increment-number-at-point)
(global-set-key [f8] 'switch-to-previous-buffer)
(global-set-key (kbd "<tab>") 'indent-for-tab-command)
(global-set-key (kbd "<C-return>") 'end-of-line-and-indented-new-line)
(global-set-key (kbd "\C-x3") 'split-window-right-other-window)
