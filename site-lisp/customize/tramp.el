(require 'tramp)
(defun tramp-set-auto-save ()
  (auto-save-mode -1))

(setq tramp-default-method "ssh")
