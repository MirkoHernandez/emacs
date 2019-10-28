;;; package --- summary
;;; Functions and configuration related to c mode.

;;; Commentary:

;;; Code:

;;@============================= C Configuration.
(setq compilation-skip-threshold 2)

(setq c-basic-offset 8)

(defun c-config-hook ()
  (outline-minor-mode)
  (hs-minor-mode)
  (flycheck-mode)
  (smartparens-mode)
  ;; Kernel Coding Style
  (setq c-default-style "k&r"
	c-basic-offset 8
	company-backends '(company-gtags company-c-headers))
  ;; Style modifications
  (c-set-offset 'arglist-intro 8)
  (c-set-offset 'statement-case-open 0)
  ;; Outline regex
  (setq outline-regexp "///" )
  )

(add-hook 'c-mode-common-hook 'c-config-hook)

(defun my-autoindent-c ()
  ""
  (interactive)
  (when (executable-find "indent")
    (shell-command (concat "indent -kr -cli0 -cbi0 -ss -i8 -ip8 -ppi 2 --line-length185 "
			   (buffer-file-name) ))))

;;@============================= FONTIFICATION
(font-lock-add-keywords 'c-mode
                        '(("@.+" . font-lock-keyword-face)))
