;;; Code:
(require 'flycheck)
(add-hook 'ruby-mode-hook
          (lambda ()
            (flycheck-select-checker 'ruby-rubocop)))
