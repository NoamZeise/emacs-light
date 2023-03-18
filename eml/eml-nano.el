;;;; eml-nano --- nano theme setup

(setq nano-font-family-monospaced "Roboto Mono")
(setq nano-font-size 11)
(add-to-list 'load-path (in-emacs-dir "eml/nano-emacs/"))
(require 'nano-base-colors)
(require 'nano-faces) (nano-faces)
(require 'nano-theme)  (nano-theme)
(require 'nano-theme-light)
(require 'nano-theme-dark)

;; nano dark theme for terminal 
(defun eml-nano-theme-set-dark-term ()
  (setq frame-background-mode     'dark)
  (setq nano-color-foreground "#FFFFFF") ;; Snow Storm 3  / nord  6
  (setq nano-color-background "#000000") ;; Polar Night 0 / nord  0
  (setq nano-color-highlight  "#3B4252") ;; Polar Night 1 / nord  1
  (setq nano-color-critical   "#EBCB8B") ;; Aurora        / nord 11
  (setq nano-color-salient    "#81A1C1") ;; Frost         / nord  9
  (setq nano-color-strong     "#ECEFF4") ;; Snow Storm 3  / nord  6
  (setq nano-color-popout     "#D08770") ;; Aurora        / nord 12
  (setq nano-color-subtle     "#5f8787") ;; Polar Night 2 / nord  2
  (setq nano-color-faded      "#5f8787") ;;
  ;; to allow for toggling of the themes.
  (setq nano-theme-var "dark-term"))

(defun eml-theme-load ()
  "Hooks to change theme."
  (if (window-system)
      (if (not (string= nano-theme-var "dark")) (nano-theme-set-dark))
    (if (not (string= nano-theme-var "dark-term")) (eml-nano-theme-set-dark-term)))
  (nano-refresh-theme))

(defun eml-theme-load-w-frame (frame)
  "Hooks to change theme with FRAME."
  (select-frame frame)
  (if (window-system frame)
      (if (not (string= nano-theme-var "dark")) (nano-theme-set-dark))
    (if (not (string= nano-theme-var "dark-term")) (eml-nano-theme-set-dark-term)))
  (nano-refresh-theme))


(add-hook 'after-init-hook
	  'eml-theme-load)
(add-hook 'after-make-frame-functions
	  'eml-theme-load-w-frame)

(require 'nano-modeline)

;;override nano-modeline function used for header to replace filename
;;with the string generated by lsp-headerline--build-string
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

;;override the font face for headerline, changed backgroud face to subtle
;;this is to ensure the icon background matches the modeline header colour 
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

(provide 'eml-nano)
