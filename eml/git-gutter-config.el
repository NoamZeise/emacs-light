

;;from https://github.com/doomemacs/doomemacs/blob/develop/modules/ui/vc-gutter/config.el
(require 'git-gutter-fringe)
;;thin fringe bitmaps
(define-fringe-bitmap 'git-gutter-fr:added [224]
  nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [224]
  nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240]
  nil nil 'bottom)

(setq git-green      "#A3BE8C")
(setq git-yellow     "#EBCB8B")
(setq git-red        "#BF616A")

;;set colours
(set-face-foreground 'git-gutter-fr:modified git-yellow)
(set-face-foreground 'git-gutter-fr:added    git-green)
(set-face-foreground 'git-gutter-fr:deleted  git-red)

(global-git-gutter-mode +1)
