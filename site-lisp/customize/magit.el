;(setq magit-auto-revert-mode-lighter ""
;      magit-gitk-executable "/usr/bin/gitk")

(setq magit-last-seen-setup-instructions "1.4.0")
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(require 'magit)

(define-key magit-mode-map "\t" 'magit-section-cycle)
(define-key magit-mode-map [C-tab] 'magit-section-toggle)
