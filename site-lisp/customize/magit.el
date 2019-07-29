;(setq magit-auto-revert-mode-lighter ""
;      magit-gitk-executable "/usr/bin/gitk")

(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)
;(require 'magit-gerrit)
(setq magit-last-seen-setup-instructions "2.2.0"
      magit-push-always-verify nil
      magit-visit-ref-create t
     ; magit-gerrit-ssh-creds "bwm@knewton.com"
      )

(add-hook 'magit-commit-mode-hook
          (lambda ()
            (setq buffer-file-coding-system 'utf-8)))


(define-key magit-mode-map "\t" 'magit-section-cycle)
(define-key magit-mode-map [C-tab] 'magit-section-toggle)
