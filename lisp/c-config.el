;;; package --- summary
;;; Functions and configuration related to c mode.

;;; Commentary:

;;; Code:

;;@============================= C Configuration.

(setq-default c-basic-offset 8)

(add-hook 'c-mode-hook
          '(lambda ()
             (outline-minor-mode)
             (hs-minor-mode)
	     (flycheck-mode)
	     (smartparens-mode)
	     ;; Kernel Coding Style
	     (setq c-basic-offset 8)
	     (setq c-default-style "k&r"
		   c-basic-offset 8
		   company-backends '(company-gtags company-c-headers))
             (setq outline-regexp "///" )))

(defun my-autoindent-c ()
  ""
  (interactive)
  (when (executable-find "indent")
    (shell-command (concat "indent -kr -cli0 -cbi0 -ss -i8 -ip8 -ppi 2 "
			   (buffer-file-name) ))))

;;@============================= FONTIFICATION
(font-lock-add-keywords 'c-mode
                        '(("@.+" . font-lock-keyword-face)))
