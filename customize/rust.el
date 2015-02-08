(require 'rust-mode)

(define-key rust-mode-map (kbd "C-j") 'bwm:sane-newline)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
