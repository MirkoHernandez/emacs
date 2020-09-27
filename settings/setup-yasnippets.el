;;@============================= YASNIPEPTS
(require 'yasnippet)

;; This table is used by some of the snippets.
(setq snippets-values-table
      #s(hash-table size 20 test equal
		    data (
			  ""  "")))
(add-to-list 'yas-snippet-dirs
	     (concat emacs-root "emacs/snippets"))
(yas-global-mode 1)
