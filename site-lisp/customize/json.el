(require 'json-mode)
(add-to-list 'auto-mode-alist
             '("\\.template\\'" . json-mode))

(add-to-list 'auto-mode-alist
             '("\\.eslintrc\\'" . json-mode))

;; json files are typically indented 2 spaces, not 4 like JS
(add-hook 'json-mode-hook
          (lambda ()
            (set (make-local-variable 'js-indent-level) 2)))

(require 'highlight-escape-sequences)
(add-to-list 'hes-mode-alist
             `(json-mode . ,hes-js-escape-sequence-re)
             `(yaml-mode . ,hes-js-escape-sequence-re))
