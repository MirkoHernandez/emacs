;;; hydras.el --- Hydras                             -*- lexical-binding: t; -*-

;;@============================= Rectangle
(defvar rectangle-mark-mode)
(defun hydra-ex-point-mark ()
  "Exchange point and mark."
  (interactive)
  (if rectangle-mark-mode
      (rectangle-exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1) :color pink
				     :columns 4
				     :post (deactivate-mark))
  "Rectangle"
  ("h" rectangle-backward-char nil)
  ("l" rectangle-forward-char nil)
  ("k" rectangle-previous-line nil)
  ("j" rectangle-next-line nil)
  ("e" hydra-ex-point-mark "hydra-ex-point-mark")
  ("n" copy-rectangle-as-kill "copy-rectangle-as-kill")
  ("d" delete-rectangle "delete-rectangle")
  ("r" (if (region-active-p)
	   (deactivate-mark)
	 (rectangle-mark-mode 1)) "Deactivate Region")
  ("y" yank-rectangle "yank-rectangle")
  ("u" undo "undo")
  ("s" string-rectangle "string-rectangle")
  ("x" kill-rectangle "kill-rectangle")
  ("q" nil "quit" ))




;;@============================= Bookmarks
(defhydra hydra-bookmarks (:color blue :hint nil)
  "
^Set^                                      ^Jump^                         ^Insert^
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
_m_ Set Bookmark                        _j_ Jump to Register         _i_ Insert Register
_w_ Window Configuration to Register    _b_ Jump to Bookmark
_x_ Copy to Register
_r_ Point to Register
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
  ("b" counsel-bookmark)
  ("i" insert-register)
  ("j" jump-to-register)
  ("r" point-to-register)
  ("m" bookmark-set)
  ("w" window-configuration-to-register)
  ("x" copy-to-register))
;;@============================= Replace
(defhydra hydra-replace (:color orange)
  "Replace"
  ("r" query-replace-in-region "Replace in region without moving point")
  ("."  (lambda () (interactive)
	  (setq current-prefix-arg '(4)) ; C-u
	  (call-interactively 'smartscan-symbol-replace)) "Replace Symbol in defun")
  ("," smartscan-symbol-replace "Replace symbol in buffer")
  ("b" query-replace-regexp "Replace regexp in buffer or region")
  ("q" nil "cancel"))

;;@============================= Navigation
(defhydra hydra-navigation (:post (progn (message "NAVIGATION MODE" ))
				  :foreign-keys warn 
				  :timeout 1.2)
  "
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 _C-l_ recenter      | _h_ left word          | _p_ beginning  of defun |
 _r_ recenter cursor | _l_ right word         | _n_ end of defun        |
 _a_ go to word      | _K_ previous line      | _S-k_ scroll up         |
 _s_ go to subword   | _J_ next line          | _S-j_ scroll down       |
 _d_ down list       | _k_ previous paragraph | _g_ beginning of buffer |
 _u_ up list         | _j_ next paragraph     | _G_ end of buffer       |
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
  ("a" avy-goto-word-1 nil )
  ("s" avy-goto-word-or-subword-1 nil)

  
  ("C-l" recenter-top-bottom nil)
  ("r" recenter-positions nil)

  ("h" left-word nil)
  ("l" right-word nil)

  ("J" next-line nil)
  ("K" previous-line nil)
  ("k" backward-paragraph nil)
  ("j" forward-paragraph nil)
  ("m" mark-sexp nil)
  ("p" beginning-of-defun  nil)
  ("n" end-of-defun nil)

  ("u" backward-up-list nil)
  ("d" down-list nil)

  ("g" beginning-of-buffer nil)
  ("G" end-of-buffer nil)

  ("S-k" scroll-up-command nil)
  ("S-j" scroll-down-command  nil)
  
  ;; ("C-h" hs-hide-level nil)
  ;; ("5" paredit-open-round nil)
  ("i" helm-imenu nil :exit t)
  ("q" nil "quit"))

;;@============================= Delete
(defhydra hydra-delete (:pre (set-cursor-color "#40e0d0")
			     :post (progn
				     (message
				      "Delete Mode" )))
  "Delete:"
  ("j" backward-kill-word-or-selection)
  ("k" kill-line)
  ("C-k" kill-line)
  ("l" crux-kill-whole-line)
  ("y" yank)
  ("d" kill-word)
  ("s" kill-sexp)
  ("u" kill-backward-up-list)
  ("p" sp-kill-hybrid-sexp)
  ("P" paredit-kill)
  ("q" nil "quit"))


;;@============================= Ibuffer

(defhydra hydra-ibuffer-main (:color pink :hint nil)
  "
 ^Navigation^ | ^Mark^        | ^Actions^        | ^View^
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
  ^ ^         | _m_: mark     | _D_: delete      | _g_: refresh
 _RET_: visit | _u_: unmark   | _S_: save        | _s_: sort
  ^ ^         | _*_: specific | _a_: all actions | _/_: filter
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
  ;; ("j" ibuffer-forward-line)
  ;; ("k" ibuffer-backward-line)
  ("RET" ibuffer-visit-buffer :color blue)

  ("m" ibuffer-mark-forward)
  ("u" ibuffer-unmark-forward)
  ("*" hydra-ibuffer-mark/body :color blue)

  ("D" ibuffer-do-delete)
  ("S" ibuffer-do-save)
  ("a" hydra-ibuffer-action/body :color blue)

  ("g" ibuffer-update)
  ("s" hydra-ibuffer-sort/body :color blue)
  ("/" hydra-ibuffer-filter/body :color blue)

  ("o" ibuffer-visit-buffer-other-window "other window" :color blue)
  ("q" quit-window "quit ibuffer" :color blue)
  ("." nil "toggle hydra" :color blue))

(defhydra hydra-ibuffer-mark (:color teal :columns 5
			      :after-exit (hydra-ibuffer-main/body))
  "Mark"
  ("*" ibuffer-unmark-all "unmark all")
  ("M" ibuffer-mark-by-mode "mode")
  ("m" ibuffer-mark-modified-buffers "modified")
  ("u" ibuffer-mark-unsaved-buffers "unsaved")
  ("s" ibuffer-mark-special-buffers "special")
  ("r" ibuffer-mark-read-only-buffers "read-only")
  ("/" ibuffer-mark-dired-buffers "dired")
  ("e" ibuffer-mark-dissociated-buffers "dissociated")
  ("h" ibuffer-mark-help-buffers "help")
  ("z" ibuffer-mark-compressed-file-buffers "compressed")
  ("SPC" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-action (:color teal :columns 4
				:after-exit
				(if (eq major-mode 'ibuffer-mode)
				    (hydra-ibuffer-main/body)))
  "Action"
  ("A" ibuffer-do-view "view")
  ("E" ibuffer-do-eval "eval")
  ("F" ibuffer-do-shell-command-file "shell-command-file")
  ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
  ("H" ibuffer-do-view-other-frame "view-other-frame")
  ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
  ("M" ibuffer-do-toggle-modified "toggle-modified")
  ("O" ibuffer-do-occur "occur")
  ("P" ibuffer-do-print "print")
  ("Q" ibuffer-do-query-replace "query-replace")
  ("R" ibuffer-do-rename-uniquely "rename-uniquely")
  ("T" ibuffer-do-toggle-read-only "toggle-read-only")
  ("U" ibuffer-do-replace-regexp "replace-regexp")
  ("V" ibuffer-do-revert "revert")
  ("W" ibuffer-do-view-and-eval "view-and-eval")
  ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
  ("b" nil "back"))

(defhydra hydra-ibuffer-sort (:color amaranth :columns 3)
  "Sort"
  ("i" ibuffer-invert-sorting "invert")
  ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
  ("v" ibuffer-do-sort-by-recency "recently used")
  ("s" ibuffer-do-sort-by-size "size")
  ("f" ibuffer-do-sort-by-filename/process "filename")
  ("m" ibuffer-do-sort-by-major-mode "mode")
  ("SPC" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-filter (:color amaranth :columns 4)
  "Filter"
  ("m" ibuffer-filter-by-used-mode "mode")
  ("M" ibuffer-filter-by-derived-mode "derived mode")
  ("n" ibuffer-filter-by-name "name")
  ("c" ibuffer-filter-by-content "content")
  ("e" ibuffer-filter-by-predicate "predicate")
  ("f" ibuffer-filter-by-filename "filename")
  (">" ibuffer-filter-by-size-gt "size")
  ("<" ibuffer-filter-by-size-lt "size")
  ("/" ibuffer-filter-disable "disable")
  ("SPC" hydra-ibuffer-main/body "back" :color blue))

(add-hook 'ibuffer-hook #'hydra-ibuffer-main/body)

;;@============================= Dired
(defhydra hydra-dired (:hint nil :color pink)
  "
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp
T - tag prefix
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff)         ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("P" peep-dired :exit t)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))



;;@============================= Align

(defhydra hydra-align (:foreign-keys warn )
  "
――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 _r_ regex          | _t_ org table    | _i_ insert row 
 _j_ move cell down | _k_ move cell up |                
――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
  ("r" align-regexp nil :exit t )
  ("t" org-table-align  nil :exit t)
  ("i" org-table-next-row  nil :exit t)
  ("k" org-table-move-cell-up nil)
  ("j" org-table-move-cell-down  nil )
  ("h" org-table-move-cell-left nil)
  ("l" org-table-move-cell-right nil)
    ("q" nil "quit"))


;;@============================= Perspective

(defhydra hydra-perspective ( )
  "
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 _<app>_ switch to last     | _n_ next     | _a_ add buffer    |
 _b_ switch buffer          | _p_ previous | _r_ remove buffer |
 _s_ switch/new perspective |              |                   |
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"
  ("<app>" persp-switch-last nil :exit t )
  ("s" persp-switch  nil :exit t)
  ("b" persp-switch-to-buffer*  nil :exit t)
  ("n" persp-next  nil )
  ("p" persp-prev nil)
  ("a" persp-add-buffer  nil )
  ("r" persp-remove-buffer nil)
  ("<right>"  my/persp-next-buffer nil)
  ("<left>"   my/persp-previous-buffer nil)
    ("q" nil "quit"))


