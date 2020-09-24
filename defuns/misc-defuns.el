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
