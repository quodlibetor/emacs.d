(require 'go-mode)

(defun bwm/go-hook ()
  (setq tab-width 4)
            (add-hook 'before-save-hook #'lsp-format-buffer t t)
            (add-hook 'before-save-hook #'lsp-organize-imports t t)
            (lsp-register-custom-settings
             '(("gopls.completeUnimported" t t)
               ("gopls.staticcheck" t t)))
            (lsp))

(add-hook 'go-mode-hook #'bwm/go-hook)

(setenv "GOPATH" "/Users/bwm/go")
; exec-path is configured to include ~/go/bin via customize/ui's handling of path-from-shell
