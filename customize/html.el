
(require 'django-html-mode "packages/django-mode/django-html-mode")
(require 'django-mode "packages/django-mode/django-mode")
(require 'yasnippet)
(yas/load-directory "~/.emacs.d/packages/django-mode/snippets")

(add-hook 'html-mode-hook
          (lambda ()
            (zencoding-mode)
            ;; seriously zencoding, you're stealing my C-j?
            (define-key zencoding-mode-keymap (kbd "C-j") 'newline-and-indent)))
