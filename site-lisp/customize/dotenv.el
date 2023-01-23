(require 'projectile)
(use-package dotenv-mode
  :straight t
  :mode ("\\.env\\.\(sample|example\)\\'" . dotenv-mode))

(use-package dotenv
  :straight (dotenv :type git :host github :repo "pkulev/dotenv.el")
  :config
  (defun dotenv-projectile-hook ()
   "Projectile hook."
   (dotenv-update-project-env (projectile-project-root)))

  (add-to-list 'projectile-after-switch-project-hook #'dotenv-projectile-hook))
