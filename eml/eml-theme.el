;;;; eml-nano --- nano theme setup

(setq nano-font-family-monospaced "Roboto Mono")
(setq nano-font-size 11)
(add-to-list 'load-path (in-emacs-dir "eml/nano-emacs/"))
(require 'nano-base-colors) 
(require 'nano-faces) (nano-faces)
;;(require 'nano-theme)  (nano-theme)
;;(require 'nano-theme-light)
;;(require 'nano-theme-dark)
;;(nano-theme-set-dark) (nano-refresh-theme)

(require 'eml-modeline)
(require 'eml-theme-loader)

(defun eml-refresh-theme ()
  "Refresh theme after loading new one to fix modeline and other parts."
  (interactive)
  (eml-refresh-modeline-theme)
  (set-face-attribute 'vertical-border nil :foreground (face-background 'default))
  (set-face-attribute 'fringe nil :background (face-background 'mode-line-inactive))
  (if (featurep 'helm)
      (set-face-attribute 'helm-source-header nil :box nil))
  (add-hook 'helm-mode-hook
	    '(lambda () (set-face-attribute 'helm-source-header nil :box nil))))

;;load theme
(setq eml-theme-loader-fn
      '(lambda ()
	 (load-theme 'sanityinc-tomorrow-eighties t)
	 (eml-refresh-modeline-theme)))

(add-hook 'custom-mode-hook
	  '(lambda ()
	     (set-face-attribute 'custom-button nil :box nil)
	     (set-face-attribute 'custom-button-mouse nil :box nil)
	     (set-face-attribute 'custom-button-pressed nil :box nil)
	     (set-face-attribute 'custom-button-pressed-unraised nil :box nil)))

(provide 'eml-theme)
