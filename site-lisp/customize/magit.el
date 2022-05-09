;(setq magit-auto-revert-mode-lighter ""
;      magit-gitk-executable "/usr/bin/gitk")

; https://github.com/magit/ghub/issues/101
; this requires running:
; $ security add-internet-password -a 'quodlibetor^forge' -r 'htps' -s "api.github.com"
; and then opening the keychain app and inserting the github api key
(require 'auth-source)
(setq auth-sources '(macos-keychain-internet))

(use-package forge)

(defun bwm/git-sync ()
  "shells out to
    default-branch = !\"git symbolic-ref refs/remotes/origin/HEAD | sed 's,^refs/remotes/origin/,,'\"
    sync = !\"export branch=$(git default-branch) ; git fetch origin ${branch}:${branch}\"
"
  (interactive)
  (magit-with-toplevel
    (magit-run-git "sync")))

(use-package magit
  :config
  (require 'forge)
  (transient-insert-suffix 'magit-file-dispatch "L" '("o" "Open line in forge" git-link))
  (transient-insert-suffix 'magit-commit "F" '("b" "Commit-absorb" magit-commit-absorb))
  (transient-insert-suffix 'magit-fetch "o" '("s" "Sync default branch" bwm/git-sync))
  (add-hook 'magit-commit-mode-hook
            (lambda ()
              (setq buffer-file-coding-system 'utf-8)))
  )

(use-package git-link
  :straight t
  :config
  (setq-default git-link-open-in-browser t
                git-link-use-commit t))

