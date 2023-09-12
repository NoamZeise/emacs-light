;;default config, loads all packages, themes, etc, but will be in windowed mode

(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))
(load (in-emacs-dir "default-prefs.el"))
(require 'eml)

;; load user's custom file
(setq custom-file (in-emacs-dir "custom.el"))
(if (file-exists-p custom-file)
  (load custom-file))

