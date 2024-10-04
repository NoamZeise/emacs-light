;; packages that use the language server protocol

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode . lsp)
	 (c++-mode . lsp)
	 (rust-mode . lsp)
	 (java-mode . lsp)
         (python-mode . lsp)
	 (haskell-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  ;; disable headerline, using nano modeline with the same content
  (add-hook 'lsp-configure-hook (lambda () (lsp-headerline-breadcrumb-mode -1)))
  (setq lsp-headerline-breadcrumb-enable nil)
  (add-hook 'lsp-mode-hook 'lsp-completion-mode)
  ;; stop clangd automatically including headers
  (setq lsp-clients-clangd-args '("--header-insertion=never")))

(use-package lsp-ui :commands lsp-ui-mode
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map (kbd "C-c l d") #'lsp-ui-doc-toggle)
  (setq lsp-ui-doc-position 'at-point))

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

(use-package lsp-haskell
  :after lsp-mode
  :custom  
  (add-hook 'haskell-literate-mode-hook #'lsp))

(provide 'eml-lsp)
