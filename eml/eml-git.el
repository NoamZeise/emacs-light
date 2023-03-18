;; git related packages

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package git-gutter
  :config
  (global-git-gutter-mode +1))
(use-package fringe-helper)
(use-package git-gutter-fringe
  :config
  ;;from https://github.com/doomemacs/doomemacs/blob/develop/modules/ui/vc-gutter/config.el
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
  (set-face-foreground 'git-gutter-fr:deleted  git-red))


(provide 'eml-git)
