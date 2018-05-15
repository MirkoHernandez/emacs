;;; package --- summary
;;; Functions and configuration related to c mode.

;;; Commentary:

;;; Code:

;;@============================= C Configuration.

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Kernel Coding Style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))


;;@============================= FONTIFICATION
(font-lock-add-keywords 'c-mode
                        '(("@.+" . font-lock-keyword-face)))
(font-lock-add-keywords 'org-mode
                        '(("@.+" . font-lock-keyword-face)))

;;@============================= OTHER
(setq-default c-basic-offset 8)

(add-hook 'c-mode-hook
          '(lambda ()
             (outline-minor-mode)
             (hs-minor-mode)
	     (setq c-basic-offset 8)
	     (setq c-default-style "k&r"
		   c-basic-offset 8
		   company-backends '(company-gtags company-c-headers))
             (setq outline-regexp "\\(@\\* \\|@\\*\\* \\|@\\*\\*\\* \\|@ \\| @ \\)" )))




(defun my-autoindent-c ()
  (interactive)
  (when (executable-find "indent")
    (shell-command (concat "indent -kr -cli0 -cbi0 -ss -i8 -ip8 -ppi 2 "
			   (buffer-file-name) ))))
	  
