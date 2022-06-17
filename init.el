(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;uncomment for first install if get key signature error
;(setq package-check-signature nil)

;; add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;load packages
(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
				  projectile hydra flycheck company
				  avy which-key helm-xref dap-mode magit treemacs treemacs-all-the-icons treemacs-projectile treemacs-magit treemacs-tab-bar git-gutter))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))


;; helm setup
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;;; lsp setup
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

 ;; remove menus
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; all the icons
(add-to-list 'load-path "~/.emacs.d/all-the-icons.el/")
(require 'all-the-icons)

;;treemacs  config
(setq treemacs-width 20)
(setq treemacs-text-scale -1.2)
(treemacs-resize-icons 22)
(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")

;; nano theme setup
(add-to-list 'load-path "~/.emacs.d/nano-emacs")
(add-to-list 'load-path ".")

(require 'nano-layout)
(require 'nano-theme-dark)
(require 'nano-faces) (nano-faces)
(require 'nano-theme) (nano-theme)
(require 'nano-defaults)
(require 'nano-session)
(provide 'nano)

;;set font size
(set-face-attribute 'default nil :height 130)

;;editor
(global-git-gutter-mode +1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'emacs-startup-hook 'treemacs)

(if(eq system-type 'gnu/linux)
    (setq explicit-shell-file-name "/bin/bash")
)
;;fix helm at bottom
(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

;;fix shell open on side

(add-to-list 'display-buffer-alist
             `(,(rx bos "*shell*")
               display-buffer-same-window
               (reusable-frames . visible)))


