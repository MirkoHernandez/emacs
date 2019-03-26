;;@============================= EMACS
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun split-window-right-other-window ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun corresponding-file (base-filename expected)
  (if (file-exists-p (concat base-filename expected))
	  (concat base-filename expected)
    nil))

(defun find-corresponding-file ()
  "Find the file that corresponds to this one."
  (interactive)
  (find-file
   (let ((base-filename (file-name-sans-extension (buffer-name)))
	 (file-name (buffer-name)))
     (or 
     (cond
      ;; Cpp config
      ((string-match "\\.c$" file-name)
        (corresponding-file base-filename ".h"))
      ((string-match "\\.cpp$" file-name)
        (corresponding-file base-filename ".h"))
      ((string-match "\\.h$" file-name)
       (or (corresponding-file base-filename ".c")
	   (corresponding-file base-filename ".cpp")
       ))
      ;; Fractal template to config.
      ((string-match "\\.hbs$\\|\\.mustache$\\|\\.twig$\\|\\.nunj" file-name)
       (or (corresponding-file base-filename ".config.json")
	   (corresponding-file base-filename ".config.js")
	   (corresponding-file base-filename ".config.yaml")
	   (corresponding-file base-filename ".config.yml")))
      ;; Fractal config to template.
      ((string-match "\\.js$\\|\\.json$\\|\\.yaml$\\|\\.yml$" file-name)
       (let ((base-filename (car (split-string base-filename ".config"))))
	 (or (corresponding-file base-filename ".hbs")
	     (corresponding-file base-filename ".mustache")
	     (corresponding-file base-filename ".twig")
	     (corresponding-file base-filename ".nunj")))))
     (error "Unable to find a corresponding file")))))

(defun find-corresponding-file-other-window ()
  "Find the file that corresponds to this one."
  (interactive)
  (find-file-other-window buffer-file-name)
  (casey-find-corresponding-file)
  (other-window -1))

;;@============================= EDITING
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (dabbrev-expand nil)
    (indent-for-tab-command)))

(defun add-semicolon ()
  "Go to  the end of  the line,  delete any extra  whitespace and
add a semicolon  (if there isn't one already in  place), then go
to the next line."
  (interactive)
  (move-end-of-line 1)
  (delete-horizontal-space)
  (if  (equal ";" (char-to-string (preceding-char)))
      nil
    (insert ";"))
  (next-line))

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

(defun c-hungry-delete-forward-and-indent ()
"c-hungry-delete-forward and indent"
  (interactive)
  (c-hungry-delete-forward)
  ( indent-for-tab-command))

(defun query-replace-in-region (old-word new-word)
  "Perform a replace-string in the current region."
  (interactive "sReplace: \nsReplace: %s  With: ")
  (save-excursion (save-restriction
		    (narrow-to-region (mark) (point))
		    (beginning-of-buffer)
		    (replace-string old-word new-word)
		    )))

;; Protect abbrevs
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
(defun run-current-file ()
  "Runs the executable file generated after compilation. An executable with the same name as the buffer is assumed."
  (interactive)
  (async-shell-command (concat "." (file-name-sans-extension buffer-file-name))))

(defun nautilus()
    (interactive)
  (start-process "nautilus" nil "nautilus" (buffer-file-name)))
  
(defun thunar()
  (interactive)
  (start-process "thunar" nil "thunar" (buffer-file-name) ))

