(add-hook 'clojure-mode-hook
          (lambda ()
            (paredit-mode)
            (rainbow-delimiters-mode-enable)))
