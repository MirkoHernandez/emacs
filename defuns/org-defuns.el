;;@============================= ORG
(defun my/org-tree-open-in-right-frame ()
  (interactive)
  (split-window-right)
  (org-tree-to-indirect-buffer)
  (windmove-right))



;;@ Unpackaged refile defuns - refile to datatree using timestamp in entry. 
(defun unpackaged/org-refile-to-datetree-using-ts-in-entry (which-ts file &optional subtree-p)
  "Refile current entry to datetree in FILE using timestamp found in entry.
WHICH should be `earliest' or `latest'. If SUBTREE-P is non-nil,
search whole subtree."
  (interactive (list (intern (completing-read "Which timestamp? " '(earliest latest)))
                     (read-file-name "File: " (concat org-directory "/") nil 'mustmatch nil
                                     (lambda (filename)
                                       (string-suffix-p ".org" filename)))
                     current-prefix-arg))
  (require 'ts)
  (let* ((sorter (pcase which-ts
                   ('earliest #'ts<)
                   ('latest #'ts>)))
         (tss (unpackaged/org-timestamps-in-entry subtree-p))
         (ts (car (sort tss sorter)))
         (date (list (ts-month ts) (ts-day ts) (ts-year ts))))
    (unpackaged/org-refile-to-datetree file :date date)))

;;;###autoload
(defun unpackaged/org-timestamps-in-entry (&optional subtree-p)
  "Return timestamp objects for all Org timestamps in entry.
 If SUBTREE-P is non-nil (interactively, with prefix), search
 whole subtree."
  (interactive (list current-prefix-arg))
  (save-excursion
    (let* ((beg (org-entry-beginning-position))
           (end (if subtree-p
                    (org-end-of-subtree)
                  (org-entry-end-position))))
      (goto-char beg)
      (cl-loop while (re-search-forward org-tsr-regexp-both end t)
               collect (ts-parse-org (match-string 0))))))

;;;###autoload
(cl-defun unpackaged/org-refile-to-datetree (file &key (date (calendar-current-date)) entry)
  "Refile ENTRY or current node to entry for DATE in datetree in FILE."
  (interactive (list (read-file-name "File: " (concat org-directory "/") nil 'mustmatch nil
                                     (lambda (filename)
                                       (string-suffix-p ".org" filename)))))
  ;; If org-datetree isn't loaded, it will cut the tree but not file
  ;; it anywhere, losing data. I don't know why
  ;; org-datetree-file-entry-under is in a separate package, not
  ;; loaded with the rest of org-mode.
  (require 'org-datetree)
  (unless entry
    (org-cut-subtree))
  ;; Using a condition-case to be extra careful. In case the refile
  ;; fails in any way, put cut subtree back.
  (condition-case err
      (with-current-buffer (or (org-find-base-buffer-visiting file)
                               (find-file-noselect file))
        (org-datetree-file-entry-under (or entry (car kill-ring)) date)
        (save-buffer))
    (error (unless entry
             (org-paste-subtree))
           (message "Unable to refile! %s" err))))

;;@============================= Refile
(defun my/refile (file headline &optional arg)
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile arg nil (list headline file nil pos)))
  (switch-to-buffer (current-buffer)))



;;@============================= Import files to src blocks
(defun get-string-from-file(filepath)
  "Return filepath's file content as a string."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(defun file-to-src-block (mode file)
  (concat "#+NAME: " (file-name-nondirectory file)   "
#+BEGIN_SRC " mode" 
"
(get-string-from-file file)
"
#+END_SRC\n")
  )

(defun import-files-to-src-blocks (folder mode extension level)
  (let* ((txt "\n")
	 (files (directory-files-recursively folder extension t (lambda (subdir) ;; ugly little hack to recursively generate the correct org header.
								  (setq txt  (concat txt  level " " (file-name-nondirectory subdir) "\n"
										     (import-files-to-src-blocks subdir mode extension (concat level "*" ))))
								  nil
								  ))))
    (concat txt (when (equal level "**") "*  \n")
	    (mapconcat
	     (lambda (src)
	       (unless (file-directory-p src) 
		 (file-to-src-block mode src)))
	     files
	     "\n"
	     ))))

(defun my/folder-to-src-blocks (folder mode extension)
  (interactive "DFolder: \nsMode: \nsExtension: ")
  (insert 
   (import-files-to-src-blocks folder mode extension "**")))



