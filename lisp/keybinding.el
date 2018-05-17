;;; ekeys.el ---

;;; Code:
;;@============================= REBIND EMACS DEFAULTS
(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)
(global-set-key (kbd "<apps>") 'execute-extended-command) ;; Windows
(global-set-key (kbd "<C-return>") 'end-of-line-and-indented-new-line)
(global-set-key (kbd "C-x e") 'beginning-of-buffer)
(global-set-key (kbd "C-x t") 'end-of-buffer)

(global-set-key (kbd "C-i") 'backward-up-list)
(global-set-key (kbd "C-o") 'down-list)
(global-set-key (kbd "C-7") 'backward-up-list)
(global-set-key (kbd "C-8") 'backward-sexp)
(global-set-key (kbd "C-9") 'forward-sexp)
(global-set-key (kbd "C-0") 'up-list)
(global-set-key (kbd "C-1") 'widen)
(global-set-key (kbd "C-2") 'narrow-to-defun)
(global-set-key (kbd "C-3") 'narrow-to-region)

(global-set-key (kbd "M-s") 'set-selective-display)
(global-set-key (kbd "M-a") 'align-regexp)
(global-set-key (kbd "M-,") 'ggtags-find-tag-dwim)
(global-set-key (kbd "M-.") 'pop-tag-mark)

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key "\C-w" 'backward-kill-word-or-selection)
(global-set-key (kbd "M-o") 'query-replace-regexp)
(global-set-key (kbd "M-k") 'kill-sexp)
(global-set-key (kbd "<M-backspace>") 'backward-kill-sexp)

;;@============================= GENERAL KEYBINDINGS
(global-set-key "\C-xp" 'fill-paragraph)
(global-set-key [f7] 'next-error)
(global-set-key "\C-w" 'backward-kill-word-or-selection)
(global-set-key [f5] 'compile-or-delete-window)
(global-set-key [f6]  'comment-line)
(global-set-key [f8] 'switch-to-previous-buffer)

;;@============================= ORG
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

;;@============================= OUTLINE MINOR MODE
(define-key  global-map (kbd "M-p") 'outline-previous-visible-heading)
(define-key  global-map (kbd "M-n") 'outline-next-visible-heading)

;;@============================= HIDE/SHOW
(define-key  global-map [C-S-right] 'hs-show-block)
(define-key  global-map  [C-S-left] 'hs-hide-block)

;;@============================= Ñ as prefix
(define-key global-map "ñ" 'Control-X-prefix)


;;@================== INFO MODE
(defun Info-bindings ()
  "sets shortcut bindings for Info  mode"
  (local-set-key (kbd "<tab>") 'Info-next-reference))

;;@============================= OUTLINE BINDINGS
(defun cjm-outline-bindings ()
  "sets shortcut bindings for outline minor mode"
  (interactive)
  (local-set-key [C-S-return] 'org-insert-heading-respect-content)
  (local-set-key [C-return] 'end-of-line-and-indented-new-line)
  (local-set-key [?\C-,] 'hide-body)
  (local-set-key [?\C-.] 'show-all)
  (local-set-key [M-p] 'outline-previous-visible-heading) 
  (local-set-key [M-S-up] 'outline-move-subtree-up)    
  (local-set-key [M-S-down] 'outline-move-subtree-down)
  (local-set-key [M-n] 'outline-next-visible-heading)  
  (local-set-key [M-left] 'hide-subtree)
  (local-set-key [M-right] 'show-onelevel)
  (local-set-key [M-up] 'outline-backward-same-level)
  (local-set-key [M-down] 'outline-forward-same-level))

(define-key minibuffer-inactive-mode-map (kbd "C-p") 'previous-line-or-history-element)
