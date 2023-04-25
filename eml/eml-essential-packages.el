;; packages that aren't used for programming/latex

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; if first use, update package database files
(if (not (file-directory-p (in-emacs-dir "elpa")))
    (package-refresh-contents))

;; ensure use-package is installed first, which is used to lazily load the rest of the packages
(dolist (pkg '(use-package))
   (unless (package-installed-p pkg)
     (package-install pkg))
   (require pkg))

(require 'use-package-ensure)
;;install package if not installed
(setq use-package-always-ensure t)
;;see how long it takes each package to start with 'use-package-report' if this is enabled
(setq use-package-compute-statistics t)
;;if running a daemon we dont want to defer package load, for smoother experience 
(setq use-package-always-demand (daemonp))

;; better window switching
(use-package ace-window
  :bind ("M-o" . ace-window))

;; better completion in modeline buffers
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 (("C-x C-b" . helm-mini)))
  :config
  (helm-mode)
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini)
  ;; fix helm to bottom of screen
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*helm" (* not-newline) "*" eos)
                 (display-buffer-in-side-window)
                 (inhibit-same-window . t)
                (window-height . 0.4))))

;; autocomplete at cursor
(use-package company
  :hook ((prog-mode) . global-company-mode)
  :config
  (define-key company-active-map
    (kbd "<tab>")
    #'company-complete-selection)
  (define-key company-active-map
    (kbd "<backtab>")
    #'company-complete-common-or-cycle)
  (setq company-idle-delay 0.3
	company-minimum-prefix-length 1))

(use-package which-key
    :config
    (which-key-mode))

(use-package color-theme-sanityinc-tomorrow)

(provide 'eml-essential-packages)
