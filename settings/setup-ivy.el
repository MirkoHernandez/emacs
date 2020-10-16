;;@============================= IVY
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




