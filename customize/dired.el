(load "dired-x")

(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "M-s M-s") 'dired-do-search)))
