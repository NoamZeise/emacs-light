;;default config, loads all packages, themes, etc

(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))

(load (in-emacs-dir "default-prefs.el"))
(setq eml-open-fullscreen t)
(require 'eml)
(eml-theme-load)

;; load user's custom file
(setq custom-file (in-emacs-dir "custom.el"))
(if (file-exists-p custom-file)
  (load custom-file))

