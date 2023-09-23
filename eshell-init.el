;; config without a lot of heavy packages ie lsp
;; for use as a shell
;; can start with "emacs -q --load ~/.emacs.d/eshell-init.el"

(setq eml-eshell-mode t)
(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))
(load (in-emacs-dir "init.el"))
