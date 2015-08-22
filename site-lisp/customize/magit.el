;(setq magit-auto-revert-mode-lighter ""
;      magit-gitk-executable "/usr/bin/gitk")

(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)
(setq magit-last-seen-setup-instructions "2.2.0"
      magit-push-always-verify nil
      magit-visit-ref-create t)

(define-key magit-mode-map "\t" 'magit-section-cycle)
(define-key magit-mode-map [C-tab] 'magit-section-toggle)
