;;; early-init.el -*- lexical-binding: t; -*-


(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

(setq package-enable-at-startup nil)
(setq frame-inhibit-implied-resize t)

