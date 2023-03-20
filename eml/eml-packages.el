;; load all packages

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;if first install, get packages that can be installed
(if (not (file-directory-p (in-emacs-dir "elpa")))
    (package-refresh-contents))

(dolist (pkg '(use-package))
   (unless (package-installed-p pkg)
     (package-install pkg))
   (require pkg))

(require 'use-package-ensure)
;;install package if not installed
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)
;;if running a daemon we dont want to defer package load, for smoother experience 
(setq use-package-always-demand (daemonp))

;; better window switching
(use-package ace-window
  :bind ("M-o" . ace-window))

;; better completion in modeline buffers
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 (("C-x C-b" . helm-mini)))
  :config
  (helm-mode)
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini)
  ;; fix helm to bottom of screen
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*helm" (* not-newline) "*" eos)
                 (display-buffer-in-side-window)
                 (inhibit-same-window . t)
                 (window-height . 0.4))))

;; autocomplete at cursor
(use-package company
  :hook ((prog-mode) . global-company-mode)
  :config
  (define-key company-active-map
    (kbd "<tab>")
    #'company-complete-selection)
  (define-key company-active-map
    (kbd "<backtab>")
    #'company-complete-common-or-cycle)
  (setq company-idle-delay 0.3
	company-minimum-prefix-length 1))

(use-package which-key
    :config
    (which-key-mode))

(use-package yasnippet
  :hook ((LaTex-mode prog-mode) . yas-minor-mode))

(use-package flycheck
  :hook (LaTex-mode prog-mode))

;; for common lisp
(use-package sly
  :hook lisp-mode
  :config
  (setq inferior-lisp-program "sbcl")
  (add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly))))))

;; for LaTex
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-PDF-mode t)
  (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (require 'tex-mik))

;; for chicken-scheme
(use-package geiser-chicken
  :hook scheme-mode)

;; for python
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; better icons for file symbols in headerline
(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(add-hook 'lsp-mode-hook (lambda () (require all-the-icons)))

(require 'eml-git)
(require 'eml-lsp)

(use-package zenburn-theme)

(provide 'eml-packages)
