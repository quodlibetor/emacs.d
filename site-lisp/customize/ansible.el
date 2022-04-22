(use-package ansible
  :straight t)

(use-package ansible-doc
  :straight t
  :hook (ansible-mode . ansible-doc-mode))
