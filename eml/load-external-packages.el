;;; loads all  external packages  used by config

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
				  cmake-mode
				  ace-window))

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
