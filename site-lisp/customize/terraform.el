(add-hook 'terraform-mode-hook
          (lambda ()
            (terraform-format-on-save-mode t)))
