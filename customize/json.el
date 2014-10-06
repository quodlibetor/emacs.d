(add-to-list 'auto-mode-alist
             '("\\.template\\'" . json-mode))

;; json files are typically indented 2 spaces, not 4 like JS
(add-hook 'json-mode-hook
          (lambda ()
            (set (make-local-variable 'js-indent-level) 2)))

(require 'highlight-escape-sequences)
(add-to-list 'hes-simple-modes
             'json-mode)
