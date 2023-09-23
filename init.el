
;; pre-init options (pass to program with --eval)
;;         eml-eshell-mode : only some packages, open eshell at start

;;benchmark startup performance
;;(require 'benchmark-init)
;;(add-hook 'after-init-hook 'benchmark-init/deactivate)
;;(add-hook 'after-init-hook 'benchmark-init/show-durations-tree)

;; uncomment for first install
(setq package-check-signature nil)

;; helper fn for specifying files in emacs dir 
(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))

;;load gchm - better garbage collection 
(load (in-emacs-dir "gcmh/gcmh.el"))
(gcmh-mode 1)

(defun my/focus-new-client-frame ()
  (select-frame-set-input-focus (selected-frame)))
(if (daemonp) 
    (add-hook 'server-after-make-frame-hook #'my/focus-new-client-frame))

(setq read-process-output-max (* (* 1024 1024) 10)) ;; 10mb

;; store backups in emacs home folder instead of same directory as files
(setq backup-directory-alist '(("." . "~/.emacs.d/.backups/")))

;; remove some emacs menus
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(if (boundp 'tool-bar-mode)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      ;; thin edges
      (fringe-mode '(2 . 0))))
(menu-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
;; overwrite highlighted text
(delete-selection-mode 1)
;; stop ding on doing something wrong
(setq visible-bell 1)
;; show long lines on next line
(global-visual-line-mode t)

(setq initial-major-mode 'text-mode)

(setq eshell-scroll-to-bottom-on-input t)

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

(defvar eml-fullscreen nil
  "keep emacs in fullscreen")
(add-hook 'focus-in-hook
	  (lambda ()
	    (if eml-fullscreen
		(set-frame-parameter nil 'fullscreen 'fullboth))))

(add-to-list 'load-path (in-emacs-dir "eml"))

(defvar eml-eshell-mode nil "less packages, open eshell at start")
(if eml-eshell-mode
    ;; only load styling and some helpful packages
    (progn (require 'eml-essential-packages)
	   (require 'eml-theme)
	   (eml-theme-load)
	   (eshell))
  ;; load as normal
  (require 'eml))

;; load user's custom file
(setq custom-file (in-emacs-dir "custom.el"))
(if (file-exists-p custom-file)
  (load custom-file))
