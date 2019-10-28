;;;@============================= KEYCHORD CONFIG 
(defvar key-chord-two-keys-delay 0.05	; 0.05 or 0.1
  "Max time delay between two key press to be considered a key chord.")


;;@============================= GLOBAL
;; editing
(key-chord-define-global ",."     "[]\C-b")
(key-chord-define-global "dt"    'duplicate-line)
(key-chord-define-global "kl"   'dabbrev-expand)
(key-chord-define-global "KL"   'dabbrev-expand)
(key-chord-define-global "jk"   'yas-expand)
(key-chord-define-global "JK"   'yas-expand)
(key-chord-define-global "jl"   'hippie-expand)
;; movement
(key-chord-define-global "qw"   'c-beginning-of-statement)
;;delete 
(key-chord-define-global "dg"   'c-hungry-delete-forward-and-indent)
(key-chord-define-global "DG"   'c-hungry-delete-forward-and-indent)
(key-chord-define-global "db"   'delete-blank-lines)
(key-chord-define-global "wf"   'kill-region)
(key-chord-define-global "wg"   'yank)

;; narrow
(key-chord-define-global "hh"   'hs-hide-level)

;; (key-chord-define-global "km"   'hs-show-all)
;; misc
(key-chord-define-global "yy"  'projectile-find-file)
(key-chord-define-global "fg"   'helm-ag)
(key-chord-define-global "jj"   'avy-goto-word-1)
(key-chord-define-global "qq"   'outline-hide-sublevels)
(key-chord-define-global "ww"   'outline-show-all)
(key-chord-define-global ";;"   'add-semicolon)

;;@============================= SMARTPARENS
(key-chord-define-global "(("   'sp-wrap-round)
(key-chord-define-global "{{"   'sp-wrap-curly)
(key-chord-define-global "[["   'sp-wrap-square)

;;@============================= C
(add-hook 'c-mode-hook (lambda ()
			 (key-chord-define c-mode-map "ii"  'c-indent-defun)))
;;@============================= ORG 
(add-hook 'org-mode-hook (lambda ()
                           (key-chord-define org-mode-map "xz"   'yas-org-new-task)
                           (key-chord-define org-mode-map "sx"   'org-time-stamp-inactive)))

;;@============================= LISP KEYCHORDS

;; (key-chord-define lisp-mode-map "kk"  'slime-eval-last-expression)
;; (key-chord-define emacs-lisp-mode-map "kk"  'eval-last-sexp)
;; (key-chord-define lisp-mode-map "ii"  'slime-eval-defun)


(key-chord-define lisp-mode-map "dd"  'slime-describe-symbol)
;; (key-chord-define org-mode-map "dd"  'org-emphasize)
;; (key-chord-define org-mode-map "ss"  'org-drill-resume )
;; (key-chord-define org-mode-map "aa"  'org-set-tags-command )

;;@============================= SCREENPLAY 

;;(key-chord-define screenplay-mode-map "jj"  'screenplay-dialog-block)
;;(key-chord-define screenplay-mode-map "dd"  'screenplay-transition)
;;(key-chord-define screenplay-mode-map "ii"  'screenplay-)



