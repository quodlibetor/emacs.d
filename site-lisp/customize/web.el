(require 'web-mode)
(require 'zencoding-mode)

(add-hook 'zencoding-mode-hook
          (lambda ()
            (define-key zencoding-mode-keymap (kbd "C-j") 'electric-newline-and-maybe-indent)))

(add-hook 'web-mode-hook
          (lambda ()
            (zencoding-mode)))

(setq web-mode-enable-current-element-highlight t)

(add-to-list 'auto-mode-alist
             '(".php\\'" . web-mode))
(add-to-list 'auto-mode-alist
             '(".html.j2\\'" . web-mode))
(add-to-list 'auto-mode-alist
             '(".tsx?\\'" . web-mode))
