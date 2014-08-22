(add-hook 'zencoding-mode-hook
          (lambda ()
            (define-key zencoding-mode-keymap (kbd "C-j") 'electric-newline-and-maybe-indent)))

(add-hook 'web-mode-hook
          (lambda ()
            (zencoding-mode)))
