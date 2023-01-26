;;; nano theme setup
(setq nano-font-family-monospaced "Roboto Mono")
(setq nano-font-size 11)
(add-to-list 'load-path (in-emacs-dir "eml/nano-emacs/"))
(require 'nano-base-colors)
(require 'nano-faces) (nano-faces)
(require 'nano-theme)  (nano-theme)
(require 'nano-theme-light)
(require 'nano-theme-dark) (nano-theme-set-dark) (nano-refresh-theme)
(require 'nano-modeline)

(defun nano-modeline-default-mode ()
  (let ((buffer-name (format-mode-line "%b"))
	(mode-name   (nano-mode-name))
	(branch      (vc-branch))
	(crumb (when (bound-and-true-p lsp-mode)
		 (when (functionp 'lsp-headerline--build-string)
		   (replace-regexp-in-string "^>  " ""
					     (concat
					      (lsp-headerline--build-string) "")))))
	(position (format-mode-line "%l:%c")))
    (nano-modeline-compose (nano-modeline-status)
			   (if crumb crumb buffer-name)
                           (concat "(" mode-name
                                   (if branch (concat ", "
						      (propertize branch 'face 'italic)))
                                   ")" )
			   position)))

(set-face-attribute 'header-line nil
                    :weight 'light
                    :foreground (face-foreground 'nano-face-default)
                    :background (face-background 'nano-face-subtle)
		    
                    :overline nil
                    :underline nil
                    :box nil
                    :box `(:line-width 1
                                       :color ,(face-background 'nano-face-default)
                                       :style nil)
                    :inherit nil)
