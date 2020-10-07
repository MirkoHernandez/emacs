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

(defun my/add-melpa ()
  (interactive)
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                      (not (gnutls-available-p))))
	 (proto (if no-ssl "http" "https")))
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
  (package-initialize))


(defun async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

;;@============================= Launch Emacs

(defun launch-separate-emacs-in-terminal ()
  (suspend-emacs "fg ; emacs -nw"))

(defun launch-separate-emacs-under-x ()
  (call-process "sh" nil nil nil "-c" "emacs &"))

(defun launch-separate-emacs-under-x-debug ()
  (call-process "sh" nil nil nil "-c" "emacs --debug-init &"))

(defun restart-emacs ()
  (interactive)
  ;; We need the new emacs to be spawned after all kill-emacs-hooks
  ;; have been processed and there is nothing interesting left
  (let ((kill-emacs-hook (append kill-emacs-hook (list (if (display-graphic-p)
                                                           #'launch-separate-emacs-under-x
                                                         #'launch-separate-emacs-in-terminal)))))
    (save-buffers-kill-emacs)))

(defun restart-emacs-debug ()
  (interactive)
  ;; We need the new emacs to be spawned after all kill-emacs-hooks
  ;; have been processed and there is nothing interesting left
  (let ((kill-emacs-hook (append kill-emacs-hook (list (if (display-graphic-p)
                                                           #'launch-separate-emacs-under-x-debug
                                                         #'launch-separate-emacs-in-terminal)))))
    (save-buffers-kill-emacs)))



;;@============================= BUFFER
(defun create-scratch-buffer nil
  "create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)
    ))
