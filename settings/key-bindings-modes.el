;;@============================= SEQUENCES
;; Replace
(define-prefix-command  'my-replace-map)
(global-set-key (kbd "M-r") 'my-replace-map)
(progn

  (define-key my-replace-map (kbd "r") 'query-replace-in-region)
  (define-key my-replace-map (kbd "b") 'query-replace-regexp)
  (define-key my-replace-map (kbd ".") (lambda nil "Doc" (interactive)
					 (setq current-prefix-arg '(4)) ; C-u
					 (call-interactively 'smartscan-symbol-replace)))
  (which-key-add-key-based-replacements  "M-r ." "Replace Symbol in defun")
  (define-key my-replace-map (kbd ",") 'smartscan-symbol-replace)
  )

;; Navigation
(define-prefix-command  'my-navigation-map)
(global-set-key (kbd "M-i") 'my-navigation-map)
(progn
  (define-key my-navigation-map (kbd "i") 'imenu)
  (define-key my-navigation-map (kbd "b") 'bookmark-jump)
  (define-key my-navigation-map (kbd "f") 'projectile-find-file)
  (define-key my-navigation-map (kbd "o") 'find-file)
  (define-key my-navigation-map (kbd "p") 'projectile-switch-project)
  (define-key my-navigation-map (kbd "s") 'ag)
  (define-key my-navigation-map (kbd "u") 'switch-to-buffer)
  (define-key my-navigation-map (kbd ",") 'pop-global-mark)
  (define-key my-navigation-map (kbd "m") 'magit))

;; Bookmarks
(define-prefix-command  'my-bookmarks-map)
(global-set-key (kbd "<f2>") 'my-bookmarks-map)
(progn
  (define-key my-bookmarks-map (kbd "b") 'helm-bookmarks)
  (define-key my-bookmarks-map (kbd "i") 'insert-register)
  (define-key my-bookmarks-map (kbd "j") 'jump-to-register)
  (define-key my-bookmarks-map (kbd "r") 'point-to-register)
  (define-key my-bookmarks-map (kbd "m") 'bookmark-set)
  (define-key my-bookmarks-map (kbd "w") 'window-configuration-to-register)
  (define-key my-bookmarks-map (kbd "x") 'copy-to-register))

;;@============================= GLOBAL KEYBINDINGS
;;@@====================== PROJECTILE
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;@@====================== HYDRA
;; (global-set-key (kbd "M-r") 'hydra-replace/body)
;; (global-set-key (kbd "<f2>") 'hydra-bookmarks/body)
;; (global-set-key (kbd "C-l") 'hydra-navigation/body)
;; (global-set-key (kbd "C-d") 'hydra-delete/body)
;; (global-set-key (kbd "C-x SPC") 'hydra-rectangle/body)
;; (global-set-key (kbd "M-a") 'hydra-align/body)
;; (global-set-key (kbd "<apps>") 'hydra-perspective/body)
;; (global-set-key (kbd "<menu>") 'hydra-perspective/body)

;;@@====================== TREEMACS
(global-set-key (kbd "C-S-h") 'treemacs-add-and-display-current-project)
(global-set-key (kbd "C-h") 'treemacs)

;;@@====================== MULTIPLE  CURSORS:
;; Rebind emacs Defaults
(global-set-key (kbd "C-S-o") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;;@@====================== SMARTPARENS
(global-set-key (kbd "C-(") 'sp-wrap-round)
(global-set-key (kbd "C-{") 'sp-wrap-curly)
(global-set-key (kbd "C-]") 'sp-wrap-square)
;;@@====================== SCSS
(add-hook 'scss-mode-hook (lambda ()
			    (define-key scss-mode-map (kbd "M-.")  'xref-find-definitions)))


;;@@====================== YASNIPPETS
(global-set-key (kbd "C-x y v") 'yas-visit-snippet-file)
(global-set-key (kbd "C-x y n") 'yas-new-snippet)
(global-set-key (kbd "C-x y r") 'yas-reload-all)
(global-set-key (kbd "C-x y y") 'yas-expand)
;;@@====================== AUTOYASNIPPETS
(global-set-key (kbd "C-x y a") 'aya-create)
(global-set-key (kbd "C-x y e") 'aya-expand)
;;@@====================== EXPAND REGION
(global-set-key (kbd "C-;") 'er/expand-region) 
;; (global-set-key (kbd "C") 'er/contract-region)

;;@@====================== COMPANY MODE 

;; (global-set-key (kbd "C-c /") 'company-files)        ; Force complete file names on "C-c /" key
;; (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
;; (define-key company-active-map (kbd "C-P") 'company-select-previous-or-abort)
;; (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
;; (define-key company-active-map (kbd "C-N") 'company-select-next-or-abort)
;; (define-key html-mode-map (kbd "C-'") 'company-web-html)

;;@@====================== IEDIT
;; (define-key global-map (kbd "C-;") 'iedit-mode)

;;@@====================== SMARTSCAN
;; (define-key global-map (kbd "M-p") 'smartscan-symbol-go-backward)
;; (define-key global-map (kbd "M-n") 'smartscan-symbol-go-forward)

;;@@====================== AUTOCOMPLETE
(define-key ac-menu-map (kbd "M-n") 'ac-next)
(define-key ac-menu-map (kbd "M-p") 'ac-previous)
;;(define-key ac-menu-map (kbd "<tab>") nil)
;;(define-key ac-menu-map (kbd "<S-tab>") nil)
;;(define-key ac-complete-mode-map (kbd "<tab>") 'yas-next-field)

;;@@====================== DIRED


(add-hook 'dired-mode-hook (lambda ()
			     ;;(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
			     (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
			     (define-key dired-mode-map "." 'hydra-dired/body)
			     (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
			     ))

;;(define-key dired-mode-map (kbd "C-q") 'dired-toggle-read-only)


;;@@====================== EWW | SHRFACE
(with-eval-after-load 'eww
  (define-key eww-mode-map (kbd "<tab>") 'org-cycle)
  (define-key eww-mode-map (kbd "S-<tab>") 'org-shifttab)
  (define-key eww-mode-map (kbd "j") 'forward-paragraph)
  (define-key eww-mode-map (kbd "k") 'backward-paragraph)
  (define-key eww-mode-map (kbd "C-t") 'shrface-toggle-bullets)
  (define-key eww-mode-map (kbd "C-j") 'shrface-next-headline)
  (define-key eww-mode-map (kbd "C-k") 'shrface-previous-headline)
  (define-key eww-mode-map (kbd "C-i") 'shrface-links-helm) ; or 'shrface-links-helm
  (define-key eww-mode-map (kbd "C-o") 'shrface-headline-helm)) ; or 'shrface-headline-helm



;;@============================= MODES  KEYBINDINGS
;;@@====================== IVY COUNSEL
(when nil 
  (add-hook 'ivy-mode-hook (lambda ()
			     (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-backward-kill-word)
			     (define-key ivy-minibuffer-map (kbd "C-o") 'dabbrev-expand)))

  (add-hook 'counsel-mode-hook (lambda ()                    
				 (with-eval-after-load 'counsel
				   (let ((done (where-is-internal #'ivy-done     ivy-minibuffer-map t)))
				     (define-key ivy-minibuffer-map done #'ivy-alt-done)
				     (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory)
				     ))))

  )

;;@@====================== NEOTREE
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key neotree-mode-map (kbd "C-h") 'neotree-hide)))

;;@@====================== ORG
(add-hook 'org-mode-hook (lambda ()                    
			   (define-key org-mode-map (kbd "<S-return>")
			     '(menu-item "" nil
					 :filter (lambda (&optional _)
						   (when(org-at-heading-p)
						     #'my/org-tree-open-in-right-frame))))
			   ;; 'my/org-tree-open-in-right-frame
			   ;; :filter (lambda (&optional _) (unless (org-at-heading-p)))) 
			   (define-key org-mode-map (kbd "C-c u") 'org-up-element)
			   (define-key org-mode-map (kbd "C-c e") 'org-texinfo-export-to-info)
			   (define-key org-mode-map (kbd "C-c w") 'unpackaged/org-refile-to-datetree)
			   (define-key org-mode-map (kbd "C-c b") (lambda ()  (interactive)
								    (org-emphasize ?\*)))))

;;@@====================== PAREDIT
(add-hook 'paredit-mode-hook (lambda ()
			       (define-key paredit-mode-map  (kbd "C-<right>") nil)
			       (define-key paredit-mode-map  (kbd "C-<left>") nil)
			       (define-key paredit-mode-map (kbd "C-S-<right>") 'paredit-forward-slurp-sexp)
			       (define-key paredit-mode-map (kbd "C-S-<left>") 'paredit-forward-barf-sexp)))


;;@@====================== HELP MODE
(add-hook 'help-mode-hook
	  (lambda ()
	    (define-key help-mode-map (kbd "q") (lambda() (interactive) (quit-window t)))
	    ))

;;@============================= PROGRAMMING MODES KEYBINDINGS
;;@@====================== GO
(add-hook 'c-mode-common-hook (lambda ()
                                (define-key c-mode-base-map  (kbd "C-<backspace>") 'backward-kill-word-or-selection)))

;;@@====================== JAVASCRIPT
(add-hook 'js2-mode-hook (lambda ()
                           (define-key js2-mode-map  (kbd "C-x C-e") 'js-send-last-sexp)))
;;@@====================== PYTHON
(add-hook 'python-mode-hook (lambda ()
                              (define-key python-mode-map  (kbd "C-x C-e") 'python-shell-send-defun)))
;;@@====================== C
(add-hook 'c-mode-common-hook (lambda ()
				(define-key c-mode-base-map  (kbd "C-<tab>") 'c-indent-defun)
				(define-key c-mode-base-map  (kbd "C-j") 'newline)
				(define-key c-mode-base-map  (kbd "M-/") 'c-mark-function)
				(define-key c-mode-base-map  (kbd "C-.") 'xref-find-references)
				(define-key c-mode-base-map  (kbd "<C-return>") 'electric-newline-and-maybe-indent)
                                (define-key c-mode-base-map  (kbd "C-<backspace>") 'backward-kill-word-or-selection)))
;; (add-hook 'compilation-mode-hook (lambda ()
;; (define-key compilation-mode-map  "q" 'kill-buffer-and-window )))

;;@@====================== RACKET
(add-hook 'racket-mode-hook
          (lambda ()
	    (paredit-mode 1)
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)
            (define-key racket-mode-map (kbd "C-x e") 'racket-send-last-sexp)))

;;@@====================== EMACS LISP
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (define-key emacs-lisp-mode-map (kbd   "C-c C-b") 'eval-buffer)))

;;@@====================== SCHEME
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
