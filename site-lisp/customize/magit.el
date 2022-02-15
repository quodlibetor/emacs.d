;(setq magit-auto-revert-mode-lighter ""
;      magit-gitk-executable "/usr/bin/gitk")

(use-package forge)

(use-package magit
  :config
  (require 'forge)
  (transient-insert-suffix 'magit-file-dispatch "L" '("o" "Open line on github" git-link))
  (transient-insert-suffix 'magit-commit "F" '("b" "Commit-absorb" magit-commit-absorb))
  (add-hook 'magit-commit-mode-hook
            (lambda ()
              (setq buffer-file-coding-system 'utf-8)))
  )

(use-package git-link
  :straight t
  :config
  (setq-default git-link-open-in-browser t
                git-link-use-commit t))

