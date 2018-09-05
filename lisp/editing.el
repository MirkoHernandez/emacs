
;;; editing.el --- Some of my editing functions.
;;; Commentary:

;; TODO: - Refactor into a reusable snippets framework.
;;       - Find reasonable abbrev replacement for most of the
;;         related functions.

;; Here are some of the functions that I find useful when I'm editing,
;; the only dependency for using them is yasnippet.  I use some of the
;; snippets with either an abbrev or a key-chord; since the snippets
;; can be nested this facilitates fast text insertion and movement in
;; and out of strings and parentheses; the goal is to minimize the use
;; of the movement keys as much as possible.

;;; Code:

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
                     (setf string (replace-regexp-in-string token
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
                    (position-if #'(lambda (y) (equal y x)) (if exclude-list exclude-list '(""))))
                   (let  ((token x))
                     (setf string (replace-regexp-in-string token  (concat  token-b token token-e) string )))))
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
        (yas-expand-snippet (modify-string-enclose-words string
                                                         "\\(\\.\\| \\|'\\|{\\|}\\|(\\|)\\|\\[\\|\\]\\|,\\|;\\)" "${" "}" '("") )))
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
        (yas-expand-snippet (modify-string-enclose-words string   "\\(\\.\\| \\|'\\|{\\|}\\|(\\|)\\|\\[\\|\\]\\|,\\|;\\)"  "${" "}"
                                                         '("" "var" "function" "return" ">=" "<=" "/" "=" "+=" "/" "*=" "for" "if" "else" "console"
                                                           ">" "<" "=>" "log" "switch" "case" "while" "try" "catch" "throw" "*" "*=" "%" "*=" "%" "-"
                                                           "*=" "+"  "debugger" "continue" "new" "that" ":"  "=" "*=" "=" "*="  ) )))
    (let  ((beg (line-beginning-position))
           (end (line-end-position)))
      (if (and beg end)
          (refactor-line-or-selection-identifiers-only beg end )
        nil ))))


(defun  add-semicolon ()
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
