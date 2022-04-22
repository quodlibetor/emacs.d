(defun bwm/configure-terraform ()
            (terraform-format-on-save-mode t)
            (lsp))

(use-package terraform-mode
  :straight t
  :hook bwm/configure-terraform)

