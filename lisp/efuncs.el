;;@============================= NAVEGATION

(defun my-hs-toggle-hide ()
  (interactive)
  (end-of-line)
  (hs-toggle-hiding))


;;@ switching buffers

(defun my-switch-to-previous-buffer ()
   "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun split-window-right-other-window ()
  (interactive)
  (split-window-right)
  (other-window 1))


;;@ Find corresponding files
;; Primary-ext table
(setq primary-ext-table
      #s(hash-table size 20 data (
				  ;; Angular
				  "\\.module.ts$"   (".component.ts") 
				  "\\.component.ts$"   (".html") 
				  "\\.component.html$"   (".ts") 
				  "\\.component.scss$"   (".ts") 
				  ;; C/C++
				  "\\.c$\\|\\.cpp$"   (".h") 
				  "\\.h$" (".c" ".cpp")
				  ;; Fractal
				  "\\.hbs$\\|\\.mustache$\\|\\.twig$\\|\\.nunj"   (".scss")
				  "\\.scss$"   (".hbs" ".mustache" ".twig" ".nunj")
				  "\\.js$\\|\\.json$\\|\\.yaml$\\|\\.yml$"   (".hbs" ".mustache" ".twig" ".nunj" ))))
  ;; Secondary-ext table
(setq secondary-ext-table
      #s(hash-table size 20 data (
				  ;; Angular
				  "\\.component.ts$"   (".model.ts") 
				  "\\.component.html$"   (".component.scss") 
				  "\\.component.scss$"   (".component.html")
				  ;; Fractal
				  "\\.hbs$\\|\\.mustache$\\|\\.twig$\\|\\.nunj"   (".config.json" ".config.js" ".config.yaml" ".config.yml") 
				  "\\.scss$"   (".config.json" ".config.js" ".config.yaml" ".config.yml") 
				  )))


(defun get-corresponding-file-extension (file hash-table)
   "Returns the  corresponding extensions if  FILE as one  of the
extensions included in the keys of HASH-TABLE"
    (let ((new-file nil))
    (maphash (lambda (key value)
		 (when (string-match key file)
		    (setq new-file  value)))
	    hash-table)
    new-file))

(defun find-corresponding-file (file extensions)
  "Find a corresponding file for FILE based on the EXTENSIONS to search for."
   (let ((base-filename (file-name-sans-extension file)))
     (cond
      ((null extensions) nil)
      ((file-exists-p (concat base-filename (car  extensions)))
       (concat base-filename (car extensions)))
      ((file-exists-p (concat  (replace-regexp-in-string "\\..*" "" base-filename) (car extensions)))
       (concat  (replace-regexp-in-string "\\..*" "" base-filename) (car extensions)))
      (t (find-corresponding-file file (cdr extensions))))))

(defun goto-primary-file ()
  "Go to the primary file that corresponds to the current buffer"
  (interactive)
  (let* ((extensions  (get-corresponding-file-extension  (replace-regexp-in-string "<.*" ""  (buffer-name))
							 primary-ext-table)) 
	 (file (find-corresponding-file (buffer-name) extensions)))
    (if file
	(find-file file)
      (error "Unable to find a corresponding file"))))

(defun goto-secondary-file ()
  "Go to  the secondary file that corresponds to the current buffer"
  (interactive)
  (let* ((extensions  (get-corresponding-file-extension  (replace-regexp-in-string "<.*" ""  (buffer-name))
							 secondary-ext-table)) 
	 (file (find-corresponding-file (buffer-name) extensions)))
    (if file
	(find-file file)
      (error "Unable to find a corresponding file"))))

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

