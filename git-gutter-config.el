

;;from https://github.com/doomemacs/doomemacs/blob/develop/modules/ui/vc-gutter/config.el
(require 'git-gutter-fringe)
;;thin fringe bitmaps
(define-fringe-bitmap 'git-gutter-fr:added [224]
  nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [224]
  nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240]
  nil nil 'bottom)


(require 'nano-theme-dark)
;;set colours
(set-face-foreground 'git-gutter-fr:modified nano-color-yellow)
(set-face-foreground 'git-gutter-fr:added    nano-color-green)
(set-face-foreground 'git-gutter-fr:deleted  nano-color-red)

(global-git-gutter-mode +1)
