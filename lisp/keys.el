;;; ekeys.el ---

;;; Code:
;;@============================= REBIND EMACS DEFAULTS
(global-set-key (kbd "<C-m>") 'smex)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-x\C-f" 'counsel-find-file)
(global-set-key "\C-x\C-q" 'save-buffers-kill-terminal)
(global-set-key "\C-x\C-c" nil)
(global-set-key (kbd "C-x r b") 'counsel-bookmark)
(global-set-key "\C-b" 'ivy-switch-buffer)
(global-set-key (kbd "C-x SPC") 'hydra-rectangle/body)

(global-set-key (kbd "M-U") #'fix-word-upcase)
(global-set-key (kbd "M-l") #'fix-word-downcase)
(global-set-key (kbd "M-c") #'fix-word-capitalize)

(global-set-key "\C-s" 'swiper-isearch)
(global-set-key "\C-r" 'swiper-isearch-backward)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-f") 'counsel-find-file)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)


(global-set-key (kbd "M-u") 'undo)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "C-1") 'widen)
(global-set-key (kbd "C-2") 'narrow-to-defun)
(global-set-key (kbd "C-3") 'narrow-to-region)
(global-set-key (kbd "M-r") 'hydra-replace/body)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-i") 'helm-imenu)
(global-set-key (kbd "C-o") 'dabbrev-expand)
(global-set-key (kbd "C-i") 'indent-or-complete)

;; Handmade hero keybindings
(global-set-key (kbd "C-f") 'yank)
(global-set-key (kbd "M-g") 'goto-line)

;; Outline
(global-set-key (kbd "<M-up>") 'outline-show-all)
(global-set-key (kbd "<M-down>") 'outline-hide-body)
(global-set-key (kbd "<M-right>") 'outline-toggle-children)
(global-set-key (kbd "<M-left>") 'outline-toggle-children)

;; Movement
(global-set-key (kbd "C-x e") 'beginning-of-buffer)
(global-set-key (kbd "C-x t") 'end-of-buffer)

(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "C-S-n") 'forward-paragraph)

(global-set-key (kbd "C-8") 'backward-up-list)
(global-set-key (kbd "C-9") 'down-list)
(global-set-key (kbd "C-7") 'backward-list)
(global-set-key (kbd "C-0") 'forward-list)

;; (global-set-key (kbd "C-8") 'backward-sexp)
;; (global-set-key (kbd "C-9") 'forward-sexp)

;; Tags
(global-set-key (kbd "M-.") 'ggtags-find-tag-dwim)
(global-set-key (kbd "M-,") 'pop-tag-mark)

;; Delete
(global-set-key (kbd "M-k") 'kill-this-buffer)
(global-set-key (kbd "<M-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "C-h") 'delete-backward-char)
;; (global-set-key "\C-w" 'backward-kill-word-or-selection)
(global-set-key "\C-w" 'kill-region)

;; Editing
(global-set-key (kbd "<C-return>") 'end-of-line-and-indented-new-line)
(global-set-key (kbd "C-j") 'newline)

(global-set-key (kbd "<C-M-SPC>") 'mark-sexp)
;; (global-set-key (kbd "<C-M-SPC>") 'just-one-space)
(global-set-key (kbd "M-a") 'align-regexp)
(global-set-key (kbd "<M-S-down>") 'move-text-down)
(global-set-key (kbd "<M-S-up>") 'move-text-up)

;;@============================= KEYMAP 

(define-prefix-command 'my-keymap)
(global-set-key (kbd "<menu>") my-keymap)

;; (global-set-key (kbd "C-o") ctl-x-map)
 


;;@============================= GENERAL KEYBINDINGS
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-+") 'text-scale-increase)

(global-set-key (kbd "<C-tab>") 'indent-region)
;; (define-key global-map "M-;" 'exchange-point-and-mark)

(global-set-key (kbd "M-S-n") 'next-error)
(global-set-key (kbd "M-S-p") 'previous-error)

(global-set-key "\C-xp" 'fill-paragraph)

(global-set-key [f5] 'compile-or-delete-window)
(global-set-key [f6]  'comment-line)
(global-set-key [f7] 'switch-to-prev-buffer)

(global-set-key [f9] 'first-error)
;;@============================= ORG
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

;;@============================= OUTLINE MINOR MODE
;; (define-key  global-map (kbd "M-p") 'outline-previous-visible-heading)
;; (define-key  global-map (kbd "M-n") 'outline-next-visible-heading)

;;@============================= HIDE/SHOW
(define-key  global-map [C-S-right] 'hs-show-block)
(define-key  global-map  [C-S-left] 'hs-hide-block)

;;@============================= INFO MODE
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


;;@============================= MINIBUFFER
(define-key minibuffer-local-map (kbd "C-p") 'ido-prev-match)
(define-key minibuffer-local-map (kbd "C-n") 'ido-next-match)


;;@============================= MY  FUNCTIONS 
(global-set-key (kbd "C-S-l") 'kill-whole-line)
(global-set-key (kbd "<backtab>") 'yas-expand-indent)
(global-set-key  "\C-c+" 'increment-number-at-point)
(global-set-key [f8] 'my-switch-to-previous-buffer)
;; (global-set-key (kbd "<tab>") 'indent-for-tab-command)
(global-set-key (kbd "<C-return>") 'end-of-line-and-indented-new-line)
(global-set-key (kbd "\C-x3") 'split-window-right-other-window)

(global-set-key (kbd "C-S-j") 'goto-primary-file)
(global-set-key (kbd "C-S-h") 'goto-secondary-file)



