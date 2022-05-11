(use-package ansible
  :straight t)

(use-package ansible-doc
  :straight t
  :hook (ansible-mode . ansible-doc-mode))

(use-package jinja2-minor-mode
  :straight (jinja2-minor-mode :type git :host github :repo "krig/jinja2-minor-mode"))
