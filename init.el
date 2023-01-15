;; default settings, can change here or in custom.el, if you want these features enabled
(setq eml-use-treemacs nil)
(setq eml-use-centaur-tabs nil)

;; uncomment for first install if get key signature error or not connecting to server
;; (setq package-check-signature nil)

;; helper fn for specifying files in emacs dir 
(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))

;;load all exterrnal packages 
(load (in-emacs-dir "eml/load-external-packages.el"))

;;load custom.el config if exists
(setq custom-file (in-emacs-dir "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; store backups in emacs home folder
(setq backup-directory-alist '(("." . "~/.emacs.d/.backups/")))

;; completion suggestion everywhere
(global-company-mode)

;;; helm setup
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      ;;treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)

;; setup lsp
(load (in-emacs-dir "eml/lsp-lang-setup.el"))

;; remove some emacs menus
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; load all the icons
(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(require 'all-the-icons)

;;; setup for the features that can be toggled with a boolean
(load (in-emacs-dir "eml/load-optional-features.el"))

;;; nano theme setup
(add-to-list 'load-path (in-emacs-dir "nano-emacs/"))
(require 'nano-theme-dark)
(require 'nano-faces) (nano-faces)
(require 'nano-theme) (nano-theme)

;; set font size
(set-face-attribute 'default nil :height 105)

;;; theme for git gutter
(load (in-emacs-dir "git-gutter-config.el"))

;; show numbers on side of programming files
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; settings for how buffers open
(load (in-emacs-dir "eml/buffer-open-settings.el"))

(define-key ctl-x-map "\C-b" 'my-list-buffers)

;; overwrite highlighted text
(delete-selection-mode 1)

;; thin edges
(fringe-mode '(2 . 1))

;; start in fullscreen
(toggle-frame-fullscreen)

;; stop ding
(setq visible-bell 1)
