;; packages that use language servers

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
  (add-hook 'lsp-mode-hook 'lsp-completion-mode)
  ;; stop clangd automatically including headers
  (setq lsp-clients-clangd-args '("--header-insertion=never")))

(use-package lsp-ui :commands lsp-ui-mode)

(use-package helm-lsp :commands helm-lsp-workspace-symbol)

(use-package lsp-java
  :after lsp-mode
  :if (executable-find "mvn")
  :init
  (use-package request :defer t)
  :custom
  (require 'lsp-java)
  (lsp-java-server-install-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/server/"))
  (lsp-java-workspace-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/workspace/"))
  (add-hook 'lsp-mode-hook #'lsp-lens-mode)
  (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
  ;; disable java-lsp formatting
  (setq lsp-java-format-on-type-enabled nil))

(provide 'eml-lsp)
