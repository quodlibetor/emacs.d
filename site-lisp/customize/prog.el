(use-package asdf
  :straight (asdf :type git :host github :repo "tabfugnic/asdf.el")
  :demand
  :config (asdf-enable)
  )

(defun add-todo-keywords ()
  (font-lock-add-keywords nil
                          '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXX\\)\\(([^)]+)\\)?:" 1 font-lock-warning-face t))))

(add-hook 'yaml-mode-hook
          #'add-todo-keywords)
(add-hook 'python-mode-hook
          #'add-todo-keywords)
(add-hook 'prog-mode-hook
          #'add-todo-keywords)
