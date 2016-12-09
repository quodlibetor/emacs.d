(require 'rust-mode)
(require 'racer)
(require 'company)

(define-key rust-mode-map (kbd "C-j") 'bwm:sane-newline)
(define-key rust-mode-map (kbd "C-c h") 'racer-describe)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (setq-local company-minimum-prefix-length 0)))

(setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
(setq racer-rust-src-path (concat (getenv "HOME") "/src/rust/src"))
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
