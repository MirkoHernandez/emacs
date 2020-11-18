;;@============================= ENGINE
(require 'engine-mode)
(engine-mode t)
(setq engine/browser-function 'eww-browse-url)

;; Wikipedia
(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w"
  :docstring "Search Wikipedia!")
;; 
(defengine project-gutenberg
  "http://www.gutenberg.org/ebooks/search/?query=%s"
  :keybinding "g"
  :docstring "Search Project Gutenberg"
  )

(defengine rfc
  "http://pretty-rfc.herokuapp.com/search?q=%s"
:keybinding "r"
  :docstring "RFC")

(defengine stack-overflow
  "https://stackoverflow.com/search?q=%s"
  :keybinding "s"
  :docstring "Search Stack-Overflow:")

(defengine mdn
  "https://developer.mozilla.org/en-US/search?q=%s"
  :keybinding "c"
  :docstring "Search mdn:")


;;@============================= EWW
(setq browse-url-browser-function 'eww-browse-url)
(setq shr-inhibit-images t)

;;@============================= SHRFACE

(with-eval-after-load 'shr ; lazy load is very important, it can save you a lot of boot up time
  (require 'shrface)
  (shrface-basic) ; enable shrfaces, must be called before loading eww/dash-docs/nov.el
  (shrface-trial) ; enable shrface experimental face(s), must be called before loading eww/dash-docs/nov.el
  (setq shrface-href-versatile t) ; enable versatile URL faces support
                                  ; (http/https/ftp/file/mailto/other), if
                                  ; `shrface-href-versatile' is nil, default
                                  ; face `shrface-href-face' would be used.
  (setq shrface-toggle-bullets nil) ; Set t if you do not like headline bullets
)
;; eww support
(with-eval-after-load 'eww
  (add-hook 'eww-after-render-hook 'shrface-mode))
