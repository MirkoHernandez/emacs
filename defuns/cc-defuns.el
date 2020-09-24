;;@============================= EDITING
(defun my/autoindent-c ()
  ""
  (interactive)
  (when (executable-find "indent")
    (shell-command (concat "indent -kr -cli0 -cbi0 -ss -i8 -ip8 -ppi 2 --line-length185 "
			   (buffer-file-name) ))))
