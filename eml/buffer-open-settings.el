;;;  various settings that change the behaviour of how buffers open with some commands

;; fix helm to bottom of frame
(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

;; fix shell open on same window as cursor
(add-to-list 'display-buffer-alist
             `(,(rx bos "*shell*")
               display-buffer-same-window
               (reusable-frames . visible)))

;; have buffers open on same window as cursor
(defun my-list-buffers (&optional arg)
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))
