;; setup all packages

(require 'eml-essential-packages)

(use-package yasnippet
  :hook ((LaTex-mode prog-mode) . yas-minor-mode))

(use-package flycheck
  :hook (LaTex-mode prog-mode))

;; for having projects
(use-package projectile
  :after lsp-mode)

;;show docs beside options in selection list for company 
(use-package company-box
  :hook (company-mode . company-box-mode))


;; for editing lisp s-expressions better
(use-package paredit
  :hook (emacs-lisp-mode sly-mode scheme-mode))

;; for common lisp
(use-package sly
  :hook lisp-mode
  :config
  (setq inferior-lisp-program "sbcl")
  (add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly)))))
  (add-hook 'sly-mrepl-mode-hook
	    (lambda ()
	      (disable-paredit-mode))))

;;scheme
(use-package geiser
  :hook ((scheme-mode) . geiser-mode)
  :config
  (setq geiser-mode-start-repl-p t))

;;for guile scheme
(use-package geiser-guile
  :after geiser)

;; for chicken-scheme
;;(use-package geiser-chicken
;;  :hook scheme-mode)


;; for LaTeX
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-PDF-mode t)
  (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (require 'tex-mik)
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  ;; ### Set Okular as the default PDF viewer.
  (eval-after-load "tex"
    '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular")))

;;
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; for OpenGL shader language
(use-package glsl-mode
  :mode (("\\.vert\\'" . glsl-mode)
	 ("\\.frag\\'" . glsl-mode)))

(use-package cmake-mode
  :mode (("\\CMakeLists.txt\\'" . cmake-mode)
	 ("\\.cmake\\'" . cmake-mode)))

(use-package rust-mode
  :mode "\\.rs\\'"
  :init
  (add-hook 'rust-mode-hook (lambda () (setq indent-tabs-mode nil))))

;; better icons for file symbols in headerline
(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(add-hook 'lsp-mode-hook (lambda () (require 'all-the-icons)))

(require 'eml-git)
(require 'eml-lsp)

(provide 'eml-packages)
