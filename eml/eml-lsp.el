(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode . lsp)
	 (c++-mode . lsp)
	 (rust-mode . lsp)
	 (java-mode . lsp)
         (python-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  ;;disable headerline, we will be using nano modeline with the same content
  (add-hook 'lsp-configure-hook (lambda () (lsp-headerline-breadcrumb-mode -1)))
  (setq lsp-headerline-breadcrumb-enable nil)
  ;; stop clangd automatically including headers
  (setq lsp-clients-clangd-args '("--header-insertion=never")))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

(use-package rust-mode
  :mode "\\.rs\\'"
  :init
  (add-hook 'rust-mode-hook (lambda () (setq indent-tabs-mode nil))))

(use-package sly
  :mode "\\.lisp\\'"
  :config
  (setq inferior-lisp-program "sbcl")
  (add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly))))))

(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-PDF-mode t)
  (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (require 'tex-mik))

(use-package geiser-chicken
  :hook scheme-mode)

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

(use-package yasnippet
  :after lsp-mode
  :config
  (yas-global-mode))

(use-package projectile
  :after lsp-mode)

(use-package flycheck
  :hook LaTex-mode
  :after lsp-mode)

(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(add-hook 'lsp-mode-hook (lambda () (require all-the-icons)))

(provide 'eml-lsp)
