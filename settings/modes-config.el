;;@============================= DABBREV
;; (setq dabbrev-case-replace t)
;; (setq dabbrev-case-fold-search t)
;; (setq dabbrev-upcase-means-case-search t)



;;@============================= IDO-UBIQUITOUS
;; (ido-ubiquitous-mode 1)

;;@============================= SMEX

;; smex, remember recently and most frequently usedr commands

;; (require   'smex)
;; (smex-initialize)

;;@============================= AVY
;; (funcall  avy-translate-char-function (read-key))

(setq avy-translate-char-function #'identity)
(setq avy-translate-char-function #'my-read-char)

(defun my-read-char ()
  (interactive)
  (let ((my-char (read-char "char" t) ) ;; character event| cambia con input method
	(my-char2 (read-key) )

	))

  ) (key-description [116])  => "C-g"

(quail-find-key1 116)

input-decode-map

;; 116  -> 121   
;; Goal  (read-key) ---> (read-char "" t)
(read-key)
(read-char "" t)
(read-event)
(event-modifiers 116)
(recent-keys)
keyboard-translate-table


;; Replace original avy-read with version that respects input method.
(defun avy-read (tree display-fn cleanup-fn)
  "Select a leaf from TREE using consecutive `read-key'.

DISPLAY-FN should take CHAR and LEAF and signify that LEAFs
associated with CHAR will be selected if CHAR is pressed.  This is
commonly done by adding a CHAR overlay at LEAF position.

CLEANUP-FN should take no arguments and remove the effects of
multiple DISPLAY-FN invocations."
  (funcall avy-translate-char-function (read-key))
  
  (catch 'done
    (setq avy-current-path "")
    (while tree
      (let ((avy--leafs nil))
        (avy-traverse tree
                      (lambda (path leaf)
                        (push (cons path leaf) avy--leafs)))
        (dolist (x avy--leafs)
          (funcall display-fn (car x) (cdr x))))
      ;; (let ((char (funcall avy-translate-char-function (read-key)))
      (let ((char (read-char "char: " t))
            window
            branch)
        (funcall cleanup-fn)
        (if (setq window (avy-mouse-event-window char))
            (throw 'done (cons char window))
          (if (setq branch (assoc char tree))
              (progn
                ;; Ensure avy-current-path stores the full path prior to
                ;; exit so other packages can utilize its value.
                (setq avy-current-path
                      (concat avy-current-path (string (avy--key-to-char char))))
                (if (eq (car (setq tree (cdr branch))) 'leaf)
                    (throw 'done (cdr tree))))
            (funcall avy-handler-function char)))))))



;;@============================= COMMON LISP
(setq inferior-lisp-program "sbcl")


;;@============================= RACKET
(add-hook 'racket-mode-hook (lambda ()
			      (outline-minor-mode)
			      (setq outline-regexp ";;@")
			      (diff-hl-mode t)))

;;@============================= KEYCHORD
;; (key-chord-mode 1)
;; (defvar key-chord-two-keys-delay 0.1)   ; 0.05 or 0.1
;; (defvar key-chord-one-key-delay 0.08)


;;@============================= GIMP
;; git clone git://github.com/pft/gimpmode.git
(load-if-exists (concat emacs-root  "emacs/packages/gimpmode/gimp-init.el"))


;;@============================= FLYCHECK
;; (set-face-attribute 'flycheck-error
                    ;; nil
		    ;; :underline
		    ;; '(:color "red" :style line))
;; (set-face-attribute 'flycheck-warning
		    ;; nil
		    ;; :underline
		    ;; '(:color "orange" :style line))


