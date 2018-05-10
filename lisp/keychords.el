
;;@============================= ORG KEYCHORDS
(add-hook 'org-mode-hook (lambda ()
                           (ac-html-bootstrap+)
                           (key-chord-define org-mode-map "xz"   'yas-org-new-task)
                           (key-chord-define org-mode-map "sx"   'org-time-stamp-inactive)))

;;@============================= KEYCHORDSfine-key compilation-mode-map  "q" 'kill-buffer-and-window )

 ;;(define-key yas-minor-mode-map "<tab>" nil)
;; (define-key yas-minor-mode-map [return] 'yas-next-field)



;;(define-key c-mode-map "{{" 'previous-error)
;;(define-key c-mode-map "}}" 'next-error)


(key-chord-define-global ",."     "[]\C-b")
(key-chord-define-global "dt"    'duplicate-line)
(key-chord-define-global "qw"   ' c-beginning-of-statement)
(key-chord-define-global "kl"   'dabbrev-expand)
(key-chord-define-global "KL"   'dabbrev-expand)
(key-chord-define-global "jk"   'yas-expand)
(key-chord-define-global "JK"   'yas-expand)
(key-chord-define-global "jl"   'hippie-expand)
(key-chord-define-global "dg"   'c-hungry-delete-forward-and-indent)
(key-chord-define-global "DG"   'c-hungry-delete-forward-and-indent)
(key-chord-define-global "db"   'delete-blank-lines)
(key-chord-define-global "wr"   'kill-region)
(key-chord-define-global "wt"   'yank)
(key-chord-define-global "qq"   'toggle-one-or-two-spaces-for-commas)
(key-chord-define-global "ww"   'jump-to-register)
;; (key-chord-define-global "kn"   'hs-hide-all)
;; (key-chord-define-global "km"   'hs-show-all)
(key-chord-define-global "ññ"   'self-insert-command)
(key-chord-define-global "hh"   'insert-register)
(key-chord-define-global "pp"  'projectile-find-file)

;;@============================= LISP KEYCHORDS

(key-chord-define lisp-mode-map "kk"  'slime-eval-last-expression)
(key-chord-define emacs-lisp-mode-map "kk"  'eval-last-sexp)
(key-chord-define lisp-mode-map "ii"  'slime-eval-defun)


(key-chord-define lisp-mode-map "dd"  'slime-describe-symbol)
;; (key-chord-define org-mode-map "dd"  'org-emphasize)
;; (key-chord-define org-mode-map "ss"  'org-drill-resume )
;; (key-chord-define org-mode-map "aa"  'org-set-tags-command )

;;@============================= SCREENPLAY KEYCHORDS

;;(key-chord-define screenplay-mode-map "jj"  'screenplay-dialog-block)
;;(key-chord-define screenplay-mode-map "dd"  'screenplay-transition)
;;(key-chord-define screenplay-mode-map "ii"  'screenplay-)


;;;@============================= CONFIG KEYCHORDS
(defvar key-chord-two-keys-delay 0.05	; 0.05 or 0.1
  "Max time delay between two key press to be considered a key chord.")

