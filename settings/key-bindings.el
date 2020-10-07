;;; ekeys.el ---

;;; Code:
;;@============================= M-x
;; (global-set-key (kbd "<C-m>") 'smex)
(global-set-key (kbd "M-x") 'counsel-M-x)

;;@============================= Rebind Emacs defaults
(global-set-key "\C-x\C-b" 'ibuffer-other-window)
(global-set-key "\C-x\C-q" 'save-buffers-kill-terminal)
(global-set-key "\C-x\C-c" nil)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-+") 'text-scale-increase)

;;@============================= Rebind  using Modes
(global-set-key "\C-b" 'persp-switch-to-buffer)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "C-x r b") 'counsel-bookmark)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key "\C-s" 'swiper-isearch)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;@============================= Modes
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key [f5] 'compile-or-delete-window)
(global-set-key (kbd "S-<f5>") 'recompile-quietly)


;;@============================= Navigation
;; (global-set-key "\C-r" 'swiper-isearch-backward)
(global-set-key (kbd "M-o") 'other-window)
;; (global-set-key (kbd "M-i") 'helm-imenu)
(global-set-key (kbd "M-g") 'goto-line)
;; Files
(global-set-key (kbd "M-f") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-ag)
(global-set-key (kbd "C-x C-r") 'helm-recentf) 
(global-set-key (kbd "C-x <right>") 'my/persp-next-buffer) 
(global-set-key (kbd "C-x <left>") 'my/persp-previous-buffer) 

;; Movement
(global-set-key (kbd "C-;") 'View-back-to-mark)
(global-set-key (kbd "C-:") 'exchange-point-and-mark)

(global-set-key (kbd "C-f") 'avy-goto-word-or-subword-1)

(global-set-key (kbd "C-S-u") 'backward-up-list)
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)

(global-set-key (kbd "C-x e") 'beginning-of-buffer)
(global-set-key (kbd "C-x t") 'end-of-buffer)

(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)

(define-key global-map [pgup] 'forward-page)
(define-key global-map [pgdown] 'backward-page)
(define-key global-map [C-prior] 'scroll-other-window)
(define-key global-map [C-next] 'scroll-other-window-down)

(global-set-key (kbd "C-8") 'backward-up-list)
(global-set-key (kbd "C-9") 'down-list)
(global-set-key (kbd "C-7") 'backward-list)
(global-set-key (kbd "C-0") 'forward-list)

(global-set-key [f8] 'my/persp-toggle-recent-buffer)
(global-set-key (kbd "S-<f8>") 'my/toggle-recent-buffer)

(global-set-key [f7] 'switch-to-prev-buffer)

(global-set-key (kbd "\C-x3") 'my/split-window-right-other-window)

(global-set-key (kbd "C-S-j") 'goto-primary-file)
(global-set-key (kbd "C-S-h") 'goto-secondary-file)

;; (global-set-key (kbd "C-8") 'backward-sexp)
;; (global-set-key (kbd "C-9") 'forward-sexp)

;; Tags
(global-set-key (kbd "M-.") 'ggtags-find-tag-dwim)
(global-set-key (kbd "M-,") 'pop-tag-mark)
;; Errors

(global-set-key (kbd "S-<f9>") 'previous-error)
(global-set-key [f9] 'next-error)

;;@============================= Editing
(global-set-key (kbd "M-U") 'fix-word-upcase)
(global-set-key (kbd "M-l") 'fix-word-downcase)
(global-set-key (kbd "M-c") 'fix-word-capitalize)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-u") 'undo)
(global-set-key (kbd "<f12>") 'repeat)
(global-set-key (kbd "S-<f12>") 'repeat-complex-command) 
(global-set-key (kbd "C-o") 'dabbrev-expand)

(global-set-key (kbd "<S-return>") 'crux-smart-open-line)
(global-set-key (kbd "<C-S-return>") 'crux-smart-open-line-above)
(global-set-key (kbd "<C-return>") 'end-of-line-and-indented-new-line)

(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
(global-set-key (kbd "C-c d") 'crux-duplicate-current-line-or-region)

;; (global-set-key (kbd "C-i") 'indent-or-complete)
;; (global-set-key (kbd "C-f") 'yank)
(global-set-key (kbd "C-j") 'newline)
(global-set-key (kbd "M-a") 'align-regexp)
(global-set-key (kbd "<M-S-down>") 'move-text-down)
(global-set-key (kbd "<M-S-up>") 'move-text-up)
(global-set-key (kbd "<C-tab>") 'indent-region)

(global-set-key "\C-xp" 'fill-paragraph)
(global-set-key [f6]  'comment-line)
;; (global-set-key (kbd "<tab>") 'indent-for-tab-command)
(global-set-key (kbd "<C-return>") 'end-of-line-and-indented-new-line)

(global-set-key (kbd "C-S-l") 'kill-whole-line)
(global-set-key (kbd "<backtab>") 'yas-expand-indent)
(global-set-key  "\C-c+" 'increment-number-at-point)

;; Selection
(global-set-key (kbd "<C-M-SPC>") 'mark-sexp)

;; Delete
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-S-k") 'crux-kill-line-backwards)

(global-set-key (kbd "M-k") 'kill-this-buffer)
(global-set-key (kbd "<M-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "C-h") 'delete-backward-char)
;; (global-set-key "\C-w" 'backward-kill-word-or-selection)
(global-set-key "\C-w" 'kill-region)
(global-set-key "\M-d" 'kill-sexp)

;; (define-key global-map "M-;" 'exchange-point-and-mark)


;;@============================= Focus (outline, hs, Narrow)
(global-set-key (kbd "C-1") 'widen)
(global-set-key (kbd "C-2") 'narrow-to-defun)
(global-set-key (kbd "C-3") 'narrow-to-region)
;; Outline
(global-set-key (kbd "<M-up>") 'outline-hide-body) 
(global-set-key (kbd "<M-down>") 'outline-show-all)
(global-set-key (kbd "<M-right>") 'outline-toggle-children)
(global-set-key (kbd "<M-left>") 'outline-toggle-children)
(global-set-key (kbd "<C-S-tab>") 'outline-show-branches)

(define-key  global-map [C-S-right] 'hs-show-block)
(define-key  global-map [C-S-left] 'hs-hide-block)
(define-key  global-map [C-S-up] 'hs-hide-level)
(define-key  global-map [C-S-down] 'hs-show-all)


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

;;@============================= Prefix

;; (define-prefix-command 'my-prefix)
;; (global-set-key (kbd "<apps>") my-prefix)
;; (global-set-key (kbd "C-o") ctl-x-map)

;;@============================= Org Mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

;;@============================= Info Mode
(defun Info-bindings ()
  "sets shortcut bindings for Info  mode"
  (local-set-key (kbd "<tab>") 'Info-next-reference))

;;@============================= Minibuffer
(define-key minibuffer-local-map (kbd "C-p") 'ido-prev-match)
(define-key minibuffer-local-map (kbd "C-n") 'ido-next-match)

