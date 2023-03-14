;;mostly ripped from doom emacs

;;reset by gcmh later
(setq gc-cons-threshold most-positive-fixnum)

(unless (or (daemonp) noninteractive)
  ;; Premature redisplays can substantially affect startup times and produce
  ;; ugly flashes of unstyled Emacs.
  (setq-default inhibit-redisplay t
                inhibit-message t)
  (add-hook 'window-setup-hook
            (lambda ()
              (setq-default inhibit-redisplay nil
                            inhibit-message nil)
              (redisplay))))
  
