;;@============================= Perspective Config

;; Load Perspective
(require 'perspective)

;; Enable perspective mode
(persp-mode t)

(defmacro custom-persp (name &rest body)
  "Macro to create perspective and execute associated custom code."
  `(let ((initialize (not (gethash ,name (perspectives-hash))))
         (current-perspective (persp-curr)))
     (persp-switch ,name)
     (when initialize ,@body)
     (set-frame-parameter nil 'persp--last current-perspective)))


;;@============================= Perspective defuns
(defun my/persp-toggle-recent-buffer ()
   "Switch to previously open buffer in the current perspective.Repeated invocations toggle between the two most recently open buffers."
   (interactive)
   (let ((buffername (buffer-name (current-buffer)))
        (bufferlist (persp-current-buffer-names)))
  (switch-to-buffer (persp-other-buffer (current-buffer) t))))


(defun filter-perspective-buffers ()
   (cl-remove-if '(lambda (s)
		 (string-match "^*" s))
              (persp-current-buffer-names)))
  

(defun my/persp-next-buffer ()
  "Similar to `next-buffer' but  restricted to the current perspective buffers."
  (interactive)
  (let ((buffername (buffer-name (current-buffer)))
        (bufferlist (filter-perspective-buffers)))
    (switch-to-buffer (or (cadr (member buffername bufferlist))
			  (car bufferlist)))))

(defun my/persp-previous-buffer ()
  "Similar to `previous-buffer' but  restricted to the current perspective buffers."
  (interactive)
  (let ((buffername (buffer-name (current-buffer)))
        (bufferlist (reverse (filter-perspective-buffers))))
    (switch-to-buffer (or (cadr (member buffername bufferlist))
			  (car bufferlist)))))

(provide 'setup-perspective)
