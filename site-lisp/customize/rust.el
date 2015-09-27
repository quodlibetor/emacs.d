(require 'rust-mode)

(define-key rust-mode-map (kbd "C-j") 'bwm:sane-newline)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(setq racer-cmd (concat (getenv "HOME") "/src/racer/target/release/racer"))
(setq racer-rust-src-path (concat (getenv "HOME") "/src/rust/src"))
(add-hook 'racer-mode-hook #'company-mode)
