(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;if first install, get packages that can be installed
(if (not (file-directory-p (in-emacs-dir "elpa")))
    (package-refresh-contents))

(dolist (pkg '(use-package))
   (unless (package-installed-p pkg)
     (package-install pkg))
   (require pkg))

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(require 'use-package-ensure)
;;install package if not installed
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t) 



;; better window switching
(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 (("C-x C-b" . helm-mini)))
  :config
  (helm-mode)
  ;; (define-key global-map [remap find-file] #'helm-find-files)
  ;; (define-key global-map [remap execute-extended-command] #'helm-M-x)
  ;; (define-key global-map [remap switch-to-buffer] #'helm-mini)
  ;; fix helm to bottom of screen
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*helm" (* not-newline) "*" eos)
                 (display-buffer-in-side-window)
                 (inhibit-same-window . t)
                 (window-height . 0.4))))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map
    (kbd "<tab>")
    #'company-complete-selection)
  (define-key company-active-map
    (kbd "<backtab>")
    #'company-complete-common-or-cycle)
  (setq company-idle-delay 0.0
	company-minimum-prefix-length 1
	lsp-idle-delay 0.1))

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package projectile
  :hook lsp-mode)

(use-package flycheck)

(use-package which-key
    :config
    (which-key-mode))

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

(require 'eml-lsp)

;;; load all the icons
(add-to-list 'load-path (in-emacs-dir "all-the-icons.el/"))
(require 'all-the-icons)

(provide 'eml-packages)
