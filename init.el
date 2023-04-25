;;default config, loads all packages, themes, etc

(defun in-emacs-dir (path)
  (expand-file-name path user-emacs-directory))
(load (in-emacs-dir "default-prefs.el"))
;; start fullscreen
(add-hook 'focus-in-hook
	  (lambda () (set-frame-parameter nil 'fullscreen 'fullboth)))
(require 'eml)

;; load user's custom file
(setq custom-file (in-emacs-dir "custom.el"))
(if (file-exists-p custom-file)
  (load custom-file))

