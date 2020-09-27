;;@============================= PYTHON
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(setq flymake-python-pyflakes-executable "flake8")

(setq python-shell-interpreter "python3.5")

(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      ;; (skip-chars-forward "    ")
       (skip-chars-forward "\t ")
      ;; (skip-chars-forward "@")
      (current-column))))


(defun python-outline-level ()
  (or
   ;; Commented outline heading
   (and (string-match (rx
               (* space)
               (one-or-more (syntax comment-start))
               (one-or-more space)
               (group (one-or-more "\*"))
               (one-or-more space))
              (match-string 0))
    (- (match-end 0) (match-beginning 0)))

   ;; Python keyword heading, set by number of indentions
   ;; Add 8 (the highest standard outline level) to every Python keyword heading
   (+ 8 (- (match-end 0) (match-beginning 0)))))


(add-hook 'python-mode-hook (lambda ()
			      ;; (setq outline-regexp python-outline-regexp)
			      (setq outline-level 'py-outline-level)
			      (outline-minor-mode)
			      (setq outline-regexp "###")
			      (abbrev-mode t)
			      (hs-minor-mode t)))
(setq python-mode-hook nil)

