;; default settings, can change here or in custom.el, if you want these features enabled
(setq eml-use-treemacs nil)
(setq eml-use-centaur-tabs nil)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; uncomment for first install if get key signature error or not connecting to server
;; (setq package-check-signature nil)

;; helper fn for specifying files in emacs dir 
(defun in-emacs-dir (path)
  (concat user-emacs-directory path))

;; store backups in emacs home folder
(setq backup-directory-alist '(("." . (in-emacs-dir ".backups/"))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
;; list of packages to install
(setq package-selected-packages '(
				  lsp-mode
				  yasnippet
				  lsp-ui
				  projectile
				  hydra
				  flycheck
				  company
				  avy
				  which-key
				  helm-lsp helm-xref
				  dap-mode
				  git-commit
				  magit
				  git-gutter
				  fringe-helper
				  git-gutter-fringe
				  rust-mode
				  sly
				  lsp-java 
				  elpy 
				  cmake-mode))

;;add treemacs packages if enabled
(if eml-use-treemacs
    (set package-selected-packages
	 (append (eval '(
			 lsp-treemacs
			 treemacs
			 treemacs-all-the-icons
			 treemacs-projectile
			 treemacs-magit
			 treemacs-tab-bar)))))

(if eml-use-centaur-tabs
    (set package-selected-packages
	 (append (eval '(centaur-tabs)))))

;; install each package in above list
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; completion suggestion everywhere
(global-company-mode)

;;; helm setup
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;;; setup lsp settings for various langs
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'rust-mode-hook 'lsp)
(add-hook 'java-mode-hook 'lsp)

;;; common lisp setup
(setq inferior-lisp-program "sbcl")
;; open sly automatically on lisp file
(add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly)))))

;;; c++ setup
;; c++ indent 4 spaces 
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;;; rust setup 
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

;;; java setup
(require 'lsp-java)
(require 'dap-java)
(dap-auto-configure-mode)
(require 'lsp-java-boot)
;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
;; disable java-lsp formatting
(setq lsp-java-format-on-type-enabled nil)

;;;python setup
(elpy-enable)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      ;;treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;;; remove some emacs menus
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; all the icons
(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(require 'all-the-icons)

;;; treemacs config
(when eml-use-treemacs
  (setq treemacs-width 20)
  (setq treemacs-text-scale -1.2)
  (treemacs-resize-icons 22)
  (require 'treemacs-all-the-icons)
  (treemacs-load-theme "all-the-icons")
  (add-hook 'emacs-startup-hook 'treemacs)) ; for starting up treemacs automatically

;;; centaur tabs
(when eml-use-centaur-tabs
  (setq centaur-tabs-enable-key-bindings t) ; require before load
  (require 'centaur-tabs)
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-icons t)
  (centaur-tabs-headline-match))

;;; nano theme setup
(add-to-list 'load-path (in-emacs-dir "nano-emacs/"))
(require 'nano-theme-dark)
(require 'nano-faces) (nano-faces)
(require 'nano-theme) (nano-theme)

;; set font size
(set-face-attribute 'default nil :height 105)

(load (in-emacs-dir "git-gutter-config.el"))

;; show numbers on side of programming files
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; fix helm to bottom of frame
(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

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

;; overwrite highlighted text
(delete-selection-mode 1)

;; thin edges
(fringe-mode '(2 . 1))

;; start in fullscreen
(toggle-frame-fullscreen)

;; stop ding
(setq visible-bell 1)
