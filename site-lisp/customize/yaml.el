(add-to-list 'auto-mode-alist
             '("\\.ya?ml$" . yaml-mode))

(add-hook 'yaml-mode-hook (lambda ()
                              (hack-local-variables)
                              (when (boundp 'project-venv-name)
                                (venv-workon project-venv-name)
                                (ansible-doc-mode))))
