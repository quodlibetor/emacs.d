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
            (setq-local company-minimum-prefix-length 0)
            (setq-local compile-command "cargo check")))

(setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
(setq racer-rust-src-path (concat (getenv "HOME") "/src/rust/src"))
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)


;; override the cargo error message face to draw more attention to parts of the
;; buffer used for testing
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
             '(cargo "thread '\\([^']+\\)' panicked at \\('[^']+'\\), \\([^:]+\\):\\([0-9]+\\)"
                     3 4 nil nil 2 (1 'compilation-info)))

