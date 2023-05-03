;;; sets callbacks for loading theme on frame creation
;;; you can set eml-theme-loader-fn to override the theme
;;. see example of this in eml-theme

(require 'nano-base-colors) ;; loaded in eml-theme

(defun eml-nano-zenburn-term-theme ()
  (setq frame-background-mode     'dark)
  (setq nano-color-foreground "#DCDCCC") ;; Snow Storm 3  / nord  6
  (setq nano-color-background "#3F3F3F") ;; Polar Night 0 / nord  0
                            
  (setq nano-color-highlight  "#3B4252") ;; Polar Night 1 / nord  1
  (setq nano-color-critical   "#EBCB8B") ;; Aurora        / nord 11
                ;; language keywords
  (setq nano-color-salient    "#81A1C1") ;; Frost         / nord  9
  
  (setq nano-color-strong     "#ECEFF4") ;; Snow Storm 3  / nord  6
                             ;; strings
  (setq nano-color-popout     "#D08770") ;; Aurora        / nord 12
                             ;; headerline / modeline
  (setq nano-color-subtle     "#303030") ;; Polar Night 2 / nord  2
                             ;; comments and left of headerline
  (setq nano-color-faded      "#656555") ;;
  (set-face-attribute 'mode-line nil :foreground "#4e4e4e")
  (set-face-attribute 'mode-line-inactive nil :foreground "#4e4e4e")
  ;; to allow for toggling of the themes.
  (setq nano-theme-var "zenburn"))


(defun eml-theme-loader-default-nano-zenburn-term ()
  (if (window-system)
      (if (not (string= nano-theme-var "dark")) (nano-theme-set-dark))
    (if (not (string= nano-theme-var "dark-term")) (eml-nano-zenburn-term-theme)))
  (nano-refresh-theme))

(defvar eml-theme-loader-fn 'eml-theme-loader-default-nano-zenburn-term)


(defun eml-theme-load ()
  "Hooks to change theme."
  (funcall eml-theme-loader-fn)
  (eml-refresh-modeline-theme))

(defun eml-theme-load-w-frame (frame)
  "Hooks to change theme with FRAME."	
  (select-frame frame)
  (funcall eml-theme-loader-fn)
  (eml-refresh-modeline-theme))

;;this means that themes will be set properly for daemon too
(add-hook 'after-init-hook
	  'eml-theme-load)
(add-hook 'after-make-frame-functions
	  'eml-theme-load-w-frame)

(provide 'eml-theme-loader)
