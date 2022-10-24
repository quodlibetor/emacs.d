(defun bwm/configure-terraform ()
            (terraform-format-on-save-mode t)
            ;(lsp) ;; terraform lsp seems like it might ruin emacs
            )

(use-package terraform-mode
  :straight t
  :hook (terraform-mode . bwm/configure-terraform))
