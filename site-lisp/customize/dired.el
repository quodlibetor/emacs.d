(load "dired-x")

(when (string= system-type "darwin")
  (setq insert-directory-program "gls" dired-use-ls-dired t))

(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "M-s M-s") 'dired-do-search)))
