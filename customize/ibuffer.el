(eval-when-compile
  (require 'cl))

(defun bwm/list-app-dirs ()
  (let ((app-dirs nil))
    (dolist (code-dir (directory-files "~/projects" nil "^[^.]"))
      (setq app-dirs
            (cons `(,code-dir (filename . ,(concat (expand-file-name "~/projects") "/" code-dir)))
                  app-dirs)))
    (reverse app-dirs)))

(setq ibuffer-show-empty-filter-groups nil)
(defun bwm/reload-ibuffer-filter-groups ()
  "Reload app-dirs"
  (setq ibuffer-saved-filter-groups
        (list
         (cons "verbose"
               (apply #'append
                      '(("Notes" (mode . org-mode))
                        ("Explore" (or (mode . compilation-mode)
                                       (name . "*nosetests*")
                                       (mode . grep-mode))))
                      (bwm/list-app-dirs)
                      '((("Code" (mode . python-mode))
                         ("Wiki" (or (mode . confluence-edit-mode)
                                     (mode . confluence-mode)))
                         ("Emacs" (or (mode . emacs-lisp)
                                      (filename . "emacs.d/")))
                         ("VC" (or (mode . magit-status-mode)
                                   (mode . magit-commit-mode)
                                   (mode . magit-log-mode)
                                   (mode . vc-annotate-mode)))
                         ("Dired" (mode . dired-mode))))))
         '("simple"
           ("Code" (mode . python-mode))
           ("Explore" (or (mode . compilation-mode)
                          (name . "*nosetests*")
                          (mode . grep-mode)))
           ("Wiki" (or (mode . confluence-edit-mode)
                       (mode . confluence-mode)))
           ("Notes" (mode . org-mode))
           ("Emacs" (or (mode . emacs-lisp)
                        (filename . "emacs.d/")))
           ("VC" (or (mode . magit-status-mode)
                     (mode . magit-commit-mode)
                     (mode . magit-log-mode)
                     (mode . vc-annotate-mode)))
           ("Dired" (mode . dired-mode))))))
(bwm/reload-ibuffer-filter-groups)

(defun bwm/ibuffer-update (arg &optional silent)
  (interactive "P")
  (bwm/reload-ibuffer-filter-groups)
  (ibuffer-update arg silent))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "verbose")
            (local-set-key "g" 'bwm/ibuffer-update)))
