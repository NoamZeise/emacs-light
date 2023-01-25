;;; setup lsp settings for various langs

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

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

;;; c setup
(defun c-indent-prefs-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'arglist-intro '++)
  (c-set-offset 'innamespace '*)
  )
(add-hook 'c-mode-hook 'c-indent-prefs-hook)
(add-hook 'c++-mode-hook 'c-indent-prefs-hook)

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
