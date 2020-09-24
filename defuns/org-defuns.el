;;@============================= ORG
(defun my/org-tree-open-in-right-frame ()
  (interactive)
  (split-window-right)
  (org-tree-to-indirect-buffer)
  (windmove-right))
