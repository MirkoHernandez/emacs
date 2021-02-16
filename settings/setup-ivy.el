;;@============================= HELM
(setf helm-boring-buffer-regexp-list '("\\` " "\\*helm" "\\*helm-mode"
				       "\\*Help" "\\*Buffer " 
                                       "\\*Echo Area" "\\*Minibuf" "\\*monky-cmd-process\\*"
                                       "\\*epc con" "\\*Compile-Log\\*" "\\*monky-process\\*"
                                       "\\*CEDET CScope\\*" "\\*Messages\\*" "\\*Flycheck error"
                                       "\\*.+(.+)" "elpa/.+" "tramp/.+"
                                       "\\*Gofmt Errors\\*" "\\*autopep8"
                                       "\\*magit-process:" "\\*magit-diff:" "\\*anaconda-mode\\*"))

;; Fix for find files in lines with @.
(setq helm-ff-guess-ffap-urls nil)

;;@============================= ICOMPLETE
(fido-mode -1)
(icomplete-mode t)
(icomplete-vertical-mode t) ; IComplete vertical mode

(setq icomplete-separator "\n")
(setq icomplete-hide-common-prefix nil)
(setq icomplete-in-buffer t)
(setq icomplete-max-delay-chars 0)
(setq icomplete-compute-delay 0)
(setq icomplete-show-matches-on-no-input t)

;;@============================= ORDERLESS
(require 'orderless)
(setq completion-styles '(partial-completion substring flex orderless))

;;@============================= Embark
(require 'minibuffer)
(with-eval-after-load 'minibuffer
  (setq completion-category-defaults nil)
  (setq completion-cycle-threshold 3)
  (setq completion-flex-nospace nil)
  (setq completion-pcm-complete-word-inserts-delimiters t)
  (setq completion-pcm-word-delimiters "-_./:| ")
  (setq completion-show-help nil)
  (setq completion-auto-help nil)
  (setq completion-ignore-case t))

(require 'embark)
(with-eval-after-load 'embark
  (setq embark-collect-initial-view-alist
        '((file . list)
          (buffer . list)
          (symbol . list)
          (line . list)
          (xref-location . list)
          (kill-ring . zebra)
          (t . list)))
  (setq embark-quit-after-action t)
  (setq embark-collect-live-update-delay 0.15)
  (setq embark-collect-live-initial-delay 0.3)

  (setq embark-key-action-separator (propertize " · " 'face 'shadow))
    (setq embark-action-indicator
        (let ((act (propertize "Act" 'face 'success)))
          (cons act (concat act " on '%s'"))))
  (setq embark-become-indicator (propertize "Become" 'face 'warning)))

;;@============================= IVY
(when nil
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil) 
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 25)

  ;; No regex 
  (setq ivy-initial-inputs-alist nil)

  (setq ivy-re-builders-alist
	'((swiper . ivy--regex-plus)
	  (swiper-isearch . ivy--regex-plus)
          (t      .  ivy--regex-fuzzy))) 

  (setq ivy-display-style 'fancy)
  (setq ivy-extra-directories nil) ;; ignore  folder ( . and  ..) entries  for counsel-find-file.
  (setq ivy-use-ignore-default 'always) ;; always ingore buffers
  (setq ivy-ignore-buffers '("^\*")) ;; Ignore some buffers in `ivy-switch-buffer'
  
;; Fix weird color blending in describe functions 
(custom-set-faces
 '(ivy-highlight-face ((t (:background "#383b31"))))
 '(ivy-current-match ((t (:foreground "#2299FF")))))


(ivy-set-actions
 'counsel-find-file
 '(("j" find-file-other-window "other window")
   ("b" counsel-find-file-cd-bookmark-action "cd bookmark")
   ("x" counsel-find-file-extern "open externally")
   ("d" delete-file "delete")
   ("r" counsel-find-file-as-root "open as root")))

(ivy-set-actions
 'ivy-switch-buffer
 '(("j" switch-to-buffer-other-window "other window")
   ("k" kill-buffer "kill")
   ("r" ivy--rename-buffer-action "rename")))

)




