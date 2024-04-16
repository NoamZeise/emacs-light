;;;; eml-nano --- nano theme setup

;; nano emacs for modeline in header
(add-to-list 'load-path (in-emacs-dir "eml/nano-emacs/"))
;; for nano fonts
(require 'nano-faces)
;; font settings
(defvar eml-font "IBM Plex Mono")
(defvar eml-font-size 11)
(defun eml-set-font ()
  (setq nano-font-family-monospaced eml-font)
  (setq nano-font-size eml-font-size)
  (set-face-attribute 'default nil
		      :font nano-font-family-monospaced
		      :height (* nano-font-size 10)))
(eml-set-font)
(nano-faces)

(require 'eml-modeline)


;; Button styling

(add-hook 'custom-mode-hook
	  '(lambda ()
	     (set-face-attribute 'custom-button nil :box nil)
	     (set-face-attribute 'custom-button-mouse nil :box nil)
	     (set-face-attribute 'custom-button-pressed nil :box nil)
	     (set-face-attribute 'custom-button-pressed-unraised nil :box nil)))


;; Theme refresh

(defun eml-refresh-theme ()
  "Refresh theme after loading new one to fix modeline and other parts."
  (interactive)
  (eml-set-font)
  (eml-refresh-modeline-theme)
  (set-face-attribute 'vertical-border nil :foreground (face-background 'default))
  (set-face-attribute 'fringe nil :background (face-background 'mode-line-inactive))
  (if (featurep 'helm)
      (set-face-attribute 'helm-source-header nil :box nil))
  (add-hook 'helm-mode-hook
	    '(lambda () (set-face-attribute 'helm-source-header nil :box nil))))


;; Theme loading on init and frame creation

(defvar eml-theme-loader-fn
  '(lambda ()
     (require 'color-theme-sanityinc-tomorrow)
     (load-theme 'sanityinc-tomorrow-eighties t))
  "Called after init, and after frame creation.")

(defun eml-theme-load-at-init ()
  "Hooks to change theme."
  (funcall eml-theme-loader-fn)
  (eml-refresh-modeline-theme))

(defun eml-theme-load-with-frame (frame)
  "Hooks to change theme with FRAME."
  (select-frame frame)
  (funcall eml-theme-loader-fn)
  (eml-refresh-modeline-theme))

;; Themes will be set properly for daemon too, not just at init
(add-hook 'after-init-hook
	  'eml-theme-load-at-init)
(add-hook 'after-make-frame-functions
	  'eml-theme-load-with-frame)


;; Org Mode Styling

(setq org-hide-emphasis-markers t)


(provide 'eml-theme)
