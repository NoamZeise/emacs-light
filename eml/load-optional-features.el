;;; setup for the features that are toggleable by a boolean

;;; treemacs config
(when eml-use-treemacs
  (setq treemacs-width 20)
  (setq treemacs-text-scale -1.2)
  (treemacs-resize-icons 22)
  (require 'treemacs-all-the-icons)
  (treemacs-load-theme "all-the-icons")
  (add-hook 'emacs-startup-hook 'treemacs)) ; for starting up treemacs automatically

;;; centaur tabs
(when eml-use-centaur-tabs
  (setq centaur-tabs-enable-key-bindings t) ; require before load
  (require 'centaur-tabs)
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-icons t)
  (centaur-tabs-headline-match))
