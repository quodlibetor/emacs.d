
(require 'yasnippet)

(add-hook 'html-mode-hook
          (lambda ()
            (zencoding-mode)
            ;; seriously zencoding, you're stealing my C-j?
            (define-key zencoding-mode-keymap (kbd "C-j") 'newline-and-indent)))
