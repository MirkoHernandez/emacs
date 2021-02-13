;;@============================= GLOBALS
(setq primary-ext-table
      #s(hash-table size 20 data (
				  ;; Angular
				  "\\.module.ts$"   (".model.ts" ".component.ts") 
				  "\\.component.ts$"   (".model.ts" ".html") 
				  "\\.component.html$"   (".component.scss" ".ts") 
				  "\\.component.scss$"   (".component.html" ".ts") 
				  ;; C/C++
				  "\\.c$\\|\\.cpp$"   (".h") 
				  "\\.h$" (".c" ".cpp")
				  ;; Fractal
				  "\\.hbs$\\|\\.mustache$\\|\\.twig$\\|\\.nunj"   (".scss")
				  "\\.scss$"   (".config.json" ".config.js" ".config.yaml" ".config.yml" ".hbs" ".mustache" ".twig" ".nunj")
				  "\\.js$\\|\\.json$\\|\\.yaml$\\|\\.yml$"   (".hbs" ".mustache" ".twig" ".nunj" ))))
;;@============================= FOCUS
(defun my/hs-toggle-hide ()
  (interactive)
  (end-of-line)
  (hs-toggle-hiding))

(defun swap-windows ()
  "If you have 2 windows, it swaps them." 
  (interactive) (cond ((not (= (count-windows) 2)) (message "You need exactly 2 windows to do this."))
		      (t
		       (let* ((w1 (nth 0 (window-list)))
			      (w2 (nth 1 (window-list)))
			      (b1 (window-buffer w1))
			      (b2 (window-buffer w2))
			      (s1 (window-start w1))
			      (s2 (window-start w2)))
			 (set-window-buffer w1 b2)
			 (set-window-buffer w2 b1)
			 (set-window-start w1 s2)
			 (set-window-start w2 s1)))))

;;@============================= NAVEGATION

;;@ Movement
(defun beginning-of-line-or-end-of-line ()
  "move to beginning of line, or end of line"
  (interactive)
  (if (bolp)
      (end-of-line)
    (beginning-of-line)))

;;@ switching buffers
(defun my/toggle-recent-buffer ()
   "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) t)))


(defun my/split-window-right-other-window ()
  (interactive)
  (split-window-right)
  (other-window 1))

;;@ Find corresponding files
(defun get-corresponding-file-extension (file hash-table)
   "Returns the  corresponding extensions if  FILE has one  of the
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
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun backward-kill-sexp-or-selection(beg end)
  "message region or \"empty string\" if none highlighted"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and beg end)
      (kill-region beg end)
    (call-interactively  'backward-kill-sexp)))

(defun backward-kill-word-or-selection(beg end)
  "message region or \"empty string\" if none highlighted"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and beg end)
      (kill-region beg end)
    (call-interactively  'backward-kill-word)))

(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s"))))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))


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

(defun previous-blank-line ()
  "Moves to the previous line containing nothing but whitespace."
  (interactive)
  (search-backward-regexp "^[ \t]*\n" nil t ))

(defun next-blank-line ()
  "Moves to the next line containing nothing but whitespace."
  (interactive)
  (forward-line)
  (search-forward-regexp "^[ \t]*\n" nil t)
  (forward-line -1))

;;@============================= SNIPPET Helpers
;; TODO: - Refactor into a reusable snippets framework.
;;       - Find reasonable abbrev replacement for most of the
;;         related functions.

;;@============================= HELPER FUNCTIONS

(defun modify-string-add-separator (string separators token-insert  &optional  keep-final-separator)
  "Return a string  similar to the original  STRING parameter but
with a token  appended to some of the elements.   Each element of
STRING  is  determined  by  the kind  of  SEPARATORS  (a  regular
expression) used.  TOKEN,  a string, is appended  to each element
of the original string.  The final argument KEEP-FINAL-SEPARATOR,
if  set to  not nil,  it includes  the last  separator, which  is
eliminated otherwise."
  (mapconcat (lambda (x)
               (if (not (equal  (string-trim x) ""))
                   (let  ((token (replace-regexp-in-string separators "" x)))
                     (setf string
			   (replace-regexp-in-string
			    token
			    (concat  token token-insert)
			    string)))))
             (delete-dups (split-string string separators))
             "")
  (setq string (string-trim-right string))
  ;; delete or keep the last separator.
  (if (not  keep-final-separator)
      (string-trim-right (substring string 0  (if token-insert (- (string-width token-insert)) nil )))
    (string-trim-right string)))

(defun modify-string-enclose-words (string separators token-b token-e &optional  exclude-list)
  "Return  a string  similar  to the  original STRING  parameter.
Each element of STRING is determined by the kind of SEPARATORS (a
regular  expression)  used.  TOKEN-B  and  TOKEN-E  are added  to
selected  elements of  the array  (at the  beginning and  the end
respectively).   The  EXCLUDE-LIST  is used  to  determine  which
elements are not going to be replaced."

  (mapconcat (lambda (x)
               (if (not
                    (cl-position-if #'(lambda (y) (equal y x))
				    (if exclude-list
					exclude-list '(""))))
                   (let  ((token x))
                     (setf string (replace-regexp-in-string
				   token
				   (concat  token-b token token-e) string )))))
             (delete-dups (split-string string separators))
             "")
  (setq string (string-trim-right string)))

;;@============================= EDITING FUNCTIONS

(defun refactor-line-or-selection-any (beg end )
  "Replace the selected text (or the line at point if no region
is active) with the exact same text but the elements inside the
selection are replaced with yasnippet templates."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and beg end)
      (let ((string  (buffer-substring-no-properties beg end) ))
        (kill-region beg end)
        (yas-expand-snippet (modify-string-enclose-words
			     string
			     "\\(\\.\\| \\|'\\|{\\|}\\|(\\|)\\|\\[\\|\\]\\|,\\|;\\)"
			     "${" "}"
			     '("") )))
    (let  ((beg (line-beginning-position))
           (end (line-end-position)))
      (if (and beg end)
          (refactor-line-or-selection-any beg end )
        nil ))))


(defun refactor-line-or-selection-identifiers-only (beg end )
  "Replace the selected  text (or the line at point  if no region
is active) with  the exact same text but the  elements inside the
selection are replaced with yasnippet templates.  Common keywords
for  programming languages(mainly  JavaScript)  are kept  without
change so that only identifiers should be available for editing."

  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and beg end)
      (let ((string  (buffer-substring-no-properties beg end) ))
        (kill-region beg end)
        (yas-expand-snippet (modify-string-enclose-words
			     string
			     "\\(\\.\\| \\|'\\|{\\|}\\|(\\|)\\|\\[\\|\\]\\|,\\|;\\)"
			     "${" "}"
			     '("" "var" "function" "return" ">=" "<=" "/"
			       "=" "+=" "/" "*=" "for" "if" "else" "console"
			       ">" "<" "=>" "log" "switch" "case" "while" "try"
			       "catch" "throw" "*" "*=" "%" "*=" "%" "-"
			       "*=" "+"  "debugger" "continue" "new" "that"
			       ":"  "=" "*=" "=" "*="  ) )))
    (let  ((beg (line-beginning-position))
           (end (line-end-position)))
      (if (and beg end)
          (refactor-line-or-selection-identifiers-only beg end )
        nil ))))





(defun  insert-concat-strings ()
  "Prompt for a list of  elements separated by a whitespace, then
a  string  is  created  and  inserted  with  each  element  as  a
single-quote string and a '+' character after each element except
for the last one."
  (interactive)
  (let  ((string (read-string "Strings: ")))
    (setq string (modify-string-enclose-words string " " "'" "'" ))
    (setq string (modify-string-add-separator string " " " +" ))
    (insert string)))


(defun  insert-sum-elements ()
  "Prompt for a list of  elements separated by a whitespace, then
a string is created and inserted  with a '+' character after each
element except the last one."
  (interactive)
  (let  ((string (read-string "Elements: ")))
    (setq string (modify-string-add-separator string " " " +" ))
    (insert string))
  (signal 'quit nil))


(defun  insert-string-list ()
  (interactive)
  (let  ((string (read-string "Strings: ")))
    (setq string (modify-string-enclose-words string " " "\"" "\""))
    (setq string (modify-string-add-separator string  " " "," ))
    (insert string)))
(defun  insert-string-list-single-quote ()
  (interactive)
  (let  ((string (read-string "Strings: ")))
    (setq string (modify-string-enclose-words string " " "'" "'"))
    (setq string (modify-string-add-separator string  " " "," ))
    (insert string)))


;;@============================= YASNIPPET SECTION

;; These are  basically glorified snippets  so only the  uncommon ones
;; are documented, I have them set up has functions since it is easier
;; that way to use them with abbrevs and it also helps to see the code
;; in one place when creating new ones.NOTE: The signal command is used
;; as a workaround to avoid the extra space generated by some abbrevs.

;; I prefer to  type spaces instead of commas  when entering arguments
;; to  functions and  in  arrays.  If  the  arguments themselves  have
;; spaces then I use two spaces to  set the commas.  This must be done
;; by   toggling   the   amount   of   spaces   before   calling   the
;; snippets.

(defvar my-text-spaces-for-commas  nil)

(defun toggle-one-or-two-spaces-for-commas ()
  "Set yastext-spaces-for-commas to use either one or two spaces for commas."
  (interactive)
  (setf my-text-spaces-for-commas
        (concat
         "$$(when (and yas-modified-p
                yas-moving-away-p)
       (replace-regexp-in-string"
         (if (string-match "\" \"" (if my-text-spaces-for-commas my-text-spaces-for-commas ""))
             "\"  \""
           "(if (string-match \"(.+)\" yas-text)  \"  \"   \" \")" )
         "\", \"  yas-text))")))


;; ;; Set one space as the  default.
(toggle-one-or-two-spaces-for-commas)

(defun my-argments-with-commas ()
  (interactive)
  (yas-expand-snippet (concat  "${1:"
                               my-text-spaces-for-commas
                               "}"
                               ))
  (signal 'quit nil))


(defun my-add-assignment-and-semicolon ()
  (interactive)
  (yas-expand-snippet "${1:foo} = $2;"))

(defun my-single-quote ()
  (interactive)
  (yas-expand-snippet (concat  "'$1'"
                               (if (equal ")" (char-to-string (following-char)))
                                   ""
                                 " ")))
  (signal 'quit nil))

(defun my-parens ()
  (interactive)
  (yas-expand-snippet (concat  "(${1:"
                               my-text-spaces-for-commas
                               "})"
                               (if (equal ")" (char-to-string (following-char)))
                                   ""
                                 " ")))
  (signal 'quit nil))

(defun my-brackets ()
  (interactive)
  (if (string-match-p " " (char-to-string (preceding-char)) )
      (backward-char nil))
  (yas-expand-snippet (concat  "[${1:"
                               my-text-spaces-for-commas
                               "}]"
                               (if (or (equal ")" (char-to-string (following-char)) )
                                       (equal "]" (char-to-string (following-char)) ))
                                   ""
                                 " ")))
  (signal'quit nil))


(defun my-function ()
  (interactive)
  (yas-expand-snippet (concat "$1(${2:"
                              my-text-spaces-for-commas
                              "})$0"))
  (signal'quit nil))

;;@============================= LISP
(defun my-cl-setf ()
  (interactive)
  (yas-expand-snippet "(setf $1)")
  (signal 'quit nil))


;;@============================= YASNIPPET ORG
(defun  my-org-new-task ()
  "Prompts for a schedule or deadline, inserts a timestamp at
current time. Then inserts a template for a todo item."

  (interactive)
  (insert "Added: ")
  (org-insert-time-stamp nil t t)
  (previous-line)
  (org-insert-todo-heading nil)
  (if  (y-or-n-p "SCHEDULE? ")
      (org-schedule t)
    (org-deadline t))
  (yas-expand-snippet "${1:TASK} ${2:CATEGORY$$(when (and yas-modified-p
                       yas-moving-away-p)
                         (concat \":\"  yas-text \":\"))}$0" ))

;;@============================= YASNIPPET CSS
(defun my-css-property ()
  "Insert snippet for a CSS property and value, px is appended to numeric values."
  (interactive)
  (yas-expand-snippet "$1: ${2:$$(when (and yas-modified-p
                       yas-moving-away-p
                       (not (eql (string-to-number yas-text) 0)))
              (concat  yas-text \"px\"))}; ")
  (signal 'quit nil))

;;@============================= YASNIPPET JAVASCRIPT
(defvar  my-text-js-math-replacements
  "$$(when (and yas-modified-p  yas-moving-away-p)
      (cond
       ((string-match   \"^f\\$\"  yas-text) \"floor\")
       ((string-match   \"^s\$\"   yas-text) \"sin\")
       ((string-match   \"^c\$\"   yas-text) \"cos\")
       ((string-match   \"^r\\$\"  yas-text) \"round\")
       ((string-match   \"^d\\$\"  yas-text) \"random\")
       ((string-match   \"^q\\$\"  yas-text) \"sqrt\")
       ((string-match   \"^t\\$\"  yas-text) \"tan\")
       ))")

(defun my-js-math ()
  (interactive)
  (yas-expand-snippet (concat "Math.${1:"
                              my-text-js-math-replacements
                              "}(${2:"
                              my-text-spaces-for-commas
                              "})$0"))
  (signal'quit nil))


(defun  my-js-multiple-assignment ()
  (interactive)
  (let  ((string (read-string "Variables: ")))
    (setq string (modify-string-add-separator string  " " " = ${},\n" t ))
    (yas-expand-snippet string)))

(defun my-js-this ()
  (interactive)
  (yas-expand-snippet "this.$1")
  (signal 'quit nil))

(defun my-js-var ()
  (interactive)
  (yas-expand-snippet "var $1 = $2;")
  (signal 'quit nil))

(defun my-js-object-item ()
  (interactive)
  (yas-expand-snippet (concat "$1 : $2")))


(defun my-js-object-item-same-name ()
  (interactive)
  (yas-expand-snippet "$1 : $1,"))

(defun my-js-object-function ()
  (interactive)
  (yas-expand-snippet (concat "$1 : function(${2:"
                              my-text-spaces-for-commas
                              "}) {
$3
},")))
