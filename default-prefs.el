
;;(require 'benchmark-init)
;;(add-hook 'after-init-hook 'benchmark-init/deactivate)
;;(add-hook 'after-init-hook 'benchmark-init/show-durations-tree)


;; uncomment for first install
;;(setq package-check-signature nil) 
;; helper fn for specifying files in emacs dir 
(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))

;;load gchm - better garbage collection 
(load (in-emacs-dir "gcmh/gcmh.el"))
(gcmh-mode 1)

;; store backups in emacs home folder instead of same directory as files
(setq backup-directory-alist '(("." . "~/.emacs.d/.backups/")))

;; remove some emacs menus
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
;; overwrite highlighted text
(delete-selection-mode 1)
;; thin edges
(fringe-mode '(2 . 0))
;; stop ding on doing something wrong
(setq visible-bell 1)

(setq initial-major-mode 'text-mode)

;; show numbers on side of all files
(add-hook 'prog-mode-hook
	  'display-line-numbers-mode)
(add-hook 'text-mode-hook
	  'display-line-numbers-mode)

;; fix shell open on same window as cursor
(add-to-list 'display-buffer-alist
             `(,(rx bos "*shell*")
               display-buffer-same-window
               (reusable-frames . visible)))

;; have list buffers open on same window as cursor
(defun my-list-buffers (&optional arg)
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))

(define-key ctl-x-map "\C-b" 'my-list-buffers)

;;; c/c++ prefs
(defun c-c++-prefs-hook ()
;;  customize c/c++ indent style
  (setq c-basic-offset 4)
  (c-set-offset 'arglist-intro '++)
  (c-set-offset 'innamespace '*))
(add-hook 'c-mode-hook 'c-c++-prefs-hook)
(add-hook 'c++-mode-hook 'c-c++-prefs-hook)

;;loads packages + theme
(add-to-list 'load-path (in-emacs-dir "eml"))
