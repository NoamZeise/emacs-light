(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; uncomment for first install if get key signature error
(setq package-check-signature nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages '(
				  lsp-mode
				  yasnippet
				  lsp-treemacs lsp-ui
				  projectile
				  hydra
				  flycheck
				  company
				  centaur-tabs
				  avy
				  which-key
				  helm-lsp helm-xref
				  dap-mode
				  magit
				  treemacs treemacs-all-the-icons treemacs-projectile treemacs-magit treemacs-tab-bar
				  git-gutter
				  rust-mode
				  sly
				  lsp-java
				  )
      )

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(global-company-mode)

;; helm setup
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;; common lisp setup
(setq inferior-lisp-program "sbcl")
;; open dly automatically on lisp file
(add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly)))))

;; java config
(require 'lsp-java)
;;(setq lsp-java-vmargs (list
;;                       "-noverify"
;;                       "--enable-preview"))
;;(add-hook 'java-mode-hook #'lsp)
(require 'dap-java)
(dap-auto-configure-mode)
(require 'lsp-java-boot)
;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;; lsp setup
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'rust-mode-hook 'lsp)
(add-hook 'java-mode-hook 'lsp)

;; rust setup 
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; remove emacs menus
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; all the icons
(add-to-list 'load-path "~/.emacs.d/all-the-icons.el/")
(require 'all-the-icons)

;; treemacs config
(setq treemacs-width 20)
(setq treemacs-text-scale -1.2)
(treemacs-resize-icons 22)
(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")
;;(add-hook 'emacs-startup-hook 'treemacs)

;; centaur tabs
(setq centaur-tabs-enable-key-bindings t) ;;require before load
(require 'centaur-tabs)
;;(centaur-tabs-mode t)
(setq centaur-tabs-set-icons t)
(centaur-tabs-headline-match)

;; nano theme setup
(add-to-list 'load-path "~/.emacs.d/nano-emacs")
(require 'nano-theme-dark)
(require 'nano-faces) (nano-faces)
(require 'nano-theme) (nano-theme)

;; set font size
(set-face-attribute 'default nil :height 130)

;; show git changed/added/removed lines at side
;;(global-git-gutter-mode +1)

;; show numbers on side of file
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; remove menus
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; fix helm at bottom
(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

;; fix shell open on side
(add-to-list 'display-buffer-alist
             `(,(rx bos "*shell*")
               display-buffer-same-window
               (reusable-frames . visible)))

;; have buffers open on current window
(defun my-list-buffers (&optional arg)
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))

(define-key ctl-x-map "\C-b" 'my-list-buffers)

;; overwrite highlighted text
(delete-selection-mode 1)

;; thin bezels
(fringe-mode '(1 . 1))

;; CMAKELISTS as programming mode
(add-to-list 'auto-mode-alist '("\\CMakeLists.txt\\'" . prog-mode))

;; start in fullscreen
(toggle-frame-fullscreen)

;; stop ding
(setq visible-bell 1)

;; c++ indent 4 spaces 
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
