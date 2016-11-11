;;; Code:
(require 'flycheck)
(add-hook 'ruby-mode-hook
          (lambda ()
            (flycheck-select-checker 'ruby-rubocop)
            (setq-local flycheck-disabled-checkers '(chef-foodcritic))))
