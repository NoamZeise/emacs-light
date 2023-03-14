
;; uncomment for first install if get key signature error or not connecting to server
;;(setq package-check-signature nil)

;; helper fn for specifying files in emacs dir 
(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))

(load (in-emacs-dir "gcmh/gcmh.el"))
(gcmh-mode 1)

;; store backups in emacs home folder
(setq backup-directory-alist '(("." . "~/.emacs.d/.backups/")))

;; remove some emacs menus
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
;; overwrite highlighted text
(delete-selection-mode 1)
;; thin edges
(fringe-mode '(2 . 1))
;; stop ding on doing something wrong
(setq visible-bell 1)
;; start in fullscreen
(set-frame-parameter nil 'fullscreen 'fullboth)

;; show numbers on side of programming files
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; fix shell open on same window as cursor
(add-to-list 'display-buffer-alist
             `(,(rx bos "*shell*")
               display-buffer-same-window
               (reusable-frames . visible)))

;; have buffers open on same window as cursor
(defun my-list-buffers (&optional arg)
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))

(define-key ctl-x-map "\C-b" 'my-list-buffers)

;;; c/c++ prefs
(defun c-c++-prefs-hook ()
;;  customize c/c++ indent  style
  (setq c-basic-offset 4)
  (c-set-offset 'arglist-intro '++)
  (c-set-offset 'innamespace '*))
(add-hook 'c-mode-hook 'c-c++-prefs-hook)
(add-hook 'c++-mode-hook 'c-c++-prefs-hook)

(add-to-list 'load-path (in-emacs-dir "eml"))
(require 'eml)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elpy geiser-chicken sly rust-mode helm-lsp lsp-ui lsp-mode git-gutter-fringe fringe-helper git-gutter which-key flycheck projectile yasnippet company helm ace-window use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
