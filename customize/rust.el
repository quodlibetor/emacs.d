(require 'rust-mode)

(define-key rust-mode-map (kbd "C-j") 'newline)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
