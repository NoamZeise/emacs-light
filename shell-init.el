;; config without a lot of heavy packages ie lsp
;; for use as a shell
;; can start with "emacs -q --load ~/.emacs.d/shell-init.el"

(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))
(load (in-emacs-dir "default-prefs.el"))

(require 'eml-essential-packages)
(require 'eml-theme)

(eml-theme-load)
(eshell)

;; load user's custom file
(setq custom-file (in-emacs-dir "custom.el"))
(if (file-exists-p custom-file)
  (load custom-file))
