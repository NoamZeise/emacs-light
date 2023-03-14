;; changes dark theme if in terminal, called from load-nano-theme

(require 'nano-base-colors)

(defun nano-theme-set-dark ()
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
  (setq nano-theme-var "dark")
  )


(provide 'eml-nano-dark-term)
