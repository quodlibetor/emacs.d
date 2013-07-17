(eval-when-compile
  (require 'cl))

(defun bwm/list-app-dirs ()
  (let ((app-dirs nil))
    (dolist (code-dir (directory-files "~/projects" nil "^[^.]"))
      (setq app-dirs
            (cons `(,code-dir (filename . ,(concat (expand-file-name "~/projects") "/" code-dir)))
                  app-dirs)))
    app-dirs))

(setq ibuffer-saved-filter-groups
      (list
       (cons "verbose"
             (apply #'append
                    (bwm/list-app-dirs)
                    '((("code" (mode . python-mode))
                       ("wiki" (or
                                (mode . confluence-edit-mode)
                                (mode . confluence-mode)))
                       ("notes" (mode . org-mode))
                       ("emacs" (or
                                 (mode . emacs-lisp)
                                 (filename . "emacs.d/")))))))
       '("simple"
         ("code" (mode . python-mode))
         ("wiki" (or
                  (mode . confluence-edit-mode)
                  (mode . confluence-mode)))
         ("notes" (mode . org-mode))
         ("emacs" (or
                   (mode . emacs-lisp)
                   (filename . "emacs.d/"))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "verbose")))
