;;; package --- summary
;;; Functions and configuration related to C and C++ mode.

;;; Commentary:

;;; Code:

;;@============================= C Configuration.
(setq compilation-skip-threshold 2)
(setq compilation-ask-about-save nil)


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
  (c-set-offset 'statement-cont 0)
  (c-set-offset 'arglist-intro 8)
  (c-set-offset 'statement-case-open 0)
  ;; Outline regex
  (setq outline-regexp "	*///" )
  )

(add-hook 'c-mode-common-hook 'c-config-hook)

;;@============================= FONTIFICATION
(font-lock-add-keywords 'c-mode
                        '(("@.+" . font-lock-keyword-face)))

;;@============================= XREF
(add-to-list 'xref-backend-functions 'gxref-xref-backend)
