;;@============================= EMACS
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun split-window-right-other-window ()
  (interactive)
  (split-window-right)
  (other-window 1))

;;@============================= EDITING
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (dabbrev-expand nil)
    (indent-for-tab-command)))


(defun yas-dabbrev-or-next-field ()
  "Executes dabbrev when expanding a yasnippet field."
"Allows autocompletion inside a snippet field"
(interactive)
(if (looking-at "\\>")
(dabbrev-expand nil)
(yas-next-field-or-maybe-expand)))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline-and-indent)
  (yank))

(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun run-current-file ()
  "Runs the executable file generated after compilation. An executable with the same name as the buffer is assumed."
  (interactive)
  (async-shell-command (concat "." (file-name-sans-extension buffer-file-name))))


(defun c-hungry-delete-forward-and-indent ()
" c-hungry-delete-forward with added intent command."
  (interactive)
  (c-hungry-delete-forward)
  ( indent-for-tab-command))

;; PROTECT ABBREVS
(defun protect-underscore ()
 (interactive)
 (insert "_"))
(defun protect-dash ()
 (interactive)
 (insert "-"))
(defun protect-equal ()
 (interactive)
 (insert "="))

;;@============================= OTHER
(defun nautilus()
    (interactive)
  (start-process "nautilus" nil "nautilus" (buffer-file-name)))
  
(defun thunar()
  (interactive)
  (start-process "thunar" nil "thunar" (buffer-file-name) ))

