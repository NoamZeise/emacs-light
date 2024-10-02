;;; Setup all packages

;; basic emacs improvements
(require 'eml-essential-packages)

(use-package yasnippet
  :hook ((LaTeX-mode prog-mode) . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package flycheck
  :hook ((prog-mode elisp-mode) . global-flycheck-mode))

;; for projects
(use-package projectile
  :after lsp-mode)

;; show docs beside options in selection list for company
(use-package company-box
  :hook (company-mode . company-box-mode))

;; for editing lisp s-expressions better
(use-package paredit
 :hook ((emacs-lisp-mode
 	 sly-mode
 	 scheme-mode
 	 racket-mode)
	. enable-paredit-mode))

(defvar eml-default-common-lisp "sbcl"
  "Path to Lisp program for Emacs to use.")

;; Common Lisp repl and completion
(use-package sly
  :hook lisp-mode
  :config
  (setq inferior-lisp-program eml-default-common-lisp)
  (setq sly-contribs '(sly-scratch sly-mrepl sly-tramp sly-autodoc))
  (add-hook 'sly-mode-hook
            (lambda ()
              (unless (sly-connected-p)
		(save-excursion (sly)))))
  (add-hook 'sly-mrepl-mode-hook
	    (lambda ()
	      (disable-paredit-mode))))

;; scheme
(use-package geiser
  :hook ((scheme-mode) . geiser-mode)
  :config
  (setq geiser-mode-start-repl-p t))

;; guile scheme
(use-package geiser-guile
  :after geiser)

;; chicken scheme
;;(use-package geiser-chicken
;;  :hook scheme-mode)

;; racket scheme
(use-package geiser-racket
  :after geiser)

(defvar eml-default-pdf-program "Okular"
  "Default program to use for opening compiled tex files.")

;; LaTeX
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
  ;; Set Okular as the default PDF viewer.
  (eval-after-load "tex"
    '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection))
	     eml-default-pdf-program)))

;; Python
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; OpenGL Shader Language
(use-package glsl-mode
  :mode (("\\.vert\\'" . glsl-mode)
	 ("\\.vs\\'" . glsl-mode)
	 ("\\.frag\\'" . glsl-mode)
	 ("\\.fs\\'" . glsl-mode)))

(use-package cmake-mode
  :mode (("\\CMakeLists.txt\\'" . cmake-mode)
	 ("\\.cmake\\'" . cmake-mode)))

(use-package rust-mode
  :mode "\\.rs\\'"
  :init
  (add-hook 'rust-mode-hook (lambda () (setq indent-tabs-mode nil))))

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

;; better icons for file symbols in headerline
(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(add-hook 'lsp-mode-hook (lambda () (require 'all-the-icons)))

;; magit and gutter
(require 'eml-git)
;; lsp config for many languages
(require 'eml-lsp)

(provide 'eml-packages)
